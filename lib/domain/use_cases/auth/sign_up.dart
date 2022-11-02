// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:flutter_fire_app_template/common/utils/browser_api.dart';
import '../../../common/utils/logger.dart';
import '../../exceptions/app_exception.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final signUpProvider = Provider.autoDispose<SignUp>(
  SignUp.new,
);

class SignUp {
  SignUp(this._ref);

  final Ref _ref;
  late final firebaseAuth = _ref.watch(firebaseAuthRepositoryProvider);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
