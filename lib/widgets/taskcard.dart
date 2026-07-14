import 'package:flutter/material.dart';
import 'package:poise/logics/statlogic.dart';
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
      return Container(
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
                        setState(() {
                          task.isCompleted = true;
                        });
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
      );
    } else {
      final task = widget.lvltask!;
      return Container(
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
                        setState(() {
                          task.isActive = false;
                        });
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
      );
    }
  }

  void checktasks(BuildContext context, ActiveTask task) {
    task.isCompleted = true;
    final app = ModelProvider.of(context);
    double addedxp = SModelValues.xpAdded(task, app.statModel);
    final statModel = SModelValues.statCalc(
      app.statModel,
      task,
      app.dateValues,
    );
    if (!app.dateValues.isStreak) {
      final newDate = app.dateValues;
      newDate.isStreak = true;
      app.updateDate(newDate);
    }
    //int level = SModelValues.checkLevel(app.statModel.xp.toInt());
    //update db and check if lvl task is updated
    HistoryModel newHistory = HistoryModel(
      taskName: task.activeTask,
      xpGained: addedxp,
      dateCompleted: DateTime.now(),
    );
    app.addHistory(newHistory);
    app.updateStats(statModel);
  }

  void checklvltasks(BuildContext context, LevelUp task) {
    task.isActive = false;
    final app = ModelProvider.of(context);
    double addedxp = SModelValues.lvlXpAdded(task, app.statModel);
    final statModel = SModelValues.statLvlCalc(
      app.statModel,
      task,
      app.dateValues,
    );
    if (!app.dateValues.isStreak) {
      final newDate = app.dateValues;
      newDate.isStreak = true;
      app.updateDate(newDate);
    }
    HistoryModel newHistory = HistoryModel(
      taskName: task.name,
      xpGained: addedxp,
      dateCompleted: DateTime.now(),
    );
    app.addHistory(newHistory);
    app.updateStats(statModel);
  }
}
