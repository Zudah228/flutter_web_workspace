// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'document.dart';

final collectionPagingRepositoryProvider = Provider.family
    .autoDispose<CollectionPagingRepository, CollectionParam>((ref, query) {
  return CollectionPagingRepository(
    query: query.query,
    limit: query.limit,
    decode: query.decode,
  );
});

class CollectionParam<T extends Object> {
  CollectionParam({
    required this.query,
    this.limit,
    required this.decode,
  });
  final Query<Map<String, dynamic>> query;
  final int? limit;
  final T Function(Map<String, dynamic>) decode;
}

class CollectionPagingRepository<T extends Object> {
  CollectionPagingRepository({
    required this.query,
    this.limit,
    required this.decode,
  });

  final Query<Map<String, dynamic>> query;
  final int? limit;
  final T Function(Map<String, dynamic>) decode;
  DocumentSnapshot<Map<String, dynamic>>? _startAfterDocument;

  Future<List<Document<T>>> fetch({
    Source source = Source.serverAndCache,
    void Function(List<Document<T>>)? fromCache,
  }) async {
    if (fromCache != null) {
      try {
        final cacheDocuments = await _fetch(source: Source.cache);
        fromCache(
          cacheDocuments
              .map(
                (e) => Document(
                  ref: e.reference,
                  exists: e.exists,
                  entity: e.exists ? decode(e.data()!) : null,
                ),
              )
              .toList(),
        );
      } on Exception catch (_) {
        fromCache([]);
      }
    }
    final documents = await _fetch(source: source);
    return documents
        .map(
          (e) => Document(
            ref: e.reference,
            exists: e.exists,
            entity: e.exists ? decode(e.data()!) : null,
          ),
        )
        .toList();
  }

  Future<List<Document<T>>> fetchMore({
    Source source = Source.serverAndCache,
  }) async {
    final documents =
        await _fetch(source: source, startAfterDocument: _startAfterDocument);
    return documents
        .map(
          (e) => Document(
            ref: e.reference,
            exists: e.exists,
            entity: e.exists ? decode(e.data()!) : null,
          ),
        )
        .toList();
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _fetch({
    Source source = Source.serverAndCache,
    DocumentSnapshot? startAfterDocument,
  }) async {
    var dataSource = query;
    if (limit != null) {
      dataSource = dataSource.limit(limit!);
    }
    if (startAfterDocument != null) {
      dataSource = dataSource.startAfterDocument(startAfterDocument);
    }
    final result = await dataSource.get(GetOptions(source: source));
    final documents = result.docs.toList();

    if (documents.isNotEmpty) {
      _startAfterDocument = documents.last;
    }
    return documents;
  }
}
