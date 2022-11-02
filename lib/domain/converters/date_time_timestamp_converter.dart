// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeTimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeTimestampConverter();

  @override
  DateTime fromJson(Timestamp value) => value.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}

class NullableDateTimeTimestampConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const NullableDateTimeTimestampConverter();

  @override
  DateTime? fromJson(Timestamp? value) => value?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp?.fromDate(object);
}

class UpdatedAtConverter
    implements JsonConverter<DateTime, FieldValue> {
  const UpdatedAtConverter();

  @override
  DateTime fromJson(FieldValue value) => (value as Timestamp).toDate();

  @override
  FieldValue toJson(DateTime object) => FieldValue.serverTimestamp();
}
class CreatedAtConverter
    implements JsonConverter<DateTime?, dynamic> {
  const CreatedAtConverter();

  @override
  DateTime fromJson(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }
    return (value as Timestamp).toDate();
  }

  @override
  dynamic toJson(DateTime? object) {
    if (object != null) {
      return Timestamp.fromDate(object);
    }
    return FieldValue.serverTimestamp();
  }
}
