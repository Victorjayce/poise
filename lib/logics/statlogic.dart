import 'dart:math';

import 'package:poise/model/model.dart';

class SModelValues {
  static const double noStreakPenaltyMultiplier = 0.65;
  static const double streakBonusStep = 0.05;
  static const int maxStreakBonusDays = 7;

  static double xp(double oldXp, Difficulty diff, StatModel model) {
    final gain = calculateXpGain(diff, model.streak);
    return oldXp + gain;
  }

  static double xpAdded(ActiveTask task, StatModel model) =>
      calculateXpGain(task.taskDifficulty, model.streak);

  static double lvlXpAdded(LevelUp task, StatModel model) =>
      calculateXpGain(task.difficulty, model.streak);

  static int streak(int oldStreak) => oldStreak + 1;

  static void statLoadModel(
    StatModel statModel,
    List<ActiveTask> tasks,
    int taskCount,
  ) {
    statModel.totalAssigned += taskCount;

    final phy = tasks.where((t) => t.taskCategory == Category.physical).length;
    final verbal = tasks.where((t) => t.taskCategory == Category.verbal).length;
    final convo = tasks.where((t) => t.taskCategory == Category.convo).length;
    final social = tasks.where((t) => t.taskCategory == Category.social).length;
    final risk = tasks.where((t) => t.taskCategory == Category.risk).length;
    final gender = tasks.where((t) => t.taskCategory == Category.gender).length;
    final decision = tasks
        .where((t) => t.taskCategory == Category.decision)
        .length;

    final easy = tasks.where((t) => t.taskDifficulty == Difficulty.easy).length;
    final mid = tasks.where((t) => t.taskDifficulty == Difficulty.mid).length;
    final hard = tasks.where((t) => t.taskDifficulty == Difficulty.hard).length;
    final extreme = tasks
        .where((t) => t.taskDifficulty == Difficulty.extreme)
        .length;
    final impossible = tasks
        .where((t) => t.taskDifficulty == Difficulty.impossible)
        .length;

    statModel.totalAssignedEasy += easy;
    statModel.totalAssignedMid += mid;
    statModel.totalAssignedHard += hard;
    statModel.totalAssignedExtreme += extreme;
    statModel.totalAssignedImpossible += impossible;

    statModel.totalAssignedPhysical += phy;
    statModel.totalAssignedVerbal += verbal;
    statModel.totalAssignedConvo += convo;
    statModel.totalAssignedSocial += social;
    statModel.totalAssignedRisk += risk;
    statModel.totalAssignedGender += gender;
    statModel.totalAssignedDecision += decision;
  }

  static StatModel statCalc(StatModel stat, ActiveTask task, DateValues date) {
    applyCompletion(stat, task.taskDifficulty, task.taskCategory, date);
    return stat;
  }

  static StatModel statLvlCalc(StatModel stat, LevelUp task, DateValues date) {
    applyCompletion(stat, task.difficulty, task.category, date);
    return stat;
  }

  static double physicalXp(double oldXp, double gain) => oldXp + gain;

  static double verbalXp(double oldXp, double gain) => oldXp + gain;

  static double convoXp(double oldXp, double gain) => oldXp + gain;

  static double socialXp(double oldXp, double gain) => oldXp + gain;

  static double riskXp(double oldXp, double gain) => oldXp + gain;

  static double genderXp(double oldXp, double gain) => oldXp + gain;

  static double decisionXp(double oldXp, double gain) => oldXp + gain;

  static ({int level, int currentXp, int nextLevelXp}) getLevel(int xp) {
    const thresholds = [
      0,
      100,
      300,
      1000,
      2000,
      3500,
      6000,
      9500,
      14000,
      19000,
      25000,
      31500,
      45000,
    ];

    for (var i = 1; i < thresholds.length; i++) {
      if (xp < thresholds[i]) {
        final previous = thresholds[i - 1];
        final next = thresholds[i];
        return (
          level: i,
          currentXp: xp - previous,
          nextLevelXp: next - previous,
        );
      }
    }

    var level = 12;
    var totalXp = 45000;
    var increment = 8000;

    while (totalXp + increment <= xp) {
      totalXp += increment;
      increment += 500;
      level++;
    }

    return (level: level, currentXp: xp - totalXp, nextLevelXp: increment);
  }

