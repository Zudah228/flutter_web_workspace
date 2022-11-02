// Flutter imports:
import 'package:flutter/material.dart';

@immutable
class ConfirmDialogParam {
  const ConfirmDialogParam({
    this.key,
    required this.title,
    required this.onPositiveTap,
    required this.onNegativeTap,
    required this.positiveBtnText,
    required this.negativeBtnText,
  });

  final Key? key;
  final String title;
  final String positiveBtnText;
  final String negativeBtnText;
  final VoidCallback? onPositiveTap;
  final VoidCallback? onNegativeTap;
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.param,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
    ConfirmDialogParam param,
  ) async {
    await Navigator.of(context).push(
      DialogRoute(
        context: context,
        builder: (_) => ConfirmDialog(
          param: param,
          key: param.key,
        ),
      ),
    );
  }

  final ConfirmDialogParam param;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(param.title),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: param.onNegativeTap,
          child: Text(param.negativeBtnText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: param.onPositiveTap,
          child: Text(param.positiveBtnText),
        ),
      ],
    );
  }
}
