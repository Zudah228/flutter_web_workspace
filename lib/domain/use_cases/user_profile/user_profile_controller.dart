// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../entities/user_profile/user_profile.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firebase_firestore/document_repository.dart';

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, UserProfile?>((ref) {
  return UserProfileController(ref);
});

class UserProfileController extends StateNotifier<UserProfile?> {
  UserProfileController(Ref ref)
      : _ref = ref,
        super(null);
  final Ref _ref;
  late final _authRepository = _ref.watch(firebaseAuthRepositoryProvider);
  late final _documentRepository = _ref.watch(documentRepositoryProvider);

  StreamSubscription? _disposer;
  @override
  void dispose() {
    _disposer?.cancel();
    super.dispose();
  }

  void listen() {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) {
      return;
    }
    _disposer = _documentRepository
        .snapshots(UserProfile.documentPath(uid))
        .listen((event) {
      final doc = event.data();
      if (doc == null) {
        state = null;
        return;
      }
      if (mounted) {
        state = UserProfile.fromJson(doc);
      }
    });
  }
}
