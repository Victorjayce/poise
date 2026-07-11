import 'package:flutter/material.dart';

enum Type { daily, weekly, monthly, milestone, levelup }

enum Category { physical, verbal, social, convo, risk, gender, decision }

enum Cooldown { active, used, half }

enum Difficulty { easy, mid, hard, extreme, impossible }

class ActiveTask {
  int? id;
  final int taskId;
  final String activeTask;
  final Type taskType;
  final int unitsAssigned;
  final DateTime dateAssigned;
  final Category taskCategory;
  final Difficulty taskDifficulty;

  String description;
  bool isCompleted;

  ActiveTask({
    required this.taskId,
    required this.activeTask,
    required this.taskType,
    required this.unitsAssigned,
    required this.dateAssigned,
    required this.taskCategory,
    required this.taskDifficulty,
    this.description = '',
    this.isCompleted = false,
  });
}

class DateValues {
  final DateTime lastUpdate;
  final DateTime weeklyUpdate;
  final DateTime monthlyUpdate;
  bool isStreak;
  DateTime? appStartDate;

  DateValues({
    required this.lastUpdate,
    required this.weeklyUpdate,
    required this.monthlyUpdate,
    required this.isStreak,
  });
}

class HistoryModel {
  int? id;
  final String taskName;
  final int unitsAssigned;
  final double xpGained;
  final DateTime dateCompleted;

  HistoryModel({
    required this.taskName,
    required this.unitsAssigned,
    required this.xpGained,
    required this.dateCompleted,
  });
}

class LevelUp {
  final int level;
  final bool isActive;
  final Difficulty difficulty;
  final String name;
  final Category category;
  final String description;

  LevelUp({
    required this.level,
    required this.isActive,
    required this.difficulty,
    required this.name,
    required this.category,
    required this.description,
  });
}

class Model {
  int? id;
  final String name;
  final String description;
  final Difficulty difficulty;
  final int impact;
  final Type type;
  int timesCompleted;
  int timesAssigned;
  bool isEnabled;

  Model({
    required this.name,
    required this.description,
    required this.difficulty,
    required this.impact,
    required this.type,
    required this.timesCompleted,
    required this.timesAssigned,
    required this.isEnabled,
  });
}

class StatModel {
  double xp;
  int streak;
  int totalCompleted;
  int totalAssigned;
  double completedDifficultyScoreTotal;
  int totalAssignedEasy;
  int totalAssignedMid;
  int totalAssignedHard;
  int totalAssignedExtreme;
  int totalAssignedImpossible;
  int totalAssignedPhysical;
  int totalAssignedVerbal;
  int totalAssignedSocial;
  int totalAssignedConvo;
  int totalAssignedRisk;
  int totalAssignedGender;
  int totalAssignedDecision;
  int totalCompletedPhysical;
  int totalCompletedVerbal;
  int totalCompletedSocial;
  int totalCompletedConvo;
  int totalCompletedRisk;
  int totalCompletedGender;
  int totalCompletedDecision;
  int completedDifficultyScorePhysical;
  int completedDifficultyScoreVerbal;
  int completedDifficultyScoreSocial;
  int completedDifficultyScoreConvo;
  int completedDifficultyScoreRisk;
  int completedDifficultyScoreGender;
  int completedDifficultyScoreDecision;
  int xpPhysical;
  int xpVerbal;
  int xpSocial;
  int xpConvo;
  int xpRisk;
  int xpGender;
  int xpDecision;

