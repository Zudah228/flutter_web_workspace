// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../../../common/index.dart';
import '../../../common/utils/validation/validation.dart';
import '../../../domain/use_cases/auth/sign_in.dart';
import '../../res/routes.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  SignIn get signIn => ref.watch(signInProvider);

  Future<void> _onSubmit() async {
    if (isLoading) return;
    try {
      setState(() {
        isLoading = true;
      });
      await signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        context.go(AppRoutes.root);
      }
    } catch (_) {}

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('メールアドレス'),
              Focus(
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.tab) {
                    _emailFocusNode.nextFocus();
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: TextFormField(
                  autofocus: true,
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  validator: validationBuilder.required().email().build(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('パスワード'),
              CallbackShortcuts(
                bindings: {
                  const SingleActivator(LogicalKeyboardKey.tab, shift: true):
                      _passwordFocusNode.previousFocus
                },
                child: TextFormField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  validator: validationBuilder.required().build(),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  obscureText: true,
                  onFieldSubmitted: (_) => _onSubmit(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: isLoading ? null : _onSubmit,
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
