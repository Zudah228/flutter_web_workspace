// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../shortcut_focus.dart';

abstract class ConsumerEscapeKeyPopState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(keyDownEventProvider.notifier).update(
            (state) => {
              ...state,
              LogicalKeyboardKey.escape: Navigator.of(context).pop,
            },
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      ref.watch(keyDownEventProvider.notifier).update(
            (state) => state.map((key, value) =>
                MapEntry(key, key == LogicalKeyboardKey.escape ? null : value)),
          );
    });
    super.dispose();
  }
}
