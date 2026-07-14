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
  bool canSave = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  @override
  void initState() {
    super.initState();

    nameController.addListener(_validateForm);
    descriptionController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      canSave =
          nameController.text.trim().isNotEmpty &&
          descriptionController.text.trim().isNotEmpty &&
          difficulty != null &&
          taskType != null &&
          category != null;
    });
  }

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
                        _validateForm();
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
                        _validateForm();
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
                  _validateForm();
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

                  Spacer(),

                  AnimatedScale(
                    scale: canSave ? 1 : 0,
                    duration: Duration(milliseconds: 250),
                    child: Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF40DCC7),
                          foregroundColor: const Color(0xFF00001B),
                        ),
                        onPressed: () => savemodel(context),
                        child: const Text("Save"),
                      ),
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

  void savemodel(BuildContext context) {
    final newModel = Model(
      id: null,
      name: nameController.text,
      description: descriptionController.text,
      difficulty: difficulty!,
      type: taskType!,
      timesCompleted: 0,
      timesAssigned: 0,
      isEnabled: true,
      category: category!,
    );
    final app = ModelProvider.of(context);
    app.addModel(newModel);
    Navigator.pop(context, true);
  }
}
