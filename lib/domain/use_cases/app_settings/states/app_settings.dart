// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

@freezed
class AppSettings with _$AppSettings {
  const AppSettings._();
  factory AppSettings() = _AppSettings;
}
