// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:flutter_fire_app_template/presentation/widgets/shortcut_focus.dart';
import 'common/providers/app_theme.dart';
import 'presentation/res/app_theme.dart';
import 'presentation/res/routes.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Web Workspace',
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) {
        return ShortcutFocus(child: child!);
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
