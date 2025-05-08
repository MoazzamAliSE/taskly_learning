import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../tasks/presentation/providers/task_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'home.greeting.morning'.tr();
    if (hour < 17) return 'home.greeting.afternoon'.tr();
    return 'home.greeting.evening'.tr();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final progress = tasks.isEmpty ? 0.0 : completedTasks / tasks.length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              _getGreeting(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            centerTitle: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            'home.progress.title'.tr(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 12,
                                ).animate().scale(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutBack,
                                    ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${(progress * 100).toInt()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      'home.progress.completed'.tr(),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: -0.2),
                  const SizedBox(height: 24),
                  if (tasks.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.task_alt,
                              size: 64,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'home.progress.no_tasks'.tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'home.progress.add_first_task'.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: () => context.go('/tasks'),
                              icon: const Icon(Icons.add),
                              label: Text('home.progress.add_task'.tr()),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn().scale(),
                  if (tasks.isNotEmpty) ...[
                    Text(
                      'home.progress.today_tasks'.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
          if (tasks.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final task = tasks[index];
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
                childCount: tasks.length,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/tasks'),
        icon: const Icon(Icons.add),
        label: Text('home.progress.add_task'.tr()),
      ).animate().scale(
            delay: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
          ),
    );
  }
}
