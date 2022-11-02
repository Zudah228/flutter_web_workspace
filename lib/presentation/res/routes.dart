// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:flutter_fire_app_template/presentation/pages/loading/loading_page.dart';
import '../../domain/use_cases/auth/watch_auth_state.dart';
import '../pages/home/home_page.dart';
import '../pages/sign_in/sign_in_page.dart';
import '../pages/sign_up/sign_up_page.dart';

typedef Redirect = FutureOr<String?> Function(BuildContext, GoRouterState);

final routerProvider = Provider((ref) {
  final currentUserValue = ref.watch(watchAuthStateProvider);
  final currentUser = currentUserValue.value;

  debugPrint(
    'current user: ${currentUserValue.isLoading ? 'Loading' : currentUser?.uid}',
  );

  redirectToRoot() => currentUser == null ? null : AppRoutes.root;
  redirectToLoading() => currentUserValue.isLoading ? AppRoutes.loading : null;

  return GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutes.root,
        builder: (_, __) {
          return const HomePage();
        },
        redirect: (_, __) {
          return redirectToLoading() ??
              (currentUser == null ? AppRoutes.signin : null);
        },
      ),
      GoRoute(
        path: AppRoutes.signin,
        builder: (_, __) => const SignInPage(),
        redirect: (_, __) {
          return redirectToLoading() ?? redirectToRoot();
        },
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (_, __) => const SignUpPage(),
        redirect: (_, __) {
          return redirectToLoading() ?? redirectToRoot();
        },
      ),
      GoRoute(
        path: AppRoutes.loading,
        builder: (_, __) => const LoadingPage(),
        redirect: (_, __) {
          if (currentUserValue.isLoading) {
            return null;
          }
          return (currentUser == null ? AppRoutes.signin : AppRoutes.root);
        },
      ),
    ],
  );
});

class AppRoutes {
  const AppRoutes._();

  static const root = '/';
  static const loading = '/loading';
  static const signin = '/signin';
  static const signup = '/signup';
}
