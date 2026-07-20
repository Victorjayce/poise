import 'package:flutter/material.dart';
import 'package:poise/model/model.dart';
import 'package:poise/extensions/datetimextension.dart';
import 'package:poise/widgets/backtotop.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
            color: const Color(0xFF00001B),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                          color: Color(0xFF40DCC7),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

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

                // History List
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color(0xFF00001D),
                    child: app.history.isEmpty
                        ? const Center(
                            child: Text(
                              'You have not completed any tasks yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: controller,
                            padding: const EdgeInsets.only(bottom: 60),
                            itemCount: app.history.length,
                            itemBuilder: (context, index) {
                              final history = app.history[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E2D4A),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            history.taskName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          '+${history.xpGained.toStringAsFixed(0)} XP',
                                          style: const TextStyle(
                                            color: Color(0xFF40DCC7),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      history.dateCompleted.timeAgo,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
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
}
