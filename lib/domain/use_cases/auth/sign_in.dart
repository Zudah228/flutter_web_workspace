// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../common/index.dart';
import '../../exceptions/app_exception.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final signInProvider = Provider<SignIn>(
  SignIn.new,
);

class SignIn {
  SignIn(Ref ref) : _ref = ref;

  final Ref _ref;
  late final firebaseAuth = _ref.watch(firebaseAuthRepositoryProvider);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.info('sign in');
    } on FirebaseAuthException catch (e) {
      logger.shout(e);
      browserApi.alert(e.message ?? kUnexpectedErrorMessage);
      rethrow;
    } catch (e) {
      logger.shout(e);
      browserApi.alert(kUnexpectedErrorMessage);
      rethrow;
    }
  }
}
