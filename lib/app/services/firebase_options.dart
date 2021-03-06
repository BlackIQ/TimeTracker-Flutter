// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqSfr9QifEBMyR54BZq6eJqR8ErfCD2Fk',
    appId: '1:6247733141:android:11d92dfb287c12c074489c',
    messagingSenderId: '6247733141',
    projectId: 'time-tracker-f3ebc',
    storageBucket: 'time-tracker-f3ebc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIN-TB2B10MObJXmEsjr6KQkUsQrJ2Xc8',
    appId: '1:6247733141:ios:aa5a70c04529f3bb74489c',
    messagingSenderId: '6247733141',
    projectId: 'time-tracker-f3ebc',
    storageBucket: 'time-tracker-f3ebc.appspot.com',
    androidClientId: '6247733141-g18k510a8vd567lf77n38vc8o2goh6uq.apps.googleusercontent.com',
    iosClientId: '6247733141-2lpposbhoai2vla3hv16k296ul9e30vu.apps.googleusercontent.com',
    iosBundleId: 'i',
  );
}
