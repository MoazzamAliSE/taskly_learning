import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/models/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  static const _storageKey = 'tasks';

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_storageKey) ?? [];
    state = tasksJson.map((json) => Task.fromJson(jsonDecode(json))).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = state.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_storageKey, tasksJson);
  }

  Future<void> addTask(String title) async {
    final task = Task(title: title);
    state = [task, ...state];
    await _saveTasks();
  }

  Future<void> toggleTask(String id) async {
    state = state.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
    await _saveTasks();
  }

  Future<void> deleteTask(String id) async {
    state = state.where((task) => task.id != id).toList();
    await _saveTasks();
  }

  Future<void> updateTask(Task task) async {
    state = state.map((t) => t.id == task.id ? task : t).toList();
    await _saveTasks();
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
