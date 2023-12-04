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
 //  options: DefaultFirebaseOptions.currentPlatform,
  ///);
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
    apiKey: 'AIzaSyCNT_Prr7DPT4IZt5Pa9-ml__CJGjA2bPg',
    appId: '1:332637340330:web:d4aa2f2e51af222ab186d3',
    messagingSenderId: '332637340330',
    projectId: 'mob-develop',
    authDomain: 'mob-develop.firebaseapp.com',
    storageBucket: 'mob-develop.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBs1vxc4c0-_d9tYgiTw5X90MGPT7BzGI4',
    appId: '1:332637340330:android:96d2102bf1129a48b186d3',
    messagingSenderId: '332637340330',
    projectId: 'mob-develop',
    storageBucket: 'mob-develop.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQWR7Z9fUcsv5iSOlIpJD40vu7fpj8RbA',
    appId: '1:332637340330:ios:1ea66bc56957e0b1b186d3',
    messagingSenderId: '332637340330',
    projectId: 'mob-develop',
    storageBucket: 'mob-develop.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQWR7Z9fUcsv5iSOlIpJD40vu7fpj8RbA',
    appId: '1:332637340330:ios:d785fc6f21c23100b186d3',
    messagingSenderId: '332637340330',
    projectId: 'mob-develop',
    storageBucket: 'mob-develop.appspot.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}