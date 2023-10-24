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
    apiKey: 'AIzaSyAy3HWqPIsqHvrVwy3xOTyM_adlsrXPUEY',
    appId: '1:1030511699581:web:604ece7804aa4d0fd47314',
    messagingSenderId: '1030511699581',
    projectId: 'avventoradioflutter',
    authDomain: 'avventoradioflutter.firebaseapp.com',
    storageBucket: 'avventoradioflutter.appspot.com',
    measurementId: 'G-EMCMBM3SHQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUwjUkI_Mm0aAy35r1urpGTYmbbR-z-qE',
    appId: '1:1030511699581:android:e7416257320b3872d47314',
    messagingSenderId: '1030511699581',
    projectId: 'avventoradioflutter',
    storageBucket: 'avventoradioflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5Dl9Rl47--N0hC3MMFduvCwnRD18VVIo',
    appId: '1:1030511699581:ios:cb5f6a8d1089f5d1d47314',
    messagingSenderId: '1030511699581',
    projectId: 'avventoradioflutter',
    storageBucket: 'avventoradioflutter.appspot.com',
    iosBundleId: 'media.avventohome.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5Dl9Rl47--N0hC3MMFduvCwnRD18VVIo',
    appId: '1:1030511699581:ios:53eba5b7c9be03abd47314',
    messagingSenderId: '1030511699581',
    projectId: 'avventoradioflutter',
    storageBucket: 'avventoradioflutter.appspot.com',
    iosBundleId: 'media.avventohome.app.RunnerTests',
  );
}
