import 'package:flutter/material.dart';
import 'package:poise/logics/progressionfactory.dart';
import 'package:poise/logics/statlogic.dart';
import 'package:poise/logics/umodel.dart';
import 'package:poise/logics/dbservice.dart';
import 'package:poise/logics/loading.dart';
import 'dart:developer' as dev;

enum Type {
  daily('Daily'),
  weekly('Weekly'),
  monthly('Monthly'),
  milestone('MileStone'),
  levelup('LevelUp');

  const Type(this.title);
  final String title;
}

enum Category {
  physical('Physical'),
  verbal('Verbal'),
  social('Social'),
  convo('Convo'),
  risk('Risk'),
  gender('Gender'),
  decision('Decision');

  const Category(this.title);
  final String title;
}

enum Cooldown { active, used, half }

enum Difficulty {
  easy(Colors.yellow, 'Easy'),
  mid(Colors.green, 'Mid'),
  hard(Colors.blue, 'Hard'),
  extreme(Colors.purple, 'Extreme'),
  impossible(Colors.red, 'Impossible');

  const Difficulty(this.color, this.title);
  final Color color;
  final String title;
}

class ActiveTask {
  int? id;
  final int taskId;
  final String activeTask;
  final Type taskType;
  final Category taskCategory;
  final Difficulty taskDifficulty;

  String description;
  bool isCompleted;

  ActiveTask({
    required this.taskId,
    required this.activeTask,
    required this.taskType,
    required this.taskCategory,
    required this.taskDifficulty,
    this.description = '',
    this.isCompleted = false,
  });
}

class DateValues {
  DateTime lastUpdate;
  DateTime weeklyUpdate;
  DateTime monthlyUpdate;
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
  final double xpGained;
  final DateTime dateCompleted;

  HistoryModel({
    required this.taskName,
    required this.xpGained,
    required this.dateCompleted,
  });
}

class LevelUp {
  final int level;
  bool isActive;
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
  final Type type;
  bool isEnabled;
  final Category category;

