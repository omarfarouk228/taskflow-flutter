// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

Priority _priorityFromJson(String json) =>
    Priority.values.firstWhere((p) => p.name == json,
        orElse: () => Priority.medium);
String _priorityToJson(Priority p) => p.name;

TaskStatus _statusFromJson(String json) =>
    TaskStatus.values.firstWhere((s) => s.name == json,
        orElse: () => TaskStatus.todo);
String _statusToJson(TaskStatus s) => s.name;

DateTime? _dateFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Timestamp) return json.toDate();
  if (json is String) return DateTime.tryParse(json);
  return null;
}

dynamic _dateToJson(DateTime? date) =>
    date != null ? Timestamp.fromDate(date) : null;

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    @JsonKey(name: 'project_id') required String projectId,
    @JsonKey(name: 'user_id') required String userId,
    @Default('') String description,
    @JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson)
    @Default(Priority.medium)
    Priority priority,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    @Default(TaskStatus.todo)
    TaskStatus status,
    @JsonKey(name: 'tag_ids') @Default([]) List<String> tagIds,
    @JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson)
    DateTime? dueDate,
    @JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson)
    DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson)
    DateTime? updatedAt,
    @JsonKey(
        name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson)
    DateTime? completedAt,
    @JsonKey(name: 'assignee_id') String? assigneeId,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  const TaskModel._();

  Task toEntity() => Task(
        id: id,
        title: title,
        projectId: projectId,
        userId: userId,
        description: description,
        priority: priority,
        status: status,
        tagIds: tagIds,
        dueDate: dueDate,
        createdAt: createdAt,
        updatedAt: updatedAt,
        completedAt: completedAt,
        assigneeId: assigneeId,
      );

  factory TaskModel.fromEntity(Task task) => TaskModel(
        id: task.id,
        title: task.title,
        projectId: task.projectId,
        userId: task.userId,
        description: task.description,
        priority: task.priority,
        status: task.status,
        tagIds: task.tagIds,
        dueDate: task.dueDate,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        completedAt: task.completedAt,
        assigneeId: task.assigneeId,
      );
}