  StatModel({
    required this.xp,
    required this.streak,
    required this.totalCompleted,
    required this.totalAssigned,
    required this.completedDifficultyScoreTotal,
    required this.totalAssignedEasy,
    required this.totalAssignedMid,
    required this.totalAssignedHard,
    required this.totalAssignedExtreme,
    required this.totalAssignedImpossible,
    required this.totalAssignedPhysical,
    required this.totalAssignedVerbal,
    required this.totalAssignedSocial,
    required this.totalAssignedConvo,
    required this.totalAssignedRisk,
    required this.totalAssignedGender,
    required this.totalAssignedDecision,
    required this.totalCompletedPhysical,
    required this.totalCompletedVerbal,
    required this.totalCompletedSocial,
    required this.totalCompletedConvo,
    required this.totalCompletedRisk,
    required this.totalCompletedGender,
    required this.totalCompletedDecision,
    required this.completedDifficultyScorePhysical,
    required this.completedDifficultyScoreVerbal,
    required this.completedDifficultyScoreSocial,
    required this.completedDifficultyScoreConvo,
    required this.completedDifficultyScoreRisk,
    required this.completedDifficultyScoreGender,
    required this.completedDifficultyScoreDecision,
    required this.xpPhysical,
    required this.xpVerbal,
    required this.xpSocial,
    required this.xpConvo,
    required this.xpRisk,
    required this.xpGender,
    required this.xpDecision,
  });
}

class DifficultySet {
  int easy;
  int mid;
  int hard;
  int extreme;
  int impossible;
  DifficultySet({
    this.easy = 0,
    this.mid = 0,
    this.hard = 0,
    this.extreme = 0,
    this.impossible = 0,
  });
}

class ProgressionRule {
  int monthStart;
  int monthEnd;
  int weekStart;
  int weekEnd;
  DifficultySet daily;
  DifficultySet weekly;
  DifficultySet monthly;

  ProgressionRule({
    this.monthStart = 0,
    this.monthEnd = 0,
    this.weekStart = 0,
    this.weekEnd = 0,
    DifficultySet? daily,
    DifficultySet? weekly,
    DifficultySet? monthly,
  }) : daily = daily ?? DifficultySet(),
       weekly = weekly ?? DifficultySet(),
       monthly = monthly ?? DifficultySet();
}

class AppModel extends ChangeNotifier {
  final List<ActiveTask> activetasks = [];
  final List<Model> models = [];
  final List<HistoryModel> history = [];
  final StatModel statModel = StatModel(
    xp: 0,
    streak: 0,
    totalCompleted: 0,
    totalAssigned: 0,
    completedDifficultyScoreTotal: 0,
    totalAssignedEasy: 0,
    totalAssignedMid: 0,
    totalAssignedHard: 0,
    totalAssignedExtreme: 0,
    totalAssignedImpossible: 0,
    totalAssignedPhysical: 0,
    totalAssignedVerbal: 0,
    totalAssignedSocial: 0,
    totalAssignedConvo: 0,
    totalAssignedRisk: 0,
    totalAssignedGender: 0,
    totalAssignedDecision: 0,
    totalCompletedPhysical: 0,
    totalCompletedVerbal: 0,
    totalCompletedSocial: 0,
    totalCompletedConvo: 0,
    totalCompletedRisk: 0,
    totalCompletedGender: 0,
    totalCompletedDecision: 0,
    completedDifficultyScorePhysical: 0,
    completedDifficultyScoreVerbal: 0,
    completedDifficultyScoreSocial: 0,
    completedDifficultyScoreConvo: 0,
    completedDifficultyScoreRisk: 0,
    completedDifficultyScoreGender: 0,
    completedDifficultyScoreDecision: 0,
    xpPhysical: 0,
    xpVerbal: 0,
    xpSocial: 0,
    xpConvo: 0,
    xpRisk: 0,
    xpGender: 0,
    xpDecision: 0,
  );
  final DateValues dateValues = DateValues(
    lastUpdate: DateTime.now(),
    weeklyUpdate: DateTime.now(),
    monthlyUpdate: DateTime.now(),
    isStreak: false,
  );
  final List<LevelUp> levelUp = [];
}

final appModel = AppModel();

class ModelProvider extends InheritedNotifier<AppModel> {
  const ModelProvider({
    super.key,
    required AppModel appModel,
    required super.child,
  }) : super(notifier: appModel);

  static AppModel of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ModelProvider>();
    assert(provider != null, 'No ModelProvider found in context.');
    return provider!.notifier!;
  }
}
