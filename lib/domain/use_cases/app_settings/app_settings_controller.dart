import 'package:flutter_fire_app_template/domain/repositories/shared_preferences/shared_preferences_key.dart';
import 'package:flutter_fire_app_template/domain/repositories/shared_preferences/shared_preferences_repository.dart';

import 'states/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>(AppSettingsNotifier.new);

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier(this._ref) : super(AppSettings());

  final Ref _ref;

  SharedPreferencesRepository get _prefs =>
      _ref.watch(sharedPreferencesRepositoryProvider);

}
