// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'app.dart';
import 'common/utils/init_firebase.dart';
import 'common/utils/logger.dart';
import 'domain/repositories/package_info/package_info_repository.dart';
import 'domain/repositories/shared_preferences/shared_preferences_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.configure();
  late final PackageInfo packageInfo;
  late final SharedPreferences sharedPreferences;

  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    InitFirebase.initFirebase(),
    Future(() async {
      packageInfo = await PackageInfo.fromPlatform();
    }),
    Future(() async {
      sharedPreferences = await SharedPreferences.getInstance();
    }),
  ]).catchError((Object e) {
    logger.shout(e);
  });

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesRepositoryProvider
            .overrideWithValue(SharedPreferencesRepository(sharedPreferences)),
        packageInfoRepositoryProvider
            .overrideWithValue(PackageInfoRepository(packageInfo)),
      ],
      child: const App(),
    ),
  );
}
