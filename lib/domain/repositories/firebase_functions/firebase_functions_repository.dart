// Package imports:
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseFunctionsProvider = Provider(
  (_) => FirebaseFunctionsRepository(
      FirebaseFunctions.instanceFor(region: 'asia-northeast1'),),
);

class FirebaseFunctionsRepository {
  FirebaseFunctionsRepository(this._functions);

  final FirebaseFunctions _functions;

  Future<T> callable<T>(
    String name, {
    Map<String, dynamic>? parameter,
    required T Function(Map<String, dynamic>) decode,
  }) async {
    final result = await _functions.httpsCallable(name).call(parameter);
    return decode(result.data());
  }
}
