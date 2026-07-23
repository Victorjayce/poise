import 'package:flutter/material.dart';
import 'package:poise/model/model.dart';
import 'package:poise/widgets/backtotop.dart';
import 'package:poise/widgets/taskdisplay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dailytasks = appModel.activeTasks
        .where((a) => a.taskType == Type.daily)
        .toList();
    final weeklytasks = appModel.activeTasks
        .where((a) => a.taskType == Type.weekly)
        .toList();
    final monthlytasks = appModel.activeTasks
        .where((a) => a.taskType == Type.monthly)
        .toList();
    final leveluptasks = appModel.levelUp
        .where((a) => a.isActive == true)
        .toList();
    final milestonetasks = appModel.activeTasks
        .where((a) => a.taskType == Type.milestone)
        .toList();
    return Stack(
      children: [
        Container(
          color: Color(0xff001f5a),
          child: SingleChildScrollView(
            controller: controller,
            child: Container(
              color: Color(0xFF00001D),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  if (dailytasks.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskSection(title: 'Daily', tasks: dailytasks),
                    ),
                  if (dailytasks.isNotEmpty) const SizedBox(height: 5),
                  if (weeklytasks.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskSection(title: 'Weekly', tasks: weeklytasks),
                    ),
                  if (weeklytasks.isNotEmpty) const SizedBox(height: 5),
                  if (monthlytasks.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskSection(title: 'Monthly', tasks: monthlytasks),
                    ),
                  if (monthlytasks.isNotEmpty) const SizedBox(height: 5),
                  if (leveluptasks.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskSection(
                        title: 'LevelUp',
                        lvltasks: leveluptasks,
                      ),
                    ),
                  if (leveluptasks.isNotEmpty) const SizedBox(height: 5),
                  if (milestonetasks.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskSection(
                        title: 'Milestone',
                        tasks: milestonetasks,
                      ),
                    ),
                  if (milestonetasks.isNotEmpty) const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        BackToTopButton(visible: showbacktotop, controller: controller),
      ],
    );
  }
}
