// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../common/providers/shortcuts.dart';

abstract class ConsumerEscapeKeyPopState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(shortcutsProvider.notifier).update(
        (state) {
          return {
            ...state,
            const SingleActivator(LogicalKeyboardKey.escape):
                VoidCallbackIntent(() {
              if (mounted) Navigator.of(context).pop();
            }),
          };
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      ref.watch(shortcutsProvider.notifier).update((state) {
        var map = {...state};
        map.removeWhere(
          (key, value) => key.triggers == {LogicalKeyboardKey.escape},
        );
        return map;
      });
    });
    super.dispose();
  }
}
