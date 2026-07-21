import 'dart:math';
import 'package:poise/logics/statlogic.dart';
import 'package:poise/logics/dbservice.dart';
import 'package:poise/model/model.dart';

Future<bool> loading(
  List<Model> models,
  List<ActiveTask> oldActiveTasks,
  StatModel statModel,
  DateValues date,
  bool newDay,
  List<ProgressionRule> progressionRules,
  DbService db,
) async {
  ({List<ActiveTask> tasks, List<Model> models}) dailyResult;
  ({List<ActiveTask> tasks, List<Model> models}) weeklyResult;
  ({List<ActiveTask> tasks, List<Model> models}) monthlyResult;

  List<Model> modelsToUpdate = [];
  List<ActiveTask> newTasks = [];
  List<ActiveTask> oldTasksToRemove = [];
  int taskCount = 0;

  date.appStartDate ??= DateTime.now();
  final currentDate = DateTime.now();

  if (dateOnly(date.lastUpdate).isBefore(dateOnly(currentDate))) {
    final dayModels = models.where((a) => a.type == Type.daily).toList();
    int missedDays =
        dateOnly(currentDate).difference(dateOnly(date.lastUpdate)).inDays - 1;
    if (missedDays > 0) statModel.streak = 0;
    date.lastUpdate = currentDate;
    newDay = true;

    final rule = getRule(date, progressionRules, missedDays);

    dailyResult = newDailyTask(dayModels, rule);
    newTasks.addAll(dailyResult.tasks);
    modelsToUpdate.addAll(dailyResult.models);
    taskCount += dailyResult.tasks.length;

    var old = oldActiveTasks.where((a) => a.taskType == Type.daily).toList();
    oldTasksToRemove.addAll(old);

    if (!date.isStreak) statModel.streak = 0;
    date.isStreak = false;

    // weekly
    if (weekStart(date.weeklyUpdate).isBefore(weekStart(currentDate))) {
      final weekModels = models.where((a) => a.type == Type.weekly).toList();
      date.weeklyUpdate = currentDate;
      weeklyResult = newWeeklyTask(weekModels, rule);
      newTasks.addAll(weeklyResult.tasks);
      modelsToUpdate.addAll(weeklyResult.models);
      taskCount += weeklyResult.tasks.length;

      var oldWeekly = oldActiveTasks
          .where((a) => a.taskType == Type.weekly)
          .toList();
      oldTasksToRemove.addAll(oldWeekly);
    }

    // monthly
    if (date.monthlyUpdate.month < currentDate.month ||
        date.monthlyUpdate.year < currentDate.year) {
      final monthModels = models.where((a) => a.type == Type.monthly).toList();
      date.monthlyUpdate = currentDate;
      monthlyResult = newMonthlyTask(monthModels, rule);
      newTasks.addAll(monthlyResult.tasks);
      modelsToUpdate.addAll(monthlyResult.models);
      taskCount += monthlyResult.tasks.length;

      var oldMonthly = oldActiveTasks
          .where((a) => a.taskType == Type.monthly)
          .toList();
      oldTasksToRemove.addAll(oldMonthly);
    }

    SModelValues.statLoadModel(statModel, newTasks, taskCount);

    await db.loadingUpdates(
      oldTasksToRemove,
      newTasks,
      modelsToUpdate,
      statModel,
      date,
    );
  }

  return newDay;
}

/// Strips the time-of-day so two DateTimes can be compared by calendar day
/// alone — the Dart equivalent of C#'s `DateTime.Date`.
DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

DateTime weekStart(DateTime date) {
  final diff = (7 + (date.weekday - DateTime.monday)) % 7;
  return dateOnly(date).subtract(Duration(days: diff));
}

ProgressionRule getRule(
  DateValues startDate,
  List<ProgressionRule> rules,
  int missed,
) {
  var days = DateTime.now().difference(startDate.appStartDate!).inDays;
  days = max(0, days - missed);

  final month = (days ~/ 30) + 1;
  var week = ((days % 30) ~/ 7) + 1;
  if (week > 4) week = 4;

  return rules.firstWhere(
    (r) =>
        month >= r.monthStart &&
        month <= r.monthEnd &&
        week >= r.weekStart &&
        week <= r.weekEnd,
  );
}

({List<ActiveTask> tasks, List<Model> models}) newDailyTask(
  List<Model> pool,
  ProgressionRule rule,
) {
  return pickTasks(pool, {
    Difficulty.easy: rule.daily.easy,
    Difficulty.mid: rule.daily.mid,
    Difficulty.hard: rule.daily.hard,
    Difficulty.extreme: rule.daily.extreme,
    Difficulty.impossible: rule.daily.impossible,
  });
}

({List<ActiveTask> tasks, List<Model> models}) newWeeklyTask(
  List<Model> pool,
  ProgressionRule rule,
) {
  return pickTasks(pool, {
    Difficulty.easy: rule.weekly.easy,
    Difficulty.mid: rule.weekly.mid,
    Difficulty.hard: rule.weekly.hard,
    Difficulty.extreme: rule.weekly.extreme,
    Difficulty.impossible: rule.weekly.impossible,
  });
}

({List<ActiveTask> tasks, List<Model> models}) newMonthlyTask(
  List<Model> pool,
  ProgressionRule rule,
) {
  return pickTasks(pool, {
    Difficulty.easy: rule.monthly.easy,
    Difficulty.mid: rule.monthly.mid,
    Difficulty.hard: rule.monthly.hard,
    Difficulty.extreme: rule.monthly.extreme,
    Difficulty.impossible: rule.monthly.impossible,
  });
}

/// Shared picker — daily/weekly/monthly only differ by which rule counts
/// they read and how units are calculated.
({List<ActiveTask> tasks, List<Model> models}) pickTasks(
  List<Model> pool,
  Map<Difficulty, int?> difficultyMap,
) {
  final random = Random();
  final selected = <Model>[];

  for (final entry in difficultyMap.entries) {
    final countNeeded = entry.value ?? 0;
    if (countNeeded <= 0) continue;

    final candidates = pool.where((m) => m.difficulty == entry.key).toList();
    for (var i = 0; i < countNeeded && candidates.isNotEmpty; i++) {
      final index = random.nextInt(candidates.length);
      final picked = candidates[index];
      selected.add(picked);
      pool.remove(picked);
      candidates.removeAt(index);
    }
  }

  final activeTasks = <ActiveTask>[];
  for (final item in selected) {
    activeTasks.add(
      ActiveTask(
        taskId: item.id!,
        activeTask: item.name,
        taskType: item.type,
        isCompleted: false,
        description: item.description,
        taskCategory: item.category,
        taskDifficulty: item.difficulty,
      ),
    );
  }

  return (tasks: activeTasks, models: selected);
}
