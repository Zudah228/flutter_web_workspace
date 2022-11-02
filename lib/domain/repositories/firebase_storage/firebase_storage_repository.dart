// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Package imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseStorageRepositoryProvider =
    Provider<FirebaseStorageRepository>((ref) {
  return FirebaseStorageRepository(FirebaseStorage.instance);
});

const mimeTypeApplicationOctetStream = 'application/octet-stream';

class FirebaseStorageRepository {
  FirebaseStorageRepository(this._storage);

  final FirebaseStorage _storage;

  Future<String> save(
    Uint8List data, {
    required String dirPath,
    required String filename,
    String? cacheControl,
    String mimeType = mimeTypeApplicationOctetStream,
    Map<String, String> metadata = const <String, String>{},
  }) async {
    final path = '$dirPath/$filename';
    final ref = _storage.ref().child(path);
    final uploadTask = ref.putData(
      data,
      SettableMetadata(
        cacheControl: cacheControl,
        contentType: mimeType,
        customMetadata: metadata,
      ),
    );
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> gerDownloadUrl(String dirPath, String filename) =>
      _storage.ref().child('$dirPath/$filename').getDownloadURL();

  Future<Uint8List?> getData(String path) =>
      _storage.ref().child(path).getData();

  Future<void> delete(String path) => _storage.ref().child(path).delete();
}
