import 'package:form_validator/form_validator.dart';

/// ValidationBuilder の拡張
extension ValidationBuilderExtension on ValidationBuilder {
  ValidationBuilder length(int length, [String? message]) => add(
        (value) => value == null
            ? null
            : value.length == length
                ? null
                : (message ?? '$length文字で入力してください'),
      );
  ValidationBuilder number([String? message]) => add(
        (value) => value == null
            ? null
            : RegExp(r'^[0-9]+$').hasMatch(value)
                ? null
                : (message ?? '数字で入力してください'),
      );
  ValidationBuilder match(String v, [String? message]) => add(
        (value) => value == null
            ? null
            : v == value
                ? null
                : (message ?? '異なっています'),
      );
}
