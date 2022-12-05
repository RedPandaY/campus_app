// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'package:campus_app/utils/constants.dart';

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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static FirebaseOptions android = FirebaseOptions(
    apiKey: firebaseAndroidApiKey,
    appId: '1:330477020905:android:1ee464b1393089d8527278',
    messagingSenderId: '330477020905',
    projectId: 'campus-app-asta-rub',
    storageBucket: 'campus-app-asta-rub.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: firebaseIosApiKey,
    appId: '1:330477020905:ios:bbf2276d2c84380d527278',
    messagingSenderId: '330477020905',
    projectId: 'campus-app-asta-rub',
    storageBucket: 'campus-app-asta-rub.appspot.com',
    iosClientId: '330477020905-ie1vqe43juhpr8tiid6tfhtn44k6s8s2.apps.googleusercontent.com',
    iosBundleId: 'de.astaBochum.campusApp',
  );
}
