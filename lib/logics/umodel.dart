import 'dart:math';

import 'package:poise/model/model.dart';

class UModelValues {
  static const double overallRepetitionAnchor = 12;
  static const double categoryRepetitionAnchor = 8;

  static double avgDiff(StatModel model) {
    if (model.totalCompleted == 0) return 0;

    return clamp100(model.completedDifficultyScoreTotal / model.totalCompleted);
  }

  static double sRate(StatModel model) {
    if (model.totalAssigned == 0) return 0;

    return min(1.0, model.totalCompleted / model.totalAssigned);
  }

  static double confidenceScore(StatModel model) {
    final averageDifficulty = avgDiff(model);
    final successRate = sRate(model);
    final repetition = repetitionFactor(
      model.totalCompleted,
      overallRepetitionAnchor,
    );

    return clamp100(averageDifficulty * successRate * repetition);
  }

  static double pConfidence(StatModel model) => categoryConfidence(
    model.completedDifficultyScorePhysical,
    model.totalCompletedPhysical,
    model.totalAssignedPhysical,
  );

  static double vConfidence(StatModel model) => categoryConfidence(
    model.completedDifficultyScoreVerbal,
    model.totalCompletedVerbal,
    model.totalAssignedVerbal,
  );

  static double sConfidence(StatModel model) => categoryConfidence(
    model.completedDifficultyScoreSocial,
    model.totalCompletedSocial,
    model.totalAssignedSocial,
  );

  static double cConfidence(StatModel model) => categoryConfidence(
    model.completedDifficultyScoreConvo,
    model.totalCompletedConvo,
    model.totalAssignedConvo,
  );

  static double rConfidence(StatModel model) => categoryConfidence(
    model.completedDifficultyScoreRisk,
    model.totalCompletedRisk,
    model.totalAssignedRisk,
  );

  static double gConfidence(StatModel model) => categoryConfidence(
    model.completedDifficultyScoreGender,
    model.totalCompletedGender,
    model.totalAssignedGender,
  );

  static double dConfidence(StatModel model) => categoryConfidence(
    model.completedDifficultyScoreDecision,
    model.totalCompletedDecision,
    model.totalAssignedDecision,
  );

  static double categoryConfidence(
    double completedDifficultyScore,
    int completedCount,
    int assignedCount,
  ) {
    if (completedCount == 0 || assignedCount == 0) {
      return 0;
    }

    final averageDifficulty = completedDifficultyScore / completedCount;

    final successRate = min(1.0, completedCount / assignedCount);

    final repetition = repetitionFactor(
      completedCount,
      categoryRepetitionAnchor,
    );

    return clamp100(averageDifficulty * successRate * repetition);
  }

  static double repetitionFactor(int completedCount, double anchor) {
    if (completedCount <= 0) return 0;

    return completedCount / (completedCount + anchor);
  }

  static double clamp100(double value) => min(100.0, max(0.0, value));
}
