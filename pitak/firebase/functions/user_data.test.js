const {test} = require('node:test');
const assert = require('node:assert/strict');
const {deleteUserData} = require('./user_data');

function fixture() {
  const data = new Map(), files = [];
  const equal = (a,b) => a?.path ? a.path === b?.path : a === b;
  const db = {
    doc(path) { return {path, delete: async () => { data.delete(path); }}; },
    collection(name) {
      return {where(field, op, value) {
        return {limit(size) { return {async get() {
          const docs = [...data.entries()].filter(([path, record]) => path.split('/').length === 2 && path.startsWith(name+'/') &&
            (op === 'array-contains' ? record[field]?.some(item => equal(item,value)) : equal(record[field],value)))
            .slice(0,size).map(([path]) => ({ref:db.doc(path)}));
          return {docs,empty:docs.length===0};
        }}; }};
      }};
    },
    batch() {
      const actions=[];
      return {
        delete(ref) { actions.push(()=>data.delete(ref.path)); },
        update(ref, change) { actions.push(()=>{ const record=data.get(ref.path); record.isLike=record.isLike.filter(v=>!equal(v,change.isLike.remove)); }); },
        async commit() { actions.forEach(action=>action()); },
      };
    },
    async recursiveDelete(ref) { for(const path of data.keys()) if(path===ref.path || path.startsWith(ref.path+'/')) data.delete(path); },
  };
  const firestore=()=>db;
  firestore.FieldValue={arrayRemove:remove=>({remove})};
  let failStorage=false;
  const admin={firestore,storage:()=>({bucket:()=>({async deleteFiles(options){ if(failStorage) throw Error('Storage unavailable');files.push(options.prefix); }})})};
  const a=db.doc('users/alice'), b=db.doc('users/bob'), chat=db.doc('chats/pair');
  data.set(a.path,{uid:'alice'});data.set(b.path,{uid:'bob'});
  data.set('users/alice/blocks/bob',{});data.set('public_profiles/alice',{});
  data.set(chat.path,{users:[a,b]});
  data.set('chat_messages/shared',{chat,user:b});
  data.set('chat_messages/unrelated',{chat:db.doc('chats/other'),user:b});
  data.set('ob/other',{idUser:b,isLike:[a,b]});
  data.set('favoritUser/one',{iduser:a});
  data.set('disput/one',{idUser:a});
  for(let i=0;i<405;i++) data.set('ob/own'+i,{idUser:a});
  return {admin,data,files,setFailure:value=>{failStorage=value;}};
}

test('deletion handles multiple pages and preserves unrelated users and content',async()=>{
  const f=fixture();await deleteUserData(f.admin,'alice');
  assert.deepEqual([...f.data.keys()].sort(),['chat_messages/unrelated','ob/other','users/bob']);
  assert.deepEqual(f.data.get('ob/other').isLike.map(ref=>ref.path),['users/bob']);
  assert.deepEqual(f.files,['users/alice/']);
});
test('failed cleanup can be retried without losing discovery of remaining data',async()=>{
  const f=fixture(); f.setFailure(true);
  await assert.rejects(deleteUserData(f.admin,'alice'),/Storage unavailable/);
  assert.equal(f.data.has('users/alice'),true);
  f.setFailure(false);await deleteUserData(f.admin,'alice');await deleteUserData(f.admin,'alice');
  assert.equal(f.data.has('users/alice'),false);assert.equal(f.data.has('users/bob'),true);
});
test('malformed IDs cannot select another collection',async()=>{
  const f=fixture();await assert.rejects(deleteUserData(f.admin,'alice/other'),/Invalid user ID/);
  assert.equal(f.files.length,0);assert.equal(f.data.has('users/alice'),true);
});
