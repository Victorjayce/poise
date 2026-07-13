import 'package:poise/model/model.dart';

class ProgressionFactory {
  static List<ProgressionRule> createRules() {
    return [
      ProgressionRule(
        monthStart: 1,
        monthEnd: 1,
        weekStart: 1,
        weekEnd: 1,
        daily: DifficultySet(easy: 3),
        weekly: DifficultySet(easy: 2, mid: 2),
        monthly: DifficultySet(mid: 3, hard: 2),
      ),

      ProgressionRule(
        monthStart: 1,
        monthEnd: 1,
        weekStart: 2,
        weekEnd: 4,
        daily: DifficultySet(easy: 2, mid: 1),
        weekly: DifficultySet(easy: 1, mid: 3),
        monthly: DifficultySet(mid: 3, hard: 2),
      ),

      ProgressionRule(
        monthStart: 2,
        monthEnd: 2,
        weekStart: 1,
        weekEnd: 2,
        daily: DifficultySet(easy: 1, mid: 2),
        weekly: DifficultySet(mid: 4),
        monthly: DifficultySet(mid: 2, hard: 3),
      ),

      ProgressionRule(
        monthStart: 2,
        monthEnd: 2,
        weekStart: 3,
        weekEnd: 4,
        daily: DifficultySet(mid: 3),
        weekly: DifficultySet(mid: 2, hard: 2),
        monthly: DifficultySet(mid: 2, hard: 3),
      ),

      ProgressionRule(
        monthStart: 3,
        monthEnd: 3,
        weekStart: 1,
        weekEnd: 4,
        daily: DifficultySet(mid: 2, hard: 1),
        weekly: DifficultySet(mid: 1, hard: 3),
        monthly: DifficultySet(mid: 1, hard: 3, extreme: 1),
      ),

      ProgressionRule(
        monthStart: 4,
        monthEnd: 4,
        weekStart: 1,
        weekEnd: 4,
        daily: DifficultySet(mid: 2, hard: 1),
        weekly: DifficultySet(hard: 2, extreme: 2),
        monthly: DifficultySet(hard: 4, extreme: 1),
      ),

      ProgressionRule(
        monthStart: 5,
        monthEnd: 6,
        weekStart: 1,
        weekEnd: 4,
        daily: DifficultySet(mid: 1, hard: 2),
        weekly: DifficultySet(hard: 2, extreme: 2),
        monthly: DifficultySet(hard: 4, extreme: 1),
      ),

      ProgressionRule(
        monthStart: 7,
        monthEnd: 9,
        weekStart: 1,
        weekEnd: 4,
        daily: DifficultySet(hard: 3),
        weekly: DifficultySet(hard: 1, extreme: 3),
        monthly: DifficultySet(hard: 2, extreme: 3),
      ),

      ProgressionRule(
        monthStart: 10,
        monthEnd: 11,
        weekStart: 1,
        weekEnd: 4,
        daily: DifficultySet(hard: 2, extreme: 1),
        weekly: DifficultySet(extreme: 4),
        monthly: DifficultySet(extreme: 5),
      ),

      ProgressionRule(
        monthStart: 12,
        monthEnd: 0x7fffffff, // int.MaxValue
        weekStart: 1,
        weekEnd: 4,
        daily: DifficultySet(hard: 1, extreme: 2),
        weekly: DifficultySet(extreme: 2, impossible: 2),
        monthly: DifficultySet(extreme: 3, impossible: 2),
      ),
    ];
  }
}
