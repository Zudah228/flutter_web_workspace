// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Project imports:
import 'package:flutter_fire_app_template/common/utils/env.dart';
import 'package:flutter_fire_app_template/firebase_options.dart';

class InitFirebase {
  InitFirebase._();

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

    if (kIsFirebaseEmulator) {
      await _useFirebaseEmulator('localhost');
    }
  }

  static Future<void> _useFirebaseEmulator(String host) async {
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    await FirebaseStorage.instance.useStorageEmulator(host, 9199);
  }
}
