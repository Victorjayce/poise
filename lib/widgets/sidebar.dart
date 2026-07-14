import 'package:flutter/material.dart';
import 'difficultyindicator.dart';

class SideBar extends StatelessWidget {
  SideBar({
    super.key,
    required this.onHistory,
    required this.onTasks,
    required this.onExit,
  });

  final VoidCallback onHistory;
  final VoidCallback onTasks;
  final VoidCallback onExit;

  final difficulties = [
    (Colors.yellow, "Easy"),
    (Colors.green, "Mid"),
    (Colors.blue, "Hard"),
    (Colors.purple, "Extreme"),
    (Colors.red, "Impossible"),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff001F5A),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "POISE",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.history, color: Colors.white),
              title: Text(
                "History",
                selectionColor: Colors.grey,
                style: TextStyle(color: Colors.white),
              ),
              onTap: onHistory,
            ),

            ListTile(
              leading: const Icon(Icons.task_alt, color: Colors.white),
              title: const Text(
                "All Tasks",
                style: TextStyle(color: Colors.white),
              ),
              onTap: onTasks,
            ),

            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Difficulty",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: difficulties
                    .map((e) => DifficultyIndicator(color: e.$1, text: e.$2))
                    .toList(),
              ),
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text("Exit", style: TextStyle(color: Colors.white)),
              onTap: onExit,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
