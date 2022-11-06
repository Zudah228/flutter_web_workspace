import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ShortcutsMap = Map<ShortcutActivator, Intent>;

final shortcutsProvider = StateProvider<ShortcutsMap>((_) => {});
