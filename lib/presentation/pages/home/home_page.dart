// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:flutter_fire_app_template/presentation/pages/add_item/add_item_dialog.dart';
import 'package:flutter_fire_app_template/presentation/widgets/shortcut_focus.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  /// 複数のダイアログが出ることを防止。
  /// 画面描画に関係ないので、setState(() {}) する必要はない。
  var isShowDialog = false;

  Future<void> _showAddItemDialog() async {
    if (isShowDialog) return;
    isShowDialog = true;
    await AddItemDialog.show(context);
    isShowDialog = false;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(metaKeyDownEventProvider.notifier).update(
            (state) => {
              ...state,
              LogicalKeyboardKey.keyK: _showAddItemDialog,
            },
          );
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('home'),
      ),
    );
  }
}
