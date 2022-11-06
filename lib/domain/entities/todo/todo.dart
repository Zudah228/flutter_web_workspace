import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converters/date_time_timestamp_converter.dart';
import 'todo_color_category.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required String todoId,
    required String title,
    required bool isCompleted,
    @Default(TodoColorCategory.blue) TodoColorCategory colorCategory,
    @DateTimeTimestampConverter() required DateTime createdAt,
    bool? isArchived,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
