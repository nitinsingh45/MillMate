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
    apiKey: 'AIzaSyDIZgpdlExbJUNhIy14GCWuyblTteOF5r0',
    appId: '1:913710783654:web:31fabb273e9df812f6a867',
    messagingSenderId: '913710783654',
    projectId: 'millmate-73d81',
    authDomain: 'millmate-73d81.firebaseapp.com',
    storageBucket: 'millmate-73d81.appspot.com',
    measurementId: 'G-KNGT45K8MV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAeiVeiCuQ8vj-WCi9ursfJ0qMRUHmWQWY',
    appId: '1:913710783654:android:6afa61fdc626f425f6a867',
    messagingSenderId: '913710783654',
    projectId: 'millmate-73d81',
    storageBucket: 'millmate-73d81.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9wIMn3LLrlT4l5P-_5PUivIKLAxR75KM',
    appId: '1:913710783654:ios:9d6f84eacb76029df6a867',
    messagingSenderId: '913710783654',
    projectId: 'millmate-73d81',
    storageBucket: 'millmate-73d81.appspot.com',
    iosBundleId: 'com.example.millmate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9wIMn3LLrlT4l5P-_5PUivIKLAxR75KM',
    appId: '1:913710783654:ios:9d6f84eacb76029df6a867',
    messagingSenderId: '913710783654',
    projectId: 'millmate-73d81',
    storageBucket: 'millmate-73d81.appspot.com',
    iosBundleId: 'com.example.millmate',
  );
}
