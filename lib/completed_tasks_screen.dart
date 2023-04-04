import 'package:day4_lab/task_dto.dart';
import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatelessWidget {
  final List<Task> tasks;

  CompletedTasksScreen({
    Key? key,
    required this.tasks,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final completedTasksList = [
      for (int i = 0; i < tasks.length; i++)
        if (tasks[i].isCompleted) tasks[i]
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(

          itemCount: completedTasksList.length,
          itemBuilder: (context, index) {

            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: completedTasksList[index].colorAccent),
              child: ListTile(
                title: Text(completedTasksList[index].taskName),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) { return Divider(height: 2,); },
        ),
      ),
    );
  }
}
