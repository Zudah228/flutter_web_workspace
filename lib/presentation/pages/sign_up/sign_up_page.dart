// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../common/index.dart';
import '../../../domain/use_cases/auth/sign_up.dart';
import '../../res/routes.dart';
import '../../widgets/loading_indicator.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  var isLoading = false;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    late final singUp = ref.watch(signUpProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('アカウント登録')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('メールアドレス'),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: validationBuilder.required().email().build(),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('パスワード'),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                validator: validationBuilder.required().build(),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('確認用パスワード'),
              TextFormField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                validator: validationBuilder
                    .required()
                    // Todo: 動作確認
                    .match(passwordController.text)
                    .build(),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: isLoading
                    ? const CircleLoadingIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          try {
                            await singUp(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            if (mounted) {
                              context.go(AppRoutes.root);
                            }
                          } catch (_) {}
                        },
                        child: const Text('登録'),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
