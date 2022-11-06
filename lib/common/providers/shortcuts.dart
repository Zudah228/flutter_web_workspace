// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ShortcutsMap = Map<ShortcutActivator, Intent>;

final shortcutsProvider = StateProvider<ShortcutsMap>((_) => {});