  Model({
    required this.name,
    required this.description,
    required this.difficulty,
    required this.type,
    required this.isEnabled,
    required this.category,
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
  double completedDifficultyScorePhysical;
  double completedDifficultyScoreVerbal;
  double completedDifficultyScoreSocial;
  double completedDifficultyScoreConvo;
  double completedDifficultyScoreRisk;
  double completedDifficultyScoreGender;
  double completedDifficultyScoreDecision;
  double xpPhysical;
  double xpVerbal;
  double xpSocial;
  double xpConvo;
  double xpRisk;
  double xpGender;
  double xpDecision;

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
  bool isLoading = true;
  late List<Model> models;
  late List<HistoryModel> history;
  late List<ActiveTask> activeTasks;
  late List<Model> qualifiedModels;

  StatModel statModel = StatModel(
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
  DateValues dateValues = DateValues(
    lastUpdate: DateTime.now(),
    weeklyUpdate: DateTime.now(),
    monthlyUpdate: DateTime.now(),
    isStreak: false,
  );
  late List<LevelUp> levelUp;
  final List<ProgressionRule> progressionRules =
      ProgressionFactory.createRules();
  final db = DbService.instance;

  Future<bool> load() async {
    bool newDay = false;
    models = await db.getModels();
    history = await db.getHistory();
    levelUp = await db.getLevelUps();
    activeTasks = await db.getActiveTasks();
    qualifiedModels = await db.getQualifiedModels();
    final dateMod = await db.getDateValues();
    dateValues = dateMod.first;
    final statMod = await db.getStatModels();
    statModel = statMod.first;

    dev.log("========== BEFORE LOADING ==========");
    dev.log("Models: ${models.length}");
    dev.log("Existing ActiveTasks: ${activeTasks.length}");
    dev.log("Last Update: ${dateValues.lastUpdate}");
    dev.log("Today: ${DateTime.now()}");
    dev.log(
      "Same Day: ${dateOnly(dateValues.lastUpdate) == dateOnly(DateTime.now())}",
    );

    newDay = await loading(
      qualifiedModels,
      activeTasks,
      statModel,
      dateValues,
      newDay,
      progressionRules,
      db,
    );

    final dateModd = await db.getDateValues();
    dateValues = dateModd.first;
    final statModd = await db.getStatModels();
    statModel = statModd.first;
    models = await db.getModels();
    activeTasks = await db.getActiveTasks();
    return newDay;
  }

  void addHistory(HistoryModel nhistory) {
    history.add(nhistory);
    notifyListeners();
  }

  void updateStats(StatModel stat) {
    statModel = stat;
    notifyListeners();
  }

  void updateDate(DateValues date) {
    dateValues = date;
    notifyListeners();
  }

  Future<(int, int)> checktask(ActiveTask task) async {
    task.isCompleted = true;
    double addedxp = SModelValues.xpAdded(task, statModel);
    statModel = SModelValues.statCalc(statModel, task, dateValues);
    if (!dateValues.isStreak) {
      final newDate = dateValues;
      newDate.isStreak = true;
      updateDate(newDate);
    }
    int level = SModelValues.checkLevel(statModel.xp.toInt());
    //update db and check if lvl task is updated
    HistoryModel newHistory = HistoryModel(
      taskName: task.activeTask,
      xpGained: addedxp,
      dateCompleted: DateTime.now(),
    );
    addHistory(newHistory);
    updateStats(statModel);
    final rows = await db.checkUpdates(
      task,
      statModel,
      dateValues,
      newHistory,
      level,
    );
    notifyListeners();
    return (rows, level);
  }

  Future<(int, int)> checklvltasks(LevelUp task) async {
    task.isActive = false;
    double addedxp = SModelValues.lvlXpAdded(task, statModel);
    statModel = SModelValues.statLvlCalc(statModel, task, dateValues);
    if (!dateValues.isStreak) {
      final newDate = dateValues;
      newDate.isStreak = true;
      updateDate(newDate);
    }
    HistoryModel newHistory = HistoryModel(
      taskName: task.name,
      xpGained: addedxp,
      dateCompleted: DateTime.now(),
    );
    int level = SModelValues.checkLevel(statModel.xp.toInt());
    addHistory(newHistory);
    updateStats(statModel);

    final rows = await db.checkLvlUpdates(
      task,
      statModel,
      dateValues,
      newHistory,
      level,
    );
    notifyListeners();
    return (rows, level);
  }

  void addModel(Model nmodel) async {
    if (nmodel.type == Type.milestone) {
      final newActiveTask = ActiveTask(
        taskId: 0,
        activeTask: nmodel.name,
        taskType: nmodel.type,
        taskCategory: nmodel.category,
        taskDifficulty: nmodel.difficulty,
      );
      db.insertMileActiveTask(newActiveTask);
      activeTasks = await db.getActiveTasks();
    } else if (nmodel.type == Type.levelup) {
      return;
    } else {
      models.add(nmodel);
      db.insertModel(nmodel);
      models = await db.getModels();
    }
    notifyListeners();
  }

  void updateModel(int id) {
    final model = models.firstWhere((a) => a.id == id);
    model.isEnabled = !model.isEnabled;
    db.updateModel(model);
    notifyListeners();
  }

  ({int level, int currentXp, int nextLevelXp}) get levelData =>
      SModelValues.getLevel(statModel.xp.toInt());

  String get levelText => "Lv.${levelData.level}";

  double get xpProgress => levelData.currentXp / levelData.nextLevelXp;

  String get xpText => "${levelData.currentXp}/${levelData.nextLevelXp} XP";

  // Statistics
  double get averageDifficulty => UModelValues.avgDiff(statModel);

  double get successRate => UModelValues.sRate(statModel);

  double get confidenceScore => UModelValues.confidenceScore(statModel);

  double get physical => UModelValues.pConfidence(statModel);

  double get verbal => UModelValues.vConfidence(statModel);

  double get social => UModelValues.sConfidence(statModel);

  double get convo => UModelValues.cConfidence(statModel);

  double get risk => UModelValues.rConfidence(statModel);

  double get gender => UModelValues.gConfidence(statModel);

  double get decision => UModelValues.dConfidence(statModel);
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
