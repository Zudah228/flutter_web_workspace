// Dart imports:
import 'dart:async';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>((_) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
});

class FirebaseAuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<String?> get idToken async {
    return _auth.currentUser?.getIdToken(true);
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password,);
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() => _auth.signOut();
}
