// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../repositories/shared_preferences/shared_preferences_repository.dart';
import 'states/app_settings.dart';

final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>(AppSettingsNotifier.new);

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier(this._ref) : super(AppSettings());

  final Ref _ref;

  SharedPreferencesRepository get _prefs =>
      _ref.watch(sharedPreferencesRepositoryProvider);

}
