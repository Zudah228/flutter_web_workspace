// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../common/index.dart';
import '../../../domain/entities/todo/todo.dart';
import '../../../domain/use_cases/todos/todo_controller.dart';
import '../../widgets/state/consumer_escape_state.dart';

class AddItemDialog extends ConsumerStatefulWidget {
  const AddItemDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
        context: context,
        builder: (_) => const AddItemDialog(),
        barrierDismissible: false,
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends ConsumerEscapeKeyPopState<AddItemDialog> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  static const _dialogHorizontalPadding = EdgeInsets.symmetric(horizontal: 24);

  void register() {
    if (!_formKey.currentState!.validate()) {
      _focusNode.requestFocus();
      return;
    }

    ref.watch(todoController.notifier).update(
          (state) => [
            ...state,
            Todo(
              title: _textController.text,
              createdAt: DateTime.now(),
              isCompleted: false,
              todoId: UuidGenerator.create(),
            )
          ],
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text('追加する'),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.clear),
              color: Colors.black,
            ),
          )
        ],
      ),
      titlePadding: _dialogHorizontalPadding + const EdgeInsets.only(top: 24),
      contentPadding: _dialogHorizontalPadding +
          const EdgeInsets.symmetric(horizontal: 24) +
          const EdgeInsets.only(bottom: 24, top: 64),
      children: [
        // 幅の拡大
        const SizedBox(
          width: 400,
        ),
        CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.keyC, meta: true): () =>
                ClipboardUtil.copy(_textController.text)
          },
          child: Form(
            key: _formKey,
            child: TextFormField(
              autofocus: true,
              focusNode: _focusNode,
              controller: _textController,
              validator: validationBuilder.required().build(),
              onFieldSubmitted: (_) => register(),
            ),
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        ElevatedButton(
          onPressed: register,
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('登録'),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'esc で閉じる',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.end,
        )
      ],
    );
  }
}
