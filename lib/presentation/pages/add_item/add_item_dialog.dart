// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:flutter_fire_app_template/presentation/widgets/shortcut_focus.dart';
import 'package:flutter_fire_app_template/presentation/widgets/state/consumer_escape_state.dart';

class AddItemDialog extends ConsumerStatefulWidget {
  const AddItemDialog({super.key});

  static Future<void> show(BuildContext context) =>
      showDialog(context: context, builder: (_) => const AddItemDialog());

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends ConsumerEscapeKeyPopState<AddItemDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [Text('child'), TextFormField()],
      ),
    );
  }
}
