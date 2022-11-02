// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../../common/index.dart';

class CircleLoadingIndicator extends StatelessWidget {
  const CircleLoadingIndicator({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return const CupertinoActivityIndicator();
    }
    return CircularProgressIndicator(
      color: color ?? context.primaryColor,
    );
  }
}
