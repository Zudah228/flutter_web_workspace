// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'document.dart';

final collectionRepositoryProvider = Provider<CollectionRepository>(
  (ref) => CollectionRepository(FirebaseFirestore.instance),
);

class CollectionRepository {
  CollectionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<SnapType> collectionRef(String collectionPath) =>
      _firestore.collection(collectionPath);

  Stream<QuerySnapshot<SnapType>?> snapshots(Query<SnapType> query) =>
      query.snapshots();
}
