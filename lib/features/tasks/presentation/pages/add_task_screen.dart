import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../providers/tasks_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final String projectId;
  const AddTaskScreen({super.key, required this.projectId});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  Priority _priority = Priority.medium;
  DateTime? _dueDate;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isSubmitting = true);

    try {
      await ref
          .read(tasksProvider(projectId: widget.projectId).notifier)
          .createTask(CreateTaskParams(
            title: _titleCtrl.text,
            projectId: widget.projectId,
            userId: user.uid,
            description: _descCtrl.text,
            priority: _priority,
            dueDate: _dueDate,
          ));

      if (mounted) {
        context.showSnackBar('Tâche créée avec succès !');
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString(), isError: true);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle tâche'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Créer'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre
                TextFormField(
                  controller: _titleCtrl,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: context.texts.titleLarge,
                  decoration: const InputDecoration(
                    hintText: 'Titre de la tâche',
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Le titre est requis';
                    }
                    return null;
                  },
                ),
                const Divider(),
                const SizedBox(height: AppSpacing.md),

                // Description
                TextFormField(
                  controller: _descCtrl,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Ajouter une description...',
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const Divider(),
                const SizedBox(height: AppSpacing.md),

                // Priorité
                Text('Priorité', style: context.texts.labelLarge),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: Priority.values.map((p) {
                    final isSelected = _priority == p;
                    return ChoiceChip(
                      label: Text(p.label),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _priority = p),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Date d'échéance
                Text('Date d\'échéance', style: context.texts.labelLarge),
                const SizedBox(height: AppSpacing.sm),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm + 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: context.colors.outlineVariant),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: context.colors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          _dueDate != null
                              ? DateFormat('d MMMM yyyy', 'fr_FR')
                                  .format(_dueDate!)
                              : 'Aucune date',
                          style: context.texts.bodyMedium?.copyWith(
                            color: _dueDate != null
                                ? null
                                : context.colors.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        if (_dueDate != null)
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () => setState(() => _dueDate = null),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
