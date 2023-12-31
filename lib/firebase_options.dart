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
        return macos;
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
    apiKey: 'AIzaSyBppmEEsydph4eiew2_hMhrt8RlTJsrCB0',
    appId: '1:108139679969:web:1f001dad883a4e4b7167a0',
    messagingSenderId: '108139679969',
    projectId: 'ssnvisitapp',
    authDomain: 'ssnvisitapp.firebaseapp.com',
    storageBucket: 'ssnvisitapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBx4ia-zv5uQPi5VY3M_1Tn8GHOnczJ2rk',
    appId: '1:108139679969:android:a961a1bea6a921e07167a0',
    messagingSenderId: '108139679969',
    projectId: 'ssnvisitapp',
    storageBucket: 'ssnvisitapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBxMdydCDw1s4nCNaf7mscAqa9Wvw-iYw',
    appId: '1:108139679969:ios:3b12cbb0e2699cba7167a0',
    messagingSenderId: '108139679969',
    projectId: 'ssnvisitapp',
    storageBucket: 'ssnvisitapp.appspot.com',
    iosBundleId: 'com.example.ssnvisitapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBxMdydCDw1s4nCNaf7mscAqa9Wvw-iYw',
    appId: '1:108139679969:ios:08bdcb3fa85a75ce7167a0',
    messagingSenderId: '108139679969',
    projectId: 'ssnvisitapp',
    storageBucket: 'ssnvisitapp.appspot.com',
    iosBundleId: 'com.example.ssnvisitapp.RunnerTests',
  );
}
