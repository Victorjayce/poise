import 'package:flutter/material.dart';
import 'package:poise/model/model.dart';
import 'package:poise/widgets/statrow.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final app = appModel;
    return Expanded(
      child: Container(
        color: const Color(0xFF00001D),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Level / XP
            Row(
              children: [
                Text(
                  app.levelText,
                  style: const TextStyle(
                    color: Color(0xFF40DCC7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: app.xpProgress,
                      minHeight: 8,
                      backgroundColor: const Color(0xFF001F5A),
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xFF40DCC7),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  app.xpText,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Top Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: switch (app.averageDifficulty) {
                          20 => Colors.yellow,
                          40 => Colors.green,
                          60 => Colors.blue,
                          80 => Colors.purple,
                          _ => Colors.red,
                        },
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        app.averageDifficulty.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "A.Diff",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      app.successRate.toString(),
                      style: TextStyle(
                        color: switch (app.successRate) {
                          0.6 => Colors.red,
                          0.7 => Colors.purple,
                          0.8 => Colors.blue,
                          0.9 => Colors.green,
                          _ => Colors.yellow,
                        },
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text("S.Rate", style: TextStyle(color: Colors.white)),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      app.confidenceScore.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "C.Score",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            StatRow(
              icon: Icons.warning_amber_rounded,
              title: "R.Exposure",
              value: app.risk.toString(),
            ),
            StatRow(
              icon: Icons.people,
              title: "S.Exposure",
              value: app.social.toString(),
            ),
            StatRow(
              icon: Icons.chat_bubble_rounded,
              title: "C.Exposure",
              value: app.convo.toString(),
            ),
            StatRow(
              icon: Icons.female,
              title: "G.Exposure",
              value: app.gender.toString(),
            ),
            StatRow(
              icon: Icons.fitness_center,
              title: "P.Exposure",
              value: app.physical.toString(),
            ),
            StatRow(
              icon: Icons.record_voice_over,
              title: "V.Exposure",
              value: app.verbal.toString(),
            ),
            StatRow(
              icon: Icons.psychology,
              title: "D.Exposure",
              value: app.decision.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
