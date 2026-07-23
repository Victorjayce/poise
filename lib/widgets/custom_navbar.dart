import 'package:flutter/material.dart';
import 'package:poise/widgets/addtask.dart';
import 'package:poise/model/model.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentPage,
    required this.controller,
  });

  final int currentPage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    const background = Color(0xff001F5A);
    const selected = Color(0xff40DCC7);
    final streak = ModelProvider.of(context).statModel.streak;

    return Container(
      color: background,
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.menu, color: selected, size: 40),
              ),

              const Spacer(),

              Icon(
                Icons.local_fire_department,
                color: streak >= 1 ? Colors.red : Colors.grey,
                size: 35,
              ),

              const SizedBox(width: 4),

              Text(
                streak.toString(),
                style: TextStyle(
                  color: streak >= 1 ? Colors.white : Colors.grey,
                  fontSize: 30,
                ),
              ),

              const Spacer(),

              IconButton(
                onPressed: () => callAddTask(context),
                icon: const Icon(Icons.add, color: selected, size: 40),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: currentPage == 0 ? selected : background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.home, color: Color(0xff00001d), size: 40),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: currentPage == 1 ? selected : background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.bar_chart,
                      color: Color(0xff00001d),
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> callAddTask(BuildContext context) async {
    await showAddTaskDialog(context);
    if (!context.mounted) return;
  }
}
