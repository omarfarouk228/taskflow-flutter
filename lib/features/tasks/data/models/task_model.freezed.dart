// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskModel {

 String get id; String get title;@JsonKey(name: 'project_id') String get projectId;@JsonKey(name: 'user_id') String get userId; String get description;@JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson) Priority get priority;@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) TaskStatus get status;@JsonKey(name: 'tag_ids') List<String> get tagIds;@JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? get dueDate;@JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? get createdAt;@JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? get updatedAt;@JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? get completedAt;@JsonKey(name: 'assignee_id') String? get assigneeId;
/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskModelCopyWith<TaskModel> get copyWith => _$TaskModelCopyWithImpl<TaskModel>(this as TaskModel, _$identity);

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.tagIds, tagIds)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.assigneeId, assigneeId) || other.assigneeId == assigneeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,projectId,userId,description,priority,status,const DeepCollectionEquality().hash(tagIds),dueDate,createdAt,updatedAt,completedAt,assigneeId);

@override
String toString() {
  return 'TaskModel(id: $id, title: $title, projectId: $projectId, userId: $userId, description: $description, priority: $priority, status: $status, tagIds: $tagIds, dueDate: $dueDate, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, assigneeId: $assigneeId)';
}


}

/// @nodoc
abstract mixin class $TaskModelCopyWith<$Res>  {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) _then) = _$TaskModelCopyWithImpl;
@useResult
$Res call({
 String id, String title,@JsonKey(name: 'project_id') String projectId,@JsonKey(name: 'user_id') String userId, String description,@JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson) Priority priority,@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) TaskStatus status,@JsonKey(name: 'tag_ids') List<String> tagIds,@JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? dueDate,@JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? createdAt,@JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? updatedAt,@JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? completedAt,@JsonKey(name: 'assignee_id') String? assigneeId
});




}
/// @nodoc
class _$TaskModelCopyWithImpl<$Res>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._self, this._then);

  final TaskModel _self;
  final $Res Function(TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? projectId = null,Object? userId = null,Object? description = null,Object? priority = null,Object? status = null,Object? tagIds = null,Object? dueDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,Object? assigneeId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,tagIds: null == tagIds ? _self.tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<String>,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,assigneeId: freezed == assigneeId ? _self.assigneeId : assigneeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskModel].
extension TaskModelPatterns on TaskModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'project_id')  String projectId, @JsonKey(name: 'user_id')  String userId,  String description, @JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson)  Priority priority, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  TaskStatus status, @JsonKey(name: 'tag_ids')  List<String> tagIds, @JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? dueDate, @JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? createdAt, @JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? updatedAt, @JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? completedAt, @JsonKey(name: 'assignee_id')  String? assigneeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.title,_that.projectId,_that.userId,_that.description,_that.priority,_that.status,_that.tagIds,_that.dueDate,_that.createdAt,_that.updatedAt,_that.completedAt,_that.assigneeId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'project_id')  String projectId, @JsonKey(name: 'user_id')  String userId,  String description, @JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson)  Priority priority, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  TaskStatus status, @JsonKey(name: 'tag_ids')  List<String> tagIds, @JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? dueDate, @JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? createdAt, @JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? updatedAt, @JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? completedAt, @JsonKey(name: 'assignee_id')  String? assigneeId)  $default,) {final _that = this;
switch (_that) {
case _TaskModel():
return $default(_that.id,_that.title,_that.projectId,_that.userId,_that.description,_that.priority,_that.status,_that.tagIds,_that.dueDate,_that.createdAt,_that.updatedAt,_that.completedAt,_that.assigneeId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @JsonKey(name: 'project_id')  String projectId, @JsonKey(name: 'user_id')  String userId,  String description, @JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson)  Priority priority, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  TaskStatus status, @JsonKey(name: 'tag_ids')  List<String> tagIds, @JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? dueDate, @JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? createdAt, @JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? updatedAt, @JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson)  DateTime? completedAt, @JsonKey(name: 'assignee_id')  String? assigneeId)?  $default,) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.title,_that.projectId,_that.userId,_that.description,_that.priority,_that.status,_that.tagIds,_that.dueDate,_that.createdAt,_that.updatedAt,_that.completedAt,_that.assigneeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskModel extends TaskModel {
  const _TaskModel({required this.id, required this.title, @JsonKey(name: 'project_id') required this.projectId, @JsonKey(name: 'user_id') required this.userId, this.description = '', @JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson) this.priority = Priority.medium, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) this.status = TaskStatus.todo, @JsonKey(name: 'tag_ids') final  List<String> tagIds = const [], @JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson) this.dueDate, @JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson) this.createdAt, @JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson) this.updatedAt, @JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson) this.completedAt, @JsonKey(name: 'assignee_id') this.assigneeId}): _tagIds = tagIds,super._();
  factory _TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey(name: 'project_id') final  String projectId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey() final  String description;
@override@JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson) final  Priority priority;
@override@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) final  TaskStatus status;
 final  List<String> _tagIds;
@override@JsonKey(name: 'tag_ids') List<String> get tagIds {
  if (_tagIds is EqualUnmodifiableListView) return _tagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagIds);
}

@override@JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime? dueDate;
@override@JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime? updatedAt;
@override@JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime? completedAt;
@override@JsonKey(name: 'assignee_id') final  String? assigneeId;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskModelCopyWith<_TaskModel> get copyWith => __$TaskModelCopyWithImpl<_TaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._tagIds, _tagIds)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.assigneeId, assigneeId) || other.assigneeId == assigneeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,projectId,userId,description,priority,status,const DeepCollectionEquality().hash(_tagIds),dueDate,createdAt,updatedAt,completedAt,assigneeId);

@override
String toString() {
  return 'TaskModel(id: $id, title: $title, projectId: $projectId, userId: $userId, description: $description, priority: $priority, status: $status, tagIds: $tagIds, dueDate: $dueDate, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, assigneeId: $assigneeId)';
}


}

/// @nodoc
abstract mixin class _$TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$TaskModelCopyWith(_TaskModel value, $Res Function(_TaskModel) _then) = __$TaskModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@JsonKey(name: 'project_id') String projectId,@JsonKey(name: 'user_id') String userId, String description,@JsonKey(fromJson: _priorityFromJson, toJson: _priorityToJson) Priority priority,@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) TaskStatus status,@JsonKey(name: 'tag_ids') List<String> tagIds,@JsonKey(name: 'due_date', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? dueDate,@JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? createdAt,@JsonKey(name: 'updated_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? updatedAt,@JsonKey(name: 'completed_at', fromJson: _dateFromJson, toJson: _dateToJson) DateTime? completedAt,@JsonKey(name: 'assignee_id') String? assigneeId
});




}
/// @nodoc
class __$TaskModelCopyWithImpl<$Res>
    implements _$TaskModelCopyWith<$Res> {
  __$TaskModelCopyWithImpl(this._self, this._then);

  final _TaskModel _self;
  final $Res Function(_TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? projectId = null,Object? userId = null,Object? description = null,Object? priority = null,Object? status = null,Object? tagIds = null,Object? dueDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,Object? assigneeId = freezed,}) {
  return _then(_TaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,tagIds: null == tagIds ? _self._tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<String>,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,assigneeId: freezed == assigneeId ? _self.assigneeId : assigneeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
