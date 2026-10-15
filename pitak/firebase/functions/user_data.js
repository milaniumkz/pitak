async function deleteQuery(db, query) {
  while (true) {
    const page = await query.limit(400).get();
    if (page.empty) return;
    const batch = db.batch();
    page.docs.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
  }
}

async function deleteUserData(admin, uid) {
  if (typeof uid !== "string" || !uid || uid.includes("/")) throw new Error("Invalid user ID");
  const db = admin.firestore();
  const user = db.doc(`users/${uid}`);
  // Keep chat documents until all their messages have been removed, so retries
  // can still discover a partially cleaned conversation.
  while (true) {
    const chats = await db.collection("chats").where("users", "array-contains", user).limit(50).get();
    if (chats.empty) break;
    for (const chat of chats.docs) {
      await deleteQuery(db, db.collection("chat_messages").where("chat", "==", chat.ref));
      await chat.ref.delete();
    }
  }
  for (const [collection, field] of [["ob", "idUser"], ["favoritUser", "iduser"], ["chat_messages", "user"], ["disput", "idUser"], ["disput", "reportedUser"], ["ff_user_push_notifications", "sender"]]) {
    await deleteQuery(db, db.collection(collection).where(field, "==", user));
  }
  while (true) {
    const likes = await db.collection("ob").where("isLike", "array-contains", user).limit(400).get();
    if (likes.empty) break;
    const batch = db.batch();
    likes.docs.forEach((doc) => batch.update(doc.ref, {isLike: admin.firestore.FieldValue.arrayRemove(user)}));
    await batch.commit();
  }
  await admin.storage().bucket().deleteFiles({prefix: `users/${uid}/`, force: true});
  await db.recursiveDelete(user);
  await db.doc(`public_profiles/${uid}`).delete();
}

module.exports = {deleteQuery, deleteUserData};
