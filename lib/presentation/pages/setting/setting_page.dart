// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../../../common/providers/app_theme.dart';
import '../../../domain/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../res/routes.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SettingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeProvider);
    final appThemeController = ref.read(appThemeProvider.notifier);
    final authRepository = ref.read(firebaseAuthRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: appThemeState.isMediaDepend ? 0.5 : 1,
              child: _ListTile(
                title: Text(appThemeState.label),
                action: Switch(
                  value: appThemeState.isDark,
                  onChanged: appThemeState.isMediaDepend
                      ? null
                      : (_) {
                          appThemeController.update((state) {
                            if (state == ThemeType.dark) {
                              return ThemeType.basic;
                            }
                            return ThemeType.dark;
                          });
                        },
                ),
                onTap: null,
              ),
            ),
            _ListTile(
              title: const Text('カラーモードを\nデバイスに依存させる'),
              action: Switch(
                value: appThemeState.isMediaDepend,
                onChanged: (_) {
                  appThemeController.update((state) {
                    if (state != ThemeType.mediaDepend) {
                      return ThemeType.mediaDepend;
                    }
                    return ThemeType.basic;
                  });
                },
              ),
              onTap: null,
            ),
            _ListTile(
              title: const Text('ログアウト'),
              onTap: () {
                authRepository
                    .signOut()
                    .then((_) => context.go(AppRoutes.signin));
              },
            )
          ],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    Key? key,
    required this.title,
    this.action,
    required this.onTap,
  }) : super(key: key);
  final Widget title;
  final Widget? action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
