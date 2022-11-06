// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../common/index.dart';

enum ThemeType {
  mediaDepend(),
  basic(),
  dark();

  const ThemeType();

  bool get isDark => this == ThemeType.dark;
  bool get isMediaDepend => this == ThemeType.mediaDepend;

  String get label {
    if (this == ThemeType.dark) {
      return 'ダークモード';
    }
    return 'ライトモード';
  }

  bool getCurrentThemeIsDark(BuildContext context) {
    if (isMediaDepend) {
      return context.isDark;
    }
    return isDark;
  }
}

final appThemeProvider = StateProvider<ThemeType>(
  (_) => ThemeType.mediaDepend,
);
