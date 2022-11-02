// Flutter imports:
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, required this.title, required this.content})
      : super(key: key);

  static Future<void> show(BuildContext context,
      {Key? key, String title = '通信に失敗しました', String content = '通信状況をお確かめの上、もう一度お試しください。',}) async {
    await Navigator.of(context).push(
      DialogRoute(
        context: context,
        builder: (_) => ErrorDialog(
          title: title,
          content: content,
          key: key,
        ),
      ),
    );
  }

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
    );
  }
}
