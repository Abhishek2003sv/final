import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'FirebaseOptions have not been configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDI-iQiRatwDaMEnsJj6ku5kvUuEIM9ULw",

  authDomain: "myflutterapp-f60b3.firebaseapp.com",

  projectId: "myflutterapp-f60b3",

  storageBucket: "myflutterapp-f60b3.firebasestorage.app",

  messagingSenderId: "248824650721",

  appId: "1:248824650721:web:9965e6125459f1f6c450a0",

  measurementId: "G-ZCRD9VFZQV"

  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDI-iQiRatwDaMEnsJj6ku5kvUuEIM9ULw",

  storageBucket: "myflutterapp-f60b3.firebasestorage.app",

  messagingSenderId: "248824650721",

  appId: "1:248824650721:web:9965e6125459f1f6c450a0", projectId: "myflutterapp-f60b3",


  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "YOUR_IOS_API_KEY",
    appId: "YOUR_IOS_APP_ID",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "YOUR_MACOS_API_KEY",
    appId: "YOUR_MACOS_APP_ID",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
  );
}
