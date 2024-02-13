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
    apiKey: 'AIzaSyBEt-Sql_Xq7fnuk3Sh_5vAZ-X6HeikzsU',
    appId: '1:621746795231:web:6c402c47a9cd1b7f612f6a',
    messagingSenderId: '621746795231',
    projectId: 'flix-pedia',
    authDomain: 'flix-pedia.firebaseapp.com',
    storageBucket: 'flix-pedia.appspot.com',
    measurementId: 'G-KWMS4BSTCW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD29tIVU_l9tns47ZLvm1VEZRpGKsPcBMU',
    appId: '1:621746795231:android:64adb84c80d606b6612f6a',
    messagingSenderId: '621746795231',
    projectId: 'flix-pedia',
    storageBucket: 'flix-pedia.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB693vgvYaReQvLseDkBasGv7dxwWuqkOo',
    appId: '1:621746795231:ios:ad776dd928ff8675612f6a',
    messagingSenderId: '621746795231',
    projectId: 'flix-pedia',
    storageBucket: 'flix-pedia.appspot.com',
    iosBundleId: 'com.example.flixpedia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB693vgvYaReQvLseDkBasGv7dxwWuqkOo',
    appId: '1:621746795231:ios:2466fbae97683c68612f6a',
    messagingSenderId: '621746795231',
    projectId: 'flix-pedia',
    storageBucket: 'flix-pedia.appspot.com',
    iosBundleId: 'com.example.flixpedia.RunnerTests',
  );
}
