// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:flutter_fire_app_template/common/index.dart';
import 'package:flutter_fire_app_template/presentation/widgets/shortcut_focus.dart';
import '../../../common/utils/validator.dart';
import '../../../domain/use_cases/auth/sign_in.dart';
import '../../res/routes.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signIn = ref.watch(signInProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('メールアドレス'),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('パスワード'),
              TextFormField(
                controller: passwordController,
                validator: (value) => Validator().requiredValidator(value),
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await signIn(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (mounted) {
                      context.go(AppRoutes.root);
                    }
                  } catch (_) {}
                },
                child: const Text('サインイン'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.signup),
                child: const Text('アカウントが未登録の場合'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
