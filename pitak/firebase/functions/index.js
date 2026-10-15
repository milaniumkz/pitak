const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const {deleteUserData} = require("./user_data");
admin.initializeApp();

exports.onUserDeleted = functions.runWith({serviceAccount: "pitak-8dfc0@appspot.gserviceaccount.com", timeoutSeconds: 540, memory: "512MB", maxInstances: 2, failurePolicy: true})
  .auth.user().onDelete((user) => deleteUserData(admin, user.uid));

exports.syncPublicProfile = functions.runWith({serviceAccount: "pitak-8dfc0@appspot.gserviceaccount.com", maxInstances: 2, failurePolicy: true})
  .firestore.document("users/{uid}").onWrite(async (_, context) => {
    const uid = context.params.uid;
    const db = admin.firestore();
    const profile = db.doc(`public_profiles/${uid}`);
    const current = await db.doc(`users/${uid}`).get();
    if (!current.exists) return profile.delete();
    try { await admin.auth().getUser(uid); }
    catch (error) {
      if (error.code === "auth/user-not-found") return profile.delete();
      throw error;
    }
    const data = current.data();
    return profile.set({display_name: data.display_name || "Пользователь", photo_url: data.photo_url || ""});
  });
