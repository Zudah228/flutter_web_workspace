// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'common/providers/app_theme.dart';
import 'presentation/res/app_theme.dart';
import 'presentation/res/routes.dart';
import 'common/providers/shortcuts.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Web Workspace',
      debugShowCheckedModeBanner: false,
      shortcuts: ref.watch(shortcutsProvider),
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) {
        return child!;
      },
      theme: ref.watch(appThemeProvider) == ThemeType.dark
          ? appThemeDark
          : appTheme,
      // darkTheme: ref.watch(appThemeProvider) == ThemeType.basic
      //     ? appTheme
      //     : appThemeDark,
    );
  }
}
