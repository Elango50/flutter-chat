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
    apiKey: 'AIzaSyClZJY21ffzSDwXiemSBftt_Bd-mRE_wQI',
    appId: '1:299677438681:web:0db062487623ed21af24c8',
    messagingSenderId: '299677438681',
    projectId: 'auth-5cf24',
    authDomain: 'auth-5cf24.firebaseapp.com',
    storageBucket: 'auth-5cf24.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9IRlcxzgMlMywoI8gD8ISzE2y4pyWWNo',
    appId: '1:299677438681:android:0a5aee5db745fbd4af24c8',
    messagingSenderId: '299677438681',
    projectId: 'auth-5cf24',
    storageBucket: 'auth-5cf24.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFfkbOe0RU7oOfovHRpSFDif57FQThBoE',
    appId: '1:299677438681:ios:922ed905ef5d1cb2af24c8',
    messagingSenderId: '299677438681',
    projectId: 'auth-5cf24',
    storageBucket: 'auth-5cf24.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFfkbOe0RU7oOfovHRpSFDif57FQThBoE',
    appId: '1:299677438681:ios:922ed905ef5d1cb2af24c8',
    messagingSenderId: '299677438681',
    projectId: 'auth-5cf24',
    storageBucket: 'auth-5cf24.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyClZJY21ffzSDwXiemSBftt_Bd-mRE_wQI',
    appId: '1:299677438681:web:d72ccf38eb75381daf24c8',
    messagingSenderId: '299677438681',
    projectId: 'auth-5cf24',
    authDomain: 'auth-5cf24.firebaseapp.com',
    storageBucket: 'auth-5cf24.appspot.com',
  );
}
