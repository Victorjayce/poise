import 'package:flutter/material.dart';
import 'package:poise/model/model.dart';
import 'taskcard.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<ActiveTask> tasks;
  final List<LevelUp> lvltasks;

  const TaskSection({
    super.key,
    required this.title,
    this.tasks = const [],
    this.lvltasks = const [],
  });

  Color difficultyColor(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return Colors.yellow;
      case Difficulty.mid:
        return Colors.green;
      case Difficulty.hard:
        return Colors.blue;
      case Difficulty.extreme:
        return Colors.purple;
      case Difficulty.impossible:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tasks.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskCard(
                task: task,
                lvltask: null,
                color: difficultyColor(task.taskDifficulty),
              );
            },
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lvltasks.length,
            itemBuilder: (context, index) {
              final lvltask = lvltasks[index];
              return TaskCard(
                task: null,
                lvltask: lvltask,
                color: difficultyColor(lvltask.difficulty),
              );
            },
          ),
        ],
      );
    }
  }
}
