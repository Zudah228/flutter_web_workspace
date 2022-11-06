// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../entities/todo/todo.dart';

final todoController = StateProvider<List<Todo>>(
  (_) => [],
);
