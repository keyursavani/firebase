import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBoCpkfa6TOYBFEOi51IK_9q2yO9blLpWQ',
    appId: '1:79778168609:web:c62401a6492d761db68860',
    messagingSenderId: '79778168609',
    projectId: 'fir-crud-operation-50e33',
    authDomain: 'fir-crud-operation-50e33.firebaseapp.com',
    storageBucket: 'fir-crud-operation-50e33.appspot.com',
    measurementId: 'G-41SMZMF8VR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuh7xR8kKyXFovMP7R84qbBQG4u-xlUqw',
    appId: '1:79778168609:android:edb69a47eb52bd74b68860',
    messagingSenderId: '79778168609',
    projectId: 'fir-crud-operation-50e33',
    storageBucket: 'fir-crud-operation-50e33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVhMuHnkuVmar83IdRF4-89v9HVNDbr3o',
    appId: '1:79778168609:ios:1c9d5e808f98cab1b68860',
    messagingSenderId: '79778168609',
    projectId: 'fir-crud-operation-50e33',
    storageBucket: 'fir-crud-operation-50e33.appspot.com',
    iosBundleId: 'com.savani.firebaseCrudOperation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVhMuHnkuVmar83IdRF4-89v9HVNDbr3o',
    appId: '1:79778168609:ios:94696acfa988aefcb68860',
    messagingSenderId: '79778168609',
    projectId: 'fir-crud-operation-50e33',
    storageBucket: 'fir-crud-operation-50e33.appspot.com',
    iosBundleId: 'com.savani.firebaseCrudOperation.RunnerTests',
  );
}
