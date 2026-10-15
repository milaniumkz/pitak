const {test, before, after, beforeEach} = require('node:test');
const fs = require('node:fs');
const {initializeTestEnvironment, assertSucceeds, assertFails} = require('@firebase/rules-unit-testing');
const {doc, getDoc, setDoc, updateDoc, deleteDoc, collection, getDocs, query, where} = require('firebase/firestore');
let env;
const uidA = 'alice', uidB = 'bob';
const adminUid = 'kfqg1wiE1uNbOMz1u8wDCuAbmOB3';
const db = (uid) => uid ? env.authenticatedContext(uid, {phone_number: '+71111111111'}).firestore() : env.unauthenticatedContext().firestore();
before(async () => { env = await initializeTestEnvironment({projectId:'demo-pitak',firestore:{host:'127.0.0.1',port:8087,rules:fs.readFileSync(__dirname+'/firestore.rules','utf8')}}); });
after(async () => { await env?.cleanup(); });
beforeEach(async () => {
  await env.clearFirestore();
  await env.withSecurityRulesDisabled(async (context) => {
    const d = context.firestore(), a = doc(d,'users/alice'), b = doc(d,'users/bob');
    await Promise.all([
      setDoc(a,{uid:uidA,display_name:'Alice',phone_number:'+71111111111'}),
      setDoc(b,{uid:uidB,display_name:'Bob',phone_number:'+72222222222'}),
      setDoc(doc(d,'public_profiles/bob'),{display_name:'Bob',photo_url:''}),
      setDoc(doc(d,'ob/public'),{idUser:b,status:1,title:'Техника',text:'Описание',isLike:[]}),
      setDoc(doc(d,'ob/private'),{idUser:b,status:2,title:'На проверке',text:'Описание'}),
      setDoc(doc(d,'chats/pair'),{users:[a,b],user_a:a,user_b:b}),
    ]);
  });
});
test('anonymous users can browse approved ads but cannot list all ads',async()=>{
  const d=db(); await assertSucceeds(getDocs(query(collection(d,'ob'),where('status','==',1))));
  await assertFails(getDocs(collection(d,'ob'))); await assertFails(getDoc(doc(d,'ob/private')));
});
test('private profiles are accessible only to their owner and administrators',async()=>{
  await assertFails(getDoc(doc(db(),'users/bob'))); await assertFails(getDoc(doc(db(uidA),'users/bob')));
  await assertSucceeds(getDoc(doc(db(uidB),'users/bob'))); await assertSucceeds(getDoc(doc(db(adminUid),'users/bob')));
  await assertSucceeds(getDoc(doc(db(),'public_profiles/bob')));
});
test('users cannot grant themselves administrator rights or change another profile',async()=>{
  await assertFails(updateDoc(doc(db(uidA),'users/alice'),{admin:true}));
  await assertFails(updateDoc(doc(db(uidA),'users/bob'),{display_name:'Changed'}));
  await assertSucceeds(updateDoc(doc(db(uidA),'users/alice'),{display_name:'My name'}));
});
test('new profiles cannot forge their identity or phone number',async()=>{
  const d=db('newuser');
  await assertFails(setDoc(doc(d,'users/newuser'),{uid:'newuser',phone_number:'+79999999999'}));
  await assertSucceeds(setDoc(doc(d,'users/newuser'),{uid:'newuser',phone_number:'+71111111111'}));
});
test('new ads require moderation and cannot impersonate another author',async()=>{
  const d=db(uidA), ad={idUser:doc(d,'users/alice'),status:2,title:'Газель',text:'Перевозки',phone:'+71111111111'};
  await assertSucceeds(setDoc(doc(d,'ob/new'),ad));
  await assertFails(setDoc(doc(d,'ob/published'),{...ad,status:1}));
  await assertFails(setDoc(doc(d,'ob/forged'),{...ad,idUser:doc(d,'users/bob')}));
});
test('only the author or administrator can remove an ad',async()=>{
  await assertFails(deleteDoc(doc(db(uidA),'ob/public')));
  await assertSucceeds(deleteDoc(doc(db(uidB),'ob/public')));
});
test('favorites can change only the requesting users own entry',async()=>{
  const d=db(uidA); await assertSucceeds(updateDoc(doc(d,'ob/public'),{isLike:[doc(d,'users/alice')]}));
  await assertFails(updateDoc(doc(d,'ob/public'),{isLike:[doc(d,'users/bob')]}));
  await assertSucceeds(updateDoc(doc(d,'ob/public'),{isLike:[]}));
});
test('chat access is limited to participants, and membership cannot be changed',async()=>{
  await assertFails(getDoc(doc(db('eve'),'chats/pair')));
  await assertSucceeds(getDoc(doc(db(uidA),'chats/pair')));
  const d=db(uidA); await assertFails(updateDoc(doc(d,'chats/pair'),{users:[doc(d,'users/alice'),doc(d,'users/eve')]}));
});
test('blocking stops new messages in both directions',async()=>{
  const a=db(uidA), b=db(uidB);
  const message=(d,uid)=>({user:doc(d,'users/'+uid),chat:doc(d,'chats/pair'),text:'Привет'});
  await assertSucceeds(setDoc(doc(a,'chat_messages/first'),message(a,uidA)));
  await assertSucceeds(setDoc(doc(a,'users/alice/blocks/bob'),{createdAt:new Date()}));
  await assertFails(setDoc(doc(b,'chat_messages/blocked'),message(b,uidB)));
  await assertFails(setDoc(doc(a,'chat_messages/reverse'),message(a,uidA)));
});
test('reports cannot be forged or read by other users',async()=>{
  const d=db(uidA); await assertSucceeds(setDoc(doc(d,'disput/report'),{idUser:doc(d,'users/alice'),text:'Жалоба',idOb:doc(d,'ob/public')}));
  await assertFails(setDoc(doc(d,'disput/forged'),{idUser:doc(d,'users/bob'),text:'Жалоба'}));
  await assertFails(getDoc(doc(db(uidB),'disput/report')));
  await assertSucceeds(getDoc(doc(db(adminUid),'disput/report')));
});
