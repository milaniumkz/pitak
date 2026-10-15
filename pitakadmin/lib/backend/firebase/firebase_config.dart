import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyActMn1bWoUn_4E7dGx4-TOXvZ53qMAb8k",
            authDomain: "pitak-8dfc0.firebaseapp.com",
            projectId: "pitak-8dfc0",
            storageBucket: "pitak-8dfc0.appspot.com",
            messagingSenderId: "120486921864",
            appId: "1:120486921864:web:622417cad319aacb70413d"));
  } else {
    await Firebase.initializeApp();
  }
}
