// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../entities/user_profile/user_profile.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firebase_firestore/document_repository.dart';
import '../../repositories/firebase_storage/firebase_storage_repository.dart';
import '../index.dart';

final saveUserProfileProvider = Provider<SaveProfile>(
  SaveProfile.new,
);

class SaveProfile {
  SaveProfile(Ref ref) : _ref = ref;

  final Ref _ref;
  late final currentProfile = _ref.watch(userProfileControllerProvider);
  late final _documentRepository = _ref.watch(documentRepositoryProvider);
  late final _storageRepository = _ref.watch(firebaseStorageRepositoryProvider);
  late final _uid = _ref.watch(firebaseAuthRepositoryProvider).currentUser?.uid;

  Future<void> update({
    required Uint8List? imageFile,
    required String name,
  }) async {
    final url = imageFile == null
        ? currentProfile?.imageUrl
        : await _storageRepository.save(
            imageFile,
            dirPath: UserProfile.storageProfileDirPath(_uid!),
            filename: UserProfile.storageProfileFileName,
          );

    final item = UserProfile(
      imageUrl: url,
      name: name,
    );

    await _documentRepository.save(
      UserProfile.documentPath(_uid!),
      data: item.toUpdateDoc(),
    );
  }
}
