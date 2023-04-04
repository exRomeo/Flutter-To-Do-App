import 'package:day4_lab/task_dto.dart';
import 'package:flutter/material.dart';

import 'completed_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final List<Task> tasks = [];
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
    setState(() {
      textEditingController.clear();
      tasks.clear();
    });
  }

  void addTask() {
    if (textEditingController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(textEditingController.text,
            color: colors[tasks.length % colors.length],
            colorAccent: colors2[tasks.length % colors2.length]));
        textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedTasksScreen(
                    tasks: tasks,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Enter a task',
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
          const Divider(
            thickness: 2,
            color: Color(0xfffdc007),
            height: 16,
            indent: 64,
            endIndent: 64,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: clearTasks,
                child: const Text('Clear'),
              ),
              SizedBox.fromSize(
                size: const Size(128, 0),
              ),
              ElevatedButton(onPressed: addTask, child: const Text('Add')),
            ],
          ),
          const Divider(
            thickness: 2,
            color: Color(0xffca7231),
            height: 16,
            indent: 128,
            endIndent: 128,
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  key: ValueKey(tasks[index]),
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                        color: tasks[index].colorAccent),
                    child: CheckboxListTile(
                      title: Text(
                        tasks[index].taskName,
                      ),
                      value: tasks[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          tasks[index].isCompleted = value ?? false;
                        });
                      },
                      activeColor: tasks[index].color,
                    ),
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex--;
                  }
                  final task = tasks.removeAt(oldIndex);
                  tasks.insert(newIndex, task);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
