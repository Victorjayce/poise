import 'package:flutter/material.dart';
import 'package:poise/model/model.dart';

class TaskCard extends StatefulWidget {
  final ActiveTask? task;
  final LevelUp? lvltask;
  final Color color;

  const TaskCard({
    super.key,
    required this.task,
    required this.lvltask,
    required this.color,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.task != null) {
      final task = widget.task!;
      return GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(8),

          decoration: BoxDecoration(
            color: Color(0xff001F5A),
            borderRadius: BorderRadius.circular(6),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: task.isCompleted,
                fillColor: WidgetStatePropertyAll(widget.color),
                side: BorderSide.none,
                // once checked, don't allow unchecking
                onChanged: task.isCompleted
                    ? null
                    : (value) {
                        if (value == true) {
                          check(context, task);
                        }
                      },
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.activeTask,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        if (task.description.isNotEmpty)
                          IconButton(
                            icon: Icon(
                              expanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: widget.color,
                            ),

                            onPressed: () {
                              setState(() {
                                expanded = !expanded;
                              });
                            },
                          ),
                      ],
                    ),

                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),

                      secondChild: Text(
                        task.description,
                        style: TextStyle(color: Colors.white),
                      ),

                      crossFadeState: expanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,

                      duration: const Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final task = widget.lvltask!;
      return GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(8),

          decoration: BoxDecoration(
            color: Color(0xff001F5A),
            borderRadius: BorderRadius.circular(6),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: !task.isActive,
                fillColor: WidgetStatePropertyAll(widget.color),
                side: BorderSide.none,
                // once checked, don't allow unchecking
                onChanged: !task.isActive
                    ? null
                    : (value) {
                        if (value == true) {
                          checklevel(context, task);
                        }
                      },
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        if (task.description.isNotEmpty)
                          IconButton(
                            icon: Icon(
                              expanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: widget.color,
                            ),

                            onPressed: () {
                              setState(() {
                                expanded = !expanded;
                              });
                            },
                          ),
                      ],
                    ),

                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),

                      secondChild: Text(
                        task.description,
                        style: TextStyle(color: Colors.white),
                      ),

                      crossFadeState: expanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,

                      duration: const Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> check(BuildContext context, ActiveTask task) async {
    final app = ModelProvider.of(context);
    final (reached, level) = await app.checktask(task);
    if (!context.mounted) return;
    if (reached > 0) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xff00001d),
            title: const Row(
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  color: Color(0xff40dcc7),
                ),
                SizedBox(width: 8),
                Text("Level Up!"),
              ],
            ),
            content: Text(
              "Congratulation on reaching Level ${level.toString()}\nLevel Up tasks will be assigned tommorow",
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task Completed!'),
        backgroundColor: Color(0xff40dcc7),
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> checklevel(BuildContext context, LevelUp task) async {
    final app = ModelProvider.of(context);
    final (reached, level) = await app.checklvltasks(task);
    if (!context.mounted) return;
    if (reached > 0) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xff00001d),
            title: const Row(
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  color: Color(0xff40dcc7),
                ),
                SizedBox(width: 8),
                Text("Level Up!"),
              ],
            ),
            content: Text(
              "Congratulation on reaching Level ${level.toString()} \nLevel Up tasks will be assigned tommorow",
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task Completed!'),
        backgroundColor: Color(0xff40dcc7),
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
