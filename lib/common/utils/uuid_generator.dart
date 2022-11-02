// Package imports:
import 'package:hashids2/hashids2.dart';
import 'package:uuid/uuid.dart';

class UuidGenerator {
  const UuidGenerator._();
  static String create({int length = 12}) {
    final hashIds = HashIds(
      salt: const Uuid().v4(),
      minHashLength: length,
      alphabet:
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
    );
    final id = hashIds.encode([1, 2, 3]);
    return id;
  }

  static String get long => const Uuid().v4();
}
