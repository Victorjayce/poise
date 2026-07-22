import 'package:flutter/material.dart';
import 'package:poise/model/model.dart';
import 'package:poise/widgets/addtask.dart';
import 'package:poise/widgets/backtotop.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({super.key});

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  final Set<int> expanded = {};
  final controller = ScrollController();
  bool showbacktotop = false;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      final shouldShow = controller.offset > 100;

      if (shouldShow != showbacktotop) {
        setState(() {
          showbacktotop = shouldShow;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final app = appModel;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xff00001d),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text(
                        'All Tasks',
                        style: TextStyle(
                          color: Color(0xFF40DCC7),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () => callAddTask(context),
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xff40dcc7),
                          size: 40,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color(0xFF00001D),
                    child: ListView.builder(
                      controller: controller,
                      padding: const EdgeInsets.only(bottom: 60),
                      itemCount: app.models.length,
                      itemBuilder: (context, index) {
                        final task = app.models[index];
                        final isExpanded = expanded.contains(task.id);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isExpanded) {
                                expanded.remove(task.id);
                              } else {
                                expanded.add(task.id!);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF001F5A),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Name + Expand Icon
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              task.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          if (task.description.isNotEmpty)
                                            AnimatedRotation(
                                              turns: isExpanded ? .5 : 0,
                                              duration: const Duration(
                                                milliseconds: 250,
                                              ),
                                              child: const Icon(
                                                Icons.expand_more,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 4,
                                        children: [
                                          Text(
                                            task.type.title,
                                            style: TextStyle(
                                              color: task.isEnabled
                                                  ? const Color(0xFF40DCC7)
                                                  : Colors.black,
                                              fontSize: 15,
                                              decoration: task.isEnabled
                                                  ? TextDecoration.none
                                                  : TextDecoration.lineThrough,
                                            ),
                                          ),

                                          Text(
                                            task.category.title,
                                            style: TextStyle(
                                              color: task.isEnabled
                                                  ? const Color(0xFF40DCC7)
                                                  : Colors.black,
                                              fontSize: 15,
                                              decoration: task.isEnabled
                                                  ? TextDecoration.none
                                                  : TextDecoration.lineThrough,
                                            ),
                                          ),

                                          Text(
                                            task.isEnabled
                                                ? "Enabled"
                                                : "Disabled",
                                            style: TextStyle(
                                              color: task.isEnabled
                                                  ? const Color(0xFF40DCC7)
                                                  : Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),

                                      AnimatedCrossFade(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),
                                        crossFadeState: isExpanded
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                        firstChild: const SizedBox.shrink(),
                                        secondChild: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Text(
                                            task.description,
                                            style: const TextStyle(
                                              color: Color(0xFF40DCC7),
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Checkbox(
                                  value: task.isEnabled,
                                  side: BorderSide.none,
                                  fillColor: WidgetStatePropertyAll(
                                    task.difficulty.color,
                                  ),
                                  onChanged: (value) {
                                    updateModel(context, task);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          BackToTopButton(visible: showbacktotop, controller: controller),
        ],
      ),
    );
  }

  void updateModel(BuildContext context, Model model) {
    final app = ModelProvider.of(context);
    app.updateModel(model.id!);
  }

  Future<void> callAddTask(BuildContext context) async {
    bool added = await showAddTaskDialog(context);
    if (!context.mounted) return;
    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Task added successfully!'),
          backgroundColor: Color(0xff40dcc7),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
