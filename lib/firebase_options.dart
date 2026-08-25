import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // Return web as a fallback for now since we only have web config
    // You should generate full options using flutterfire configure later
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAThzBrfMvJtnBBOts6wvvyM2iSTK7cIOE',
    appId: '1:611309344543:web:c32b31917e0cdb9ac5c22a',
    messagingSenderId: '611309344543',
    projectId: 'rz76iyn001jpfxc8gbrd4mg17l89nc',
    authDomain: 'rz76iyn001jpfxc8gbrd4mg17l89nc.firebaseapp.com',
    storageBucket: 'rz76iyn001jpfxc8gbrd4mg17l89nc.firebasestorage.app',
  );
}
