// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

class WrappedAutoSizedText extends StatelessWidget {
  const WrappedAutoSizedText(
    this.data, {
    super.key,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
        child: AutoSizeText(
      data,
    ));
  }
}
