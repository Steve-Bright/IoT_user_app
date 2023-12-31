// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBXCGatsRQybHqIKsZm2Qf60APKrIiYExk',
    appId: '1:227427759096:web:e188b22d81871fdc6f9c0d',
    messagingSenderId: '227427759096',
    projectId: 'iotweb-c6665',
    authDomain: 'iotweb-c6665.firebaseapp.com',
    databaseURL: 'https://iotweb-c6665-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'iotweb-c6665.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWkpnas5geggGLSYrHkHtsW_4bRtOS6VM',
    appId: '1:227427759096:android:9f84f9121f7c81876f9c0d',
    messagingSenderId: '227427759096',
    projectId: 'iotweb-c6665',
    databaseURL: 'https://iotweb-c6665-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'iotweb-c6665.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwp3iljyNY7TDwHrgteP7ogYK0-df2kbg',
    appId: '1:227427759096:ios:1ceaf628f84de3a66f9c0d',
    messagingSenderId: '227427759096',
    projectId: 'iotweb-c6665',
    databaseURL: 'https://iotweb-c6665-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'iotweb-c6665.appspot.com',
    iosBundleId: 'com.example.iotAndroid',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwp3iljyNY7TDwHrgteP7ogYK0-df2kbg',
    appId: '1:227427759096:ios:0ff6690b6b43f7716f9c0d',
    messagingSenderId: '227427759096',
    projectId: 'iotweb-c6665',
    databaseURL: 'https://iotweb-c6665-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'iotweb-c6665.appspot.com',
    iosBundleId: 'com.example.iotAndroid.RunnerTests',
  );
}
