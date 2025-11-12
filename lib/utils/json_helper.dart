import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class JsonHelper {
  static const String _tasksKey = 'tasks_data';

  /// Save tasks to SharedPreferences as JSON string
  static Future<void> saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = tasks.map((task) => task.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_tasksKey, jsonString);
      print('✅ Tasks saved: ${tasks.length} tasks');
    } catch (e) {
      print('❌ Error saving tasks: $e');
      throw Exception('Failed to save tasks: $e');
    }
  }

  /// Load tasks from SharedPreferences
  static Future<List<Task>> loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_tasksKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        print('⚠️ No saved tasks found, returning empty list');
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List;
      final tasks = jsonList.map((json) => Task.fromJson(json)).toList();
      
      print('✅ Tasks loaded: ${tasks.length} tasks');
      return tasks;
    } catch (e) {
      print('❌ Error loading tasks: $e');
      return [];
    }
  }

  /// Clear all tasks from SharedPreferences
  static Future<void> clearTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tasksKey);
      print('✅ Tasks cleared');
    } catch (e) {
      print('❌ Error clearing tasks: $e');
    }
  }

  /// Check if tasks exist in storage
  static Future<bool> tasksExist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tasksKey);
  }

  /// Get tasks count without loading full data
  static Future<int> getTasksCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_tasksKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        return 0;
      }

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.length;
    } catch (e) {
      return 0;
    }
  }

  /// Export tasks as JSON string (for backup/sharing)
  static Future<String?> exportTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tasksKey);
    } catch (e) {
      print('❌ Error exporting tasks: $e');
      return null;
    }
  }

  /// Import tasks from JSON string (for restore)
  static Future<bool> importTasks(String jsonString) async {
    try {
      // Validate JSON
      final jsonList = jsonDecode(jsonString) as List;
      final tasks = jsonList.map((json) => Task.fromJson(json)).toList();
      
      // Save if valid
      await saveTasks(tasks);
      print('✅ Tasks imported: ${tasks.length} tasks');
      return true;
    } catch (e) {
      print('❌ Error importing tasks: $e');
      return false;
    }
  }
}