  static int checkLevel(int xp) {
    const thresholds = [
      0,
      100,
      300,
      1000,
      2000,
      3500,
      6000,
      9500,
      14000,
      19000,
      25000,
      31500,
      45000,
    ];

    for (var i = 1; i < thresholds.length; i++) {
      if (xp < thresholds[i]) return i;
    }

    var level = 12;
    var totalXp = 45000;
    var increment = 8000;

    while (totalXp + increment <= xp) {
      totalXp += increment;
      increment += 500;
      level++;
    }

    return level;
  }

  static double getDifficultyScore(Difficulty difficulty) {
    return switch (difficulty) {
      Difficulty.easy => 20,
      Difficulty.mid => 30,
      Difficulty.hard => 40,
      Difficulty.extreme => 50,
      Difficulty.impossible => 60,
    };
  }

  static void applyCompletion(
    StatModel stat,
    Difficulty difficulty,
    Category category,
    DateValues date,
  ) {
    final xpGain = calculateXpGain(difficulty, stat.streak);
    final difficultyScore = getDifficultyScore(difficulty);

    stat.totalCompleted++;
    stat.completedDifficultyScoreTotal += difficultyScore;

    switch (category) {
      case Category.physical:
        stat.totalCompletedPhysical++;
        stat.completedDifficultyScorePhysical += difficultyScore;
        stat.xpPhysical = physicalXp(stat.xpPhysical, xpGain);
        break;

      case Category.verbal:
        stat.totalCompletedVerbal++;
        stat.completedDifficultyScoreVerbal += difficultyScore;
        stat.xpVerbal = verbalXp(stat.xpVerbal, xpGain);
        break;

      case Category.convo:
        stat.totalCompletedConvo++;
        stat.completedDifficultyScoreConvo += difficultyScore;
        stat.xpConvo = convoXp(stat.xpConvo, xpGain);
        break;

      case Category.social:
        stat.totalCompletedSocial++;
        stat.completedDifficultyScoreSocial += difficultyScore;
        stat.xpSocial = socialXp(stat.xpSocial, xpGain);
        break;

      case Category.risk:
        stat.totalCompletedRisk++;
        stat.completedDifficultyScoreRisk += difficultyScore;
        stat.xpRisk = riskXp(stat.xpRisk, xpGain);
        break;

      case Category.gender:
        stat.totalCompletedGender++;
        stat.completedDifficultyScoreGender += difficultyScore;
        stat.xpGender = genderXp(stat.xpGender, xpGain);
        break;

      case Category.decision:
        stat.totalCompletedDecision++;
        stat.completedDifficultyScoreDecision += difficultyScore;
        stat.xpDecision = decisionXp(stat.xpDecision, xpGain);
        break;
    }

    stat.xp += xpGain;

    if (!date.isStreak) {
      stat.streak = stat.streak == 0 ? 1 : stat.streak + 1;
    }
  }

  static double calculateXpGain(Difficulty difficulty, int streak) =>
      calculateXpGainFromSeed(getDifficultyXpSeed(difficulty), streak);

  static double calculateXpGainFromSeed(int diff, int streak) {
    var gain = diff * 2.5;

    if (streak > 0) {
      gain *= getStreakMultiplier(streak);
    } else {
      gain *= noStreakPenaltyMultiplier;
    }

    return gain;
  }

  static double getStreakMultiplier(int streak) {
    final effectiveStreak = min(streak, maxStreakBonusDays);
    return 1 + (effectiveStreak * streakBonusStep);
  }

  static int getDifficultyXpSeed(Difficulty difficulty) {
    return switch (difficulty) {
      Difficulty.easy => 10,
      Difficulty.mid => 20,
      Difficulty.hard => 30,
      Difficulty.extreme => 50,
      Difficulty.impossible => 100,
    };
  }
}
