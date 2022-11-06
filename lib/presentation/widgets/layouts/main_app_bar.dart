// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../popup_menu_header.dart';

const _iconWidth = 48.0;

class MainAppBar extends AppBar {
  MainAppBar(
      {required String title,
      GlobalKey<MainAppBarSettingButtonState>? settingPopupKey,})
      : super(
          title: Text(title),
          leadingWidth: _iconWidth,
          actions: [
            _SettingButton(
              key: settingPopupKey,
            ),
          ]
              .map(
                (child) => SizedBox(
                  width: _iconWidth,
                  child: child,
                ),
              )
              .toList(),
        );
}

class _SettingButton extends ConsumerStatefulWidget {
  const _SettingButton({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      MainAppBarSettingButtonState();
}

class MainAppBarSettingButtonState extends ConsumerState<_SettingButton> {
  var isShowDialog = false;
  final GlobalKey<PopupMenuButtonState> popupMenuKey =
      GlobalKey<PopupMenuButtonState>();

  void showButtonMenu() {
    if (isShowDialog) {
      Navigator.pop(context);
      isShowDialog = false;
    } else {
      popupMenuKey.currentState!.showButtonMenu();
      isShowDialog = true;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return PopupMenuButton(
        key: popupMenuKey,
        itemBuilder: (context) {
          return [
            PopupMenuHeader(
              title: 'ショートカット',
            ),
          ];
        },
        child: const Icon(Icons.settings),);
  }
}
