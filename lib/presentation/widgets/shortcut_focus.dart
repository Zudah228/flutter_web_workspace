// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:flutter_fire_app_template/common/index.dart';

typedef KeyEventMap = Map<LogicalKeyboardKey, VoidCallback?>;

final keyDownEventProvider = StateProvider<KeyEventMap>(
  (_) => {},
);

final metaKeyDownEventProvider = StateProvider<KeyEventMap>(
  (_) => {},
);

// Todo: イベントの上書き
class ShortcutFocus extends ConsumerStatefulWidget {
  const ShortcutFocus({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShortcutFocusState();
}

class _ShortcutFocusState extends ConsumerState<ShortcutFocus> {
  late final FocusNode _focusNode;
  var isMetaPressing = false;

  static final _metaKeys = LogicalKeySet(LogicalKeyboardKey.meta).triggers;

  void focus() {
    _focusNode.requestFocus();
  }

  KeyEventMap get keyDown => ref.watch(keyDownEventProvider);
  KeyEventMap get metaKeyDown => ref.watch(metaKeyDownEventProvider);

  @override
  void initState() {
    _focusNode = FocusNode();
    browserApi.addEventListener(BrowserApi.kFocusEventType, (_) => focus());
    super.initState();
  }

  @override
  void dispose() {
    browserApi.removeEventListener(BrowserApi.kFocusEventType, (_) => focus());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      focusNode: _focusNode,
      onFocusChange: (value) {
        if (!value) {
          focus();
        }
      },
      child: widget.child,
      onKeyEvent: (node, event) {
        final key = event.logicalKey;

        if (event is KeyDownEvent) {
          debugPrint(
            'KeyDownEvent, key: ${event.logicalKey.debugName}',
          );

          if (_metaKeys.contains(key)) {
            setState(() {
              isMetaPressing = true;
            });
          }

          if (metaKeyDown.isNotEmpty) {
            if (isMetaPressing) {
              final func = metaKeyDown[key];
              if (func != null) {
                func.call();
                return KeyEventResult.handled;
              }
            }
          }
          if (keyDown.isNotEmpty) {
            final func = keyDown[key];
            if (func != null) {
              func.call();
              return KeyEventResult.handled;
            }
          }
        }

        if (event is KeyUpEvent) {
          if (_metaKeys.contains(key)) {
            setState(() {
              isMetaPressing = false;
            });
          }
        }
        return KeyEventResult.ignored;
      },
    );
  }
}
