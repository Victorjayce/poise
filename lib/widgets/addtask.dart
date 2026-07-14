import 'package:flutter/material.dart';
import 'package:poise/model/model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

Future<bool> showAddTaskDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => AddTask(),
  );

  return result ?? false;
}

class _AddTaskState extends State<AddTask> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  Difficulty? difficulty;
  Type? taskType;
  Category? category;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF001F5A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff04dcc7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<Difficulty>(
                      initialValue: difficulty,
                      decoration: const InputDecoration(labelText: "Diff"),
                      items: Difficulty.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.title),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => difficulty = value!);
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: DropdownButtonFormField<Type>(
                      initialValue: taskType,
                      decoration: const InputDecoration(labelText: "Type"),
                      items: Type.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.title),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => taskType = value!);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              DropdownButtonFormField<Category>(
                initialValue: category,
                decoration: const InputDecoration(labelText: "Category"),
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e.title)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => category = value!);
                },
              ),

              const SizedBox(height: 18),

              TextField(
                controller: descriptionController,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF40DCC7),
                        foregroundColor: const Color(0xFF00001B),
                      ),
                      onPressed: () {
                        // Save later
                        Navigator.pop(context, true);
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
