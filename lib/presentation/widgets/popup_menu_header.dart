import 'package:flutter/material.dart';

class PopupMenuHeader extends PopupMenuItem {
  PopupMenuHeader({required String title})
      : super(
          child: Text(title),
          height: kMinInteractiveDimension / 2,
        );

  @override
  PopupMenuItemState createState() => PopupMenuHeaderState();
}

const double _kMenuHorizontalPadding = 16.0;

class PopupMenuHeaderState extends PopupMenuItemState {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final popupMenuTheme = PopupMenuTheme.of(context);
    var style = widget.textStyle ??
        popupMenuTheme.textStyle ??
        theme.textTheme.bodyText2!;

    if (!widget.enabled) {
      style = style.copyWith(color: theme.disabledColor);
    }

    Widget item = AnimatedDefaultTextStyle(
      style: style,
      duration: kThemeChangeDuration,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        constraints: BoxConstraints(minHeight: widget.height),
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: _kMenuHorizontalPadding),
        child: buildChild(),
      ),
    );

    if (!widget.enabled) {
      final isDark = theme.brightness == Brightness.dark;
      item = IconTheme.merge(
        data: IconThemeData(opacity: isDark ? 0.5 : 0.38),
        child: item,
      );
    }

    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        child: item,
      ),
    );
  }
}
