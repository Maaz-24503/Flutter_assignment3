// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBZA456uVfo0NEhomlvoBSVj7STZgNDZGw',
    appId: '1:988031879760:web:e1f27f8c76f171ffec9f55',
    messagingSenderId: '988031879760',
    projectId: 'assignment3-b7033',
    authDomain: 'assignment3-b7033.firebaseapp.com',
    databaseURL: 'https://assignment3-b7033-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'assignment3-b7033.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPd9un6-fEq_JGVnPdPWztzU4WFnlRFSA',
    appId: '1:988031879760:android:eb7d4be40ca79718ec9f55',
    messagingSenderId: '988031879760',
    projectId: 'assignment3-b7033',
    databaseURL: 'https://assignment3-b7033-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'assignment3-b7033.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5zhz9D5tt_npOiZLPoDl8l_i9GVlNsaI',
    appId: '1:988031879760:ios:3cf6b5fa5a8fed52ec9f55',
    messagingSenderId: '988031879760',
    projectId: 'assignment3-b7033',
    databaseURL: 'https://assignment3-b7033-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'assignment3-b7033.appspot.com',
    iosBundleId: 'com.example.fbase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5zhz9D5tt_npOiZLPoDl8l_i9GVlNsaI',
    appId: '1:988031879760:ios:3cf6b5fa5a8fed52ec9f55',
    messagingSenderId: '988031879760',
    projectId: 'assignment3-b7033',
    databaseURL: 'https://assignment3-b7033-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'assignment3-b7033.appspot.com',
    iosBundleId: 'com.example.fbase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBZA456uVfo0NEhomlvoBSVj7STZgNDZGw',
    appId: '1:988031879760:web:bd13f6fd1b4c6185ec9f55',
    messagingSenderId: '988031879760',
    projectId: 'assignment3-b7033',
    authDomain: 'assignment3-b7033.firebaseapp.com',
    databaseURL: 'https://assignment3-b7033-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'assignment3-b7033.appspot.com',
  );
}
