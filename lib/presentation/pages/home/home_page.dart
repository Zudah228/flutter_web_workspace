import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fire_app_template/common/providers/shortcuts.dart';
import 'package:flutter_fire_app_template/presentation/widgets/layouts/main_app_bar.dart';
import '../../../domain/use_cases/todos/todo_controller.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../add_item/add_item_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  /// 複数のダイアログが出ることを防止。
  /// 画面描画に関係ないので、setState(() {}) する必要はない。
  var isShowDialog = false;

  final settingPopupKey = GlobalKey<MainAppBarSettingButtonState>();

  Future<void> _showAddItemDialog() async {
    if (isShowDialog) return;
    isShowDialog = true;
    await AddItemDialog.show(context);
    isShowDialog = false;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shortcutsProvider.notifier).update(
            (state) => {
              ...state,
              const SingleActivator(LogicalKeyboardKey.keyK, meta: true):
                  VoidCallbackIntent(_showAddItemDialog),
              const SingleActivator(LogicalKeyboardKey.keyS,
                      meta: true, shift: true):
                  VoidCallbackIntent(
                      settingPopupKey.currentState!.showButtonMenu)
            },
          );
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final todos = ref.watch(todoController);

    Widget buildFAB() {
      const captionColor = Colors.black54;
      return IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (defaultTargetPlatform == TargetPlatform.macOS ||
                defaultTargetPlatform == TargetPlatform.windows) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: defaultTargetPlatform == TargetPlatform.macOS,
                    replacement: const Text(
                      'Ctr + ',
                      style: TextStyle(color: captionColor),
                    ),
                    child: const Icon(
                      CupertinoIcons.command,
                      color: captionColor,
                      size: 14,
                    ),
                  ),
                  const Text(
                    'K で開く',
                    style: TextStyle(color: captionColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              )
            ],
            FloatingActionButton(
              onPressed: _showAddItemDialog,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Home',
        settingPopupKey: settingPopupKey,
      ),
      floatingActionButton: buildFAB(),
      body: CustomScrollView(
        slivers: [
          SliverVisibility(
            visible: todos.isNotEmpty,
            replacementSliver: const SliverFillRemaining(
              child: Center(child: Text('データがありません')),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.createdAt.toIso8601String()),
                  );
                },
                childCount: todos.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
