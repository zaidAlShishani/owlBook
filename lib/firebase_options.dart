// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCJwthWL4IG7I7PfYWVuorzcvV7k1jAPsk',
    appId: '1:462974737633:web:6f2a438885b349f0986ba0',
    messagingSenderId: '462974737633',
    projectId: 'finalp-8df9c',
    authDomain: 'finalp-8df9c.firebaseapp.com',
    databaseURL: 'https://finalp-8df9c-default-rtdb.firebaseio.com',
    storageBucket: 'finalp-8df9c.appspot.com',
    measurementId: 'G-775R6H10HX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBX2QgmwMQe-WyZ6pX8x3DhKL8FtxG2EgI',
    appId: '1:462974737633:android:9adb961f2b004dd9986ba0',
    messagingSenderId: '462974737633',
    projectId: 'finalp-8df9c',
    databaseURL: 'https://finalp-8df9c-default-rtdb.firebaseio.com',
    storageBucket: 'finalp-8df9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZcMkwsjgSJxND6WKn3G9_HnJ9VhdWFWc',
    appId: '1:462974737633:ios:37bb300d14724ae6986ba0',
    messagingSenderId: '462974737633',
    projectId: 'finalp-8df9c',
    databaseURL: 'https://finalp-8df9c-default-rtdb.firebaseio.com',
    storageBucket: 'finalp-8df9c.appspot.com',
    iosBundleId: 'com.example.homepage',
  );
}