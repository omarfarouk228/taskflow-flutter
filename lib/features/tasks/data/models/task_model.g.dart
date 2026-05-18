// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: json['id'] as String,
  title: json['title'] as String,
  projectId: json['project_id'] as String,
  userId: json['user_id'] as String,
  description: json['description'] as String? ?? '',
  priority: json['priority'] == null
      ? Priority.medium
      : _priorityFromJson(json['priority'] as String),
  status: json['status'] == null
      ? TaskStatus.todo
      : _statusFromJson(json['status'] as String),
  tagIds:
      (json['tag_ids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  dueDate: _dateFromJson(json['due_date']),
  createdAt: _dateFromJson(json['created_at']),
  updatedAt: _dateFromJson(json['updated_at']),
  completedAt: _dateFromJson(json['completed_at']),
  assigneeId: json['assignee_id'] as String?,
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'project_id': instance.projectId,
      'user_id': instance.userId,
      'description': instance.description,
      'priority': _priorityToJson(instance.priority),
      'status': _statusToJson(instance.status),
      'tag_ids': instance.tagIds,
      'due_date': _dateToJson(instance.dueDate),
      'created_at': _dateToJson(instance.createdAt),
      'updated_at': _dateToJson(instance.updatedAt),
      'completed_at': _dateToJson(instance.completedAt),
      'assignee_id': instance.assigneeId,
    };
