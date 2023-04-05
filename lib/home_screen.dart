import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'completed_tasks_screen.dart';
import 'data_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DataProvider provider = Provider.of<DataProvider>(context);
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
                    tasks: provider.tasks,
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
                onPressed: () {
                  provider.clearTasks();
                  textEditingController.clear();
                },
                child: const Text('Clear'),
              ),
              SizedBox.fromSize(
                size: const Size(128, 0),
              ),
              ElevatedButton(
                  onPressed: () {
                    String text = textEditingController.text;
                    textEditingController.clear();
                    provider.addTask(text);
                  },
                  child: const Text('Add')),
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
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  key: ValueKey(provider.tasks[index]),
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: provider.tasks[index].colorAccent),
                    child: CheckboxListTile(
                      title: Text(
                        provider.tasks[index].taskName,
                      ),
                      value: provider.tasks[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          provider.tasks[index].isCompleted = value ?? false;
                        });
                      },
                      activeColor: provider.tasks[index].color,
                    ),
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                if (newIndex > oldIndex) {
                  newIndex--;
                }
                final task = provider.tasks.removeAt(oldIndex);
                provider.tasks.insert(newIndex, task);
              },
            ),
          ),
        ],
      ),
    );
  }
}
