import 'package:flutter/material.dart';

class Task {
  String taskName;
  bool isCompleted;
  Color color;
  Color colorAccent;
  Task(this.taskName, {this.isCompleted = false, this.color = Colors.white,this.colorAccent = Colors.white12});
}
