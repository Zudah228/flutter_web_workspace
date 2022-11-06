// Package imports:
import 'package:form_validator/form_validator.dart';

/// form_validator に標準で搭載されているバリデーションのエラーメッセージを上書き
/// runApp の前に setLocale を実行
class CustomValidatorLocale extends FormValidatorLocale {
  static setLocale() {
    ValidationBuilder.globalLocale = CustomValidatorLocale();
  }

  @override
  String required() => '必須入力です';

  @override
  String maxLength(String v, int n) => '$n文字までしか入力できません';

  @override
  String minLength(String v, int n) => '$n文字まで入力してください';

  @override
  String name() => ValidationBuilder.globalLocale.name();

  @override
  String email(String v) {
    return ValidationBuilder.globalLocale.email(v);
  }

  @override
  String ip(String v) {
    return ValidationBuilder.globalLocale.ip(v);
  }

  @override
  String ipv6(String v) {
    return ValidationBuilder.globalLocale.ipv6(v);
  }

  @override
  String phoneNumber(String v) {
    return ValidationBuilder.globalLocale.phoneNumber(v);
  }

  @override
  String url(String v) {
    return ValidationBuilder.globalLocale.url(v);
  }
}
