import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/task_provider.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  final _controller = TextEditingController();
  bool _showCompleted = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final filteredTasks = _showCompleted
        ? tasks
        : tasks.where((task) => !task.isCompleted).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('tasks.title'.tr()),
            centerTitle: true,
            floating: true,
            actions: [
              IconButton(
                icon: Icon(
                  _showCompleted ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _showCompleted = !_showCompleted;
                  });
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'tasks.add_new'.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'tasks.enter_title'.tr(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                ref
                                    .read(taskProvider.notifier)
                                    .addTask(_controller.text);
                                _controller.clear();
                              }
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            ref.read(taskProvider.notifier).addTask(value);
                            _controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn().slideY(begin: -0.2),
            ),
          ),
          if (filteredTasks.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 64,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _showCompleted
                              ? 'tasks.no_tasks'.tr()
                              : 'tasks.no_pending'.tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _showCompleted
                              ? 'tasks.add_first_task'.tr()
                              : 'tasks.all_completed'.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn().scale(),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final task = filteredTasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) => ref
                              .read(taskProvider.notifier)
                              .toggleTask(task.id),
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          'tasks.created'
                              .tr(args: [_formatDate(task.createdAt)]),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => ref
                              .read(taskProvider.notifier)
                              .deleteTask(task.id),
                        ),
                      ),
                    ).animate().fadeIn().slideX(
                          begin: 0.2,
                          delay: Duration(milliseconds: 100 * index),
                        ),
                  );
                },
                childCount: filteredTasks.length,
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'tasks.today'.tr();
    } else if (difference.inDays == 1) {
      return 'tasks.yesterday'.tr();
    } else if (difference.inDays < 7) {
      return 'tasks.days_ago'.tr(args: [difference.inDays.toString()]);
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
