import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/todo/todo.dart';

final todoController = StateProvider<List<Todo>>(
  (_) => [],
);
