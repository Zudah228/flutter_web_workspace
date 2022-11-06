// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fire_app_template/common/providers/shortcuts.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              Navigator.of(context).pop();
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
        ShortcutsMap map = {};
        state.forEach((key, value) {
          if (key.triggers != {LogicalKeyboardKey.escape}) {
            map = {
              ...map,
              key: value,
            };
          }
        });
        return map;
      });
    });
    super.dispose();
  }
}
