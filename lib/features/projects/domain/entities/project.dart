import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';

@freezed
abstract class Project with _$Project {
  const factory Project({
    required String id,
    required String title,
    required String userId,
    @Default('') String description,
    @Default(0xFF0553B1) int colorValue,
    @Default(0) int taskCount,
    @Default(0) int completedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Project;

  const Project._();

  Color get color => Color(colorValue);

  double get progressRatio =>
      taskCount == 0 ? 0 : completedCount / taskCount;

  int get progressPercent => (progressRatio * 100).round();
}
