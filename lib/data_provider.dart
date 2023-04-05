import 'package:day4_lab/task_dto.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  List<Task> tasks = [];

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];

  final List<Color> colors2 = [
    Colors.red.shade200,
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.yellow.shade200,
    Colors.orange.shade200,
  ];

  void clearTasks() {
    tasks.clear();
    notifyListeners();
  }

  void addTask(String text) {
    if (text.isNotEmpty) {
      tasks.add(Task(text,
          color: colors[tasks.length % colors.length],
          colorAccent: colors2[tasks.length % colors2.length]));
      notifyListeners();
    }
  }
}
