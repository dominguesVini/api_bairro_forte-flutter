import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "<firebase_api_key> ",
            authDomain: "bairro-forte.firebaseapp.com",
            projectId: "bairro-forte",
            storageBucket: "bairro-forte.firebasestorage.app",
            messagingSenderId: "943223771904",
            appId: "1:943223771904:web:c6f896d5902509d303d9e5",
            measurementId: "G-KGS2EHB0Q9"));
  } else {
    await Firebase.initializeApp();
  }
}
