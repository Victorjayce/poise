import 'package:flutter/material.dart';
import 'package:poise/logics/progressionfactory.dart';
import 'package:poise/logics/statlogic.dart';
import 'package:poise/logics/umodel.dart';

enum Type {
  daily('Daily'),
  weekly('Weekly'),
  monthly('Monthly'),
  milestone('Monthly'),
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
  int timesCompleted;
  int timesAssigned;
  bool isEnabled;
  final Category category;

  Model({
    required this.name,
    required this.description,
    required this.difficulty,
    required this.type,
    required this.timesCompleted,
    required this.timesAssigned,
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
  bool newTaskAssigned = false;
  final List<Model> models = [
    Model(
      name: 'Smile at a Stranger',
      description: 'Smile genuinely at someone you pass.',
      difficulty: Difficulty.easy,
      type: Type.daily,
      timesCompleted: 5,
      timesAssigned: 8,
      isEnabled: true,
      category: Category.social,
    ),
    Model(
      name: 'Ask for Directions',
      description: 'Ask someone for directions even if you know them.',
      difficulty: Difficulty.mid,
      type: Type.weekly,
      timesCompleted: 3,
      timesAssigned: 5,
      isEnabled: true,
      category: Category.convo,
    ),
    Model(
      name: 'Start a Conversation',
      description: 'Initiate a 5-minute conversation with someone.',
      difficulty: Difficulty.hard,
      type: Type.monthly,
      timesCompleted: 1,
      timesAssigned: 2,
      isEnabled: true,
      category: Category.convo,
    ),
    Model(
      name: 'Give a Compliment',
      description: 'Give a sincere compliment to someone.',
      difficulty: Difficulty.easy,
      type: Type.daily,
      timesCompleted: 7,
      timesAssigned: 9,
      isEnabled: true,
      category: Category.social,
    ),
    Model(
      name: 'Speak in Public',
      description: 'Speak before a small group for at least 2 minutes.',
      difficulty: Difficulty.extreme,
      type: Type.milestone,
      timesCompleted: 0,
      timesAssigned: 1,
      isEnabled: true,
      category: Category.social,
    ),
  ];

  final List<HistoryModel> history = [
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryModel(
      taskName: 'Asked for Directions',
      xpGained: 52,
      dateCompleted: DateTime.now().subtract(const Duration(days: 1)),
    ),
    HistoryModel(
      taskName: 'Introduced Myself',
      xpGained: 78,
      dateCompleted: DateTime.now().subtract(const Duration(days: 2)),
    ),
    HistoryModel(
      taskName: 'Made Eye Contact',
      xpGained: 15,
      dateCompleted: DateTime.now().subtract(const Duration(days: 3)),
    ),
    HistoryModel(
      taskName: 'Talked to Cashier',
      xpGained: 30,
      dateCompleted: DateTime.now().subtract(const Duration(days: 4)),
    ),
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryModel(
      taskName: 'Asked for Directions',
      xpGained: 52,
      dateCompleted: DateTime.now().subtract(const Duration(days: 1)),
    ),
    HistoryModel(
      taskName: 'Introduced Myself',
      xpGained: 78,
      dateCompleted: DateTime.now().subtract(const Duration(days: 2)),
    ),
    HistoryModel(
      taskName: 'Made Eye Contact',
      xpGained: 15,
      dateCompleted: DateTime.now().subtract(const Duration(days: 3)),
    ),
    HistoryModel(
      taskName: 'Talked to Cashier',
      xpGained: 30,
      dateCompleted: DateTime.now().subtract(const Duration(days: 4)),
    ),
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryModel(
      taskName: 'Asked for Directions',
      xpGained: 52,
      dateCompleted: DateTime.now().subtract(const Duration(days: 1)),
    ),
    HistoryModel(
      taskName: 'Introduced Myself',
      xpGained: 78,
      dateCompleted: DateTime.now().subtract(const Duration(days: 2)),
    ),
    HistoryModel(
      taskName: 'Made Eye Contact',
      xpGained: 15,
      dateCompleted: DateTime.now().subtract(const Duration(days: 3)),
    ),
    HistoryModel(
      taskName: 'Talked to Cashier',
      xpGained: 30,
      dateCompleted: DateTime.now().subtract(const Duration(days: 4)),
    ),
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryModel(
      taskName: 'Asked for Directions',
      xpGained: 52,
      dateCompleted: DateTime.now().subtract(const Duration(days: 1)),
    ),
    HistoryModel(
      taskName: 'Introduced Myself',
      xpGained: 78,
      dateCompleted: DateTime.now().subtract(const Duration(days: 2)),
    ),
    HistoryModel(
      taskName: 'Made Eye Contact',
      xpGained: 15,
      dateCompleted: DateTime.now().subtract(const Duration(days: 3)),
    ),
    HistoryModel(
      taskName: 'Talked to Cashier',
      xpGained: 30,
      dateCompleted: DateTime.now().subtract(const Duration(days: 4)),
    ),
    HistoryModel(
      taskName: 'Smile at a Stranger',
      xpGained: 25,
      dateCompleted: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  final List<ActiveTask> activeTasks = [
    // Daily
    ActiveTask(
      taskId: 1,
      activeTask: 'Smile at 3 strangers',
      taskType: Type.daily,
      taskCategory: Category.social,
      taskDifficulty: Difficulty.easy,
      description: 'Smile naturally at three different people today.',
    ),
    ActiveTask(
      taskId: 2,
      activeTask: 'Maintain eye contact',
      taskType: Type.daily,
      taskCategory: Category.convo,
      taskDifficulty: Difficulty.easy,
      description: 'Hold eye contact for about 3 seconds during conversations.',
    ),
    ActiveTask(
      taskId: 3,
      activeTask: 'Greet classmates',
      taskType: Type.daily,
      taskCategory: Category.verbal,
      taskDifficulty: Difficulty.mid,
      description: 'Say hello first to four classmates.',
    ),

    // Weekly
    ActiveTask(
      taskId: 4,
      activeTask: 'Ask for directions',
      taskType: Type.weekly,
      taskCategory: Category.risk,
      taskDifficulty: Difficulty.mid,
      description: 'Ask two strangers for directions.',
    ),
    ActiveTask(
      taskId: 5,
      activeTask: 'Compliment someone',
      taskType: Type.weekly,
      taskCategory: Category.social,
      taskDifficulty: Difficulty.mid,
      description: 'Give three genuine compliments.',
    ),
    ActiveTask(
      taskId: 6,
      activeTask: 'Start conversations',
      taskType: Type.weekly,
      taskCategory: Category.convo,
      taskDifficulty: Difficulty.hard,
      description: 'Start two conversations lasting over five minutes.',
    ),

    // Monthly
    ActiveTask(
      taskId: 7,
      activeTask: 'Attend a meetup',
      taskType: Type.monthly,
      taskCategory: Category.social,
      taskDifficulty: Difficulty.hard,
      description: 'Attend a social event and interact with people.',
    ),
    ActiveTask(
      taskId: 8,
      activeTask: 'Lead a discussion',
      taskType: Type.monthly,
      taskCategory: Category.verbal,
      taskDifficulty: Difficulty.extreme,
      description: 'Lead a discussion among friends or classmates.',
    ),
    ActiveTask(
      taskId: 9,
      activeTask: 'Network with seniors',
      taskType: Type.monthly,
      taskCategory: Category.decision,
      taskDifficulty: Difficulty.hard,
      description: 'Meet and talk with two senior students.',
    ),

    // Milestones
    ActiveTask(
      taskId: 10,
      activeTask: 'Give a presentation',
      taskType: Type.milestone,
      taskCategory: Category.verbal,
      taskDifficulty: Difficulty.extreme,
      description: 'Deliver a presentation before an audience.',
    ),
    ActiveTask(
      taskId: 11,
      activeTask: 'Organize a group',
      taskType: Type.milestone,
      taskCategory: Category.decision,
      taskDifficulty: Difficulty.hard,
      description: 'Coordinate a small team activity.',
    ),
    ActiveTask(
      taskId: 12,
      activeTask: 'Approach a stranger',
      taskType: Type.milestone,
      taskCategory: Category.risk,
      taskDifficulty: Difficulty.impossible,
      description: 'Approach five strangers and initiate conversations.',
    ),
  ];
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
  final List<LevelUp> levelUp = [
    LevelUp(
      level: 2,
      isActive: true,
      difficulty: Difficulty.easy,
      name: 'Morning Confidence',
      category: Category.physical,
      description: 'Stand tall and maintain confident posture all day.',
    ),
    LevelUp(
      level: 5,
      isActive: true,
      difficulty: Difficulty.mid,
      name: 'Conversation Master',
      category: Category.convo,
      description: 'Keep a conversation going for 10 minutes.',
    ),
    LevelUp(
      level: 10,
      isActive: true,
      difficulty: Difficulty.hard,
      name: 'Fear Breaker',
      category: Category.risk,
      description: 'Approach ten strangers this week.',
    ),
  ];
  final List<ProgressionRule> progressionTasks =
      ProgressionFactory.createRules();
  void load() {
    isLoading = false;
    newTaskAssigned = true;
  }

  void addHistory(HistoryModel nhistory) {
    history.add(nhistory);
    notifyListeners();
  }

  void addModel(Model nmodel) {
    models.add(nmodel);
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

  void updateModel(int id) {
    final model = models.firstWhere((a) => a.id == id);
    model.isEnabled = !model.isEnabled;
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
