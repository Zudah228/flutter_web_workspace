// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();
  factory UserProfile({
    required String? imageUrl,
    required String name,
    int? bookCount,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  static get collectionPath => 'users';
  static documentPath(
    String uid,
  ) =>
      '${UserProfile.collectionPath}/$uid';
  static storageProfileDirPath(String uid) => 'users/$uid/profile';
  static get storageProfileFileName => 'icon.png';

  Map<String, dynamic> toUpdateDoc() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
