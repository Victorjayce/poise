import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:poise/model/model.dart';

class DbService {
  DbService._constructor();
  static final DbService instance = DbService._constructor();

  Future<Database> initDb() async {
    final dbDirPath = await getDatabasesPath();
    final dbPath = join(dbDirPath, 'poise.db');
    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE active_tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_id INTEGER NOT NULL,
        active_task TEXT NOT NULL,
        task_type TEXT NOT NULL,
        task_category TEXT NOT NULL,
        task_difficulty TEXT NOT NULL,
        description TEXT NOT NULL
        is_completed INTEGER NOT NULL
      )
    ''');

        // HistoryModel
        await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_name TEXT NOT NULL,
        xp_gained REAL NOT NULL,
        date_completed INTEGER NOT NULL
      )
    ''');

        // LevelUp
        await db.execute('''
      CREATE TABLE level_up (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level INTEGER NOT NULL,
        is_active INTEGER NOT NULL,
        difficulty TEXT NOT NULL,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');

        // Model
        await db.execute('''
      CREATE TABLE models (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        type TEXT NOT NULL,
        is_enabled INTEGER NOT NULL DEFAULT 1,
        category TEXT NOT NULL,
        cooldown INTEGER NOT NULL DEFAULT 0
      )
    ''');

        await db.execute('''
  CREATE TABLE stat_model (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    xp REAL NOT NULL DEFAULT 0,
    streak INTEGER NOT NULL DEFAULT 0,
    total_completed INTEGER NOT NULL DEFAULT 0,
    total_assigned INTEGER NOT NULL DEFAULT 0,
    completed_difficulty_score_total REAL NOT NULL DEFAULT 0,
    total_assigned_easy INTEGER NOT NULL DEFAULT 0,
    total_assigned_mid INTEGER NOT NULL DEFAULT 0,
    total_assigned_hard INTEGER NOT NULL DEFAULT 0,
    total_assigned_extreme INTEGER NOT NULL DEFAULT 0,
    total_assigned_impossible INTEGER NOT NULL DEFAULT 0,
    total_assigned_physical INTEGER NOT NULL DEFAULT 0,
    total_assigned_verbal INTEGER NOT NULL DEFAULT 0,
    total_assigned_social INTEGER NOT NULL DEFAULT 0,
    total_assigned_convo INTEGER NOT NULL DEFAULT 0,
    total_assigned_risk INTEGER NOT NULL DEFAULT 0,
    total_assigned_gender INTEGER NOT NULL DEFAULT 0,
    total_assigned_decision INTEGER NOT NULL DEFAULT 0,
    total_completed_physical INTEGER NOT NULL DEFAULT 0,
    total_completed_verbal INTEGER NOT NULL DEFAULT 0,
    total_completed_social INTEGER NOT NULL DEFAULT 0,
    total_completed_convo INTEGER NOT NULL DEFAULT 0,
    total_completed_risk INTEGER NOT NULL DEFAULT 0,
    total_completed_gender INTEGER NOT NULL DEFAULT 0,
    total_completed_decision INTEGER NOT NULL DEFAULT 0,
    completed_difficulty_score_physical REAL NOT NULL DEFAULT 0,
    completed_difficulty_score_verbal REAL NOT NULL DEFAULT 0,
    completed_difficulty_score_social REAL NOT NULL DEFAULT 0,
    completed_difficulty_score_convo REAL NOT NULL DEFAULT 0,
    completed_difficulty_score_risk REAL NOT NULL DEFAULT 0,
    completed_difficulty_score_gender REAL NOT NULL DEFAULT 0,
    completed_difficulty_score_decision REAL NOT NULL DEFAULT 0,
    xp_physical REAL NOT NULL DEFAULT 0,
    xp_verbal REAL NOT NULL DEFAULT 0,
    xp_social REAL NOT NULL DEFAULT 0,
    xp_convo REAL NOT NULL DEFAULT 0,
    xp_risk REAL NOT NULL DEFAULT 0,
    xp_gender REAL NOT NULL DEFAULT 0,
    xp_decision REAL NOT NULL DEFAULT 0
  )
''');

        await db.insert('stat_model', {'id': 1});

        await db.execute('''
  CREATE TABLE date_values (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    last_update TEXT NOT NULL,
    weekly_update TEXT NOT NULL,
    monthly_update TEXT NOT NULL,
    is_streak INTEGER NOT NULL DEFAULT 0,
    app_start_date TEXT
  )
''');

        final now = DateTime.now().toIso8601String();
        await db.insert('date_values', {
          'id': 1,
          'last_update': now,
          'weekly_update': now,
          'monthly_update': now,
          'is_streak': 0,
          'app_start_date': null,
        });
      },
    );
    return db;
  }

  static Database? _db;
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<List<ActiveTask>> getActiveTasks() async {
    final db = await database;
    final maps = await db.query('active_tasks');
    return maps.map((m) {
      final task = ActiveTask(
        taskId: m['task_id'] as int,
        activeTask: m['active_task'] as String,
        taskType: Type.values.byName(m['task_type'] as String),
        taskCategory: Category.values.byName(m['task_category'] as String),
        taskDifficulty: Difficulty.values.byName(
          m['task_difficulty'] as String,
        ),
        description: m['description'] as String,
        isCompleted: (m['is_completed'] as int) == 1,
      );
      task.id = m['id'] as int?;
      return task;
    }).toList();
  }

  void loadingUpdates(
    List<ActiveTask> oldtasks,
    List<ActiveTask> newtasks,
    List<Model> selectedmodels,
    StatModel stat,
    DateValues date,
  ) async {
    final db = await database;
    await db.transaction((tx) async {
      for (final task in oldtasks) {
        await tx.delete(
          'active_tasks',
          where: 'id = ?',
          whereArgs: [task.taskId],
        );
      }
      for (var task in newtasks) {
        await tx.insert('active_task', {
          'active_task': task.activeTask,
          'task_id': task.taskId,
          'task_type': task.taskType.name,
          'task_category': task.taskCategory.name,
          'task_difficulty': task.taskDifficulty.name,
          'description': task.description,
          'is_completed': task.isCompleted ? 1 : 0,
        });
      }
      await tx.update('date_values', {
        'last_update': date.lastUpdate.toIso8601String(),
        'weekly_update': date.weeklyUpdate.toIso8601String(),
        'monthly_update': date.monthlyUpdate.toIso8601String(),
        'is_streak': date.isStreak, // To Do
        'app_start_date': date.appStartDate!.toIso8601String(),
      });
      for (final model in selectedmodels) {
        tx.update(
          'model',
          {'cooldown': 1},
          where: 'id = ?',
          whereArgs: [model.id],
        );
      }
      await tx.update(
        'stat_model',
        {
          'xp': stat.xp,
          'streak': stat.streak,
          'total_completed': stat.totalCompleted,
          'total_assigned': stat.totalAssigned,
          'completed_difficulty_score_total':
              stat.completedDifficultyScoreTotal,
          'total_assigned_easy': stat.totalAssignedEasy,
          'total_assigned_mid': stat.totalAssignedMid,
          'total_assigned_hard': stat.totalAssignedHard,
          'total_assigned_extreme': stat.totalAssignedExtreme,
          'total_assigned_impossible': stat.totalAssignedImpossible,
          'total_assigned_physical': stat.totalAssignedPhysical,
          'total_assigned_verbal': stat.totalAssignedVerbal,
          'total_assigned_social': stat.totalAssignedSocial,
          'total_assigned_convo': stat.totalAssignedConvo,
          'total_assigned_risk': stat.totalAssignedRisk,
          'total_assigned_gender': stat.totalAssignedGender,
          'total_assigned_decision': stat.totalAssignedDecision,
          'total_completed_physical': stat.totalCompletedPhysical,
          'total_completed_verbal': stat.totalCompletedVerbal,
          'total_completed_social': stat.totalCompletedSocial,
          'total_completed_convo': stat.totalCompletedConvo,
          'total_completed_risk': stat.totalCompletedRisk,
          'total_completed_gender': stat.totalCompletedGender,
          'total_completed_decision': stat.totalCompletedDecision,
          'completed_difficulty_score_physical':
              stat.completedDifficultyScorePhysical,
          'completed_difficulty_score_verbal':
              stat.completedDifficultyScoreVerbal,
          'completed_difficulty_score_social':
              stat.completedDifficultyScoreSocial,
          'completed_difficulty_score_convo':
              stat.completedDifficultyScoreConvo,
          'completed_difficulty_score_risk': stat.completedDifficultyScoreRisk,
          'completed_difficulty_score_gender':
              stat.completedDifficultyScoreGender,
          'completed_difficulty_score_decision':
              stat.completedDifficultyScoreDecision,
          'xp_physical': stat.xpPhysical,
          'xp_verbal': stat.xpVerbal,
          'xp_social': stat.xpSocial,
          'xp_convo': stat.xpConvo,
          'xp_risk': stat.xpRisk,
          'xp_gender': stat.xpGender,
          'xp_decision': stat.xpDecision,
        },
        where: 'id = ?',
        whereArgs: [1],
      );
    });
  }

  Future<int> checkUpdates(
    ActiveTask task,
    StatModel stat,
    DateValues date,
    HistoryModel history,
    int level,
  ) async {
    final db = await database;
    int rows = 0;
    db.transaction((tx) async {
      await tx.update(
        'stat_model',
        {
          'xp': stat.xp,
          'streak': stat.streak,
          'total_completed': stat.totalCompleted,
          'total_assigned': stat.totalAssigned,
          'completed_difficulty_score_total':
              stat.completedDifficultyScoreTotal,
          'total_assigned_easy': stat.totalAssignedEasy,
          'total_assigned_mid': stat.totalAssignedMid,
          'total_assigned_hard': stat.totalAssignedHard,
          'total_assigned_extreme': stat.totalAssignedExtreme,
          'total_assigned_impossible': stat.totalAssignedImpossible,
          'total_assigned_physical': stat.totalAssignedPhysical,
          'total_assigned_verbal': stat.totalAssignedVerbal,
          'total_assigned_social': stat.totalAssignedSocial,
          'total_assigned_convo': stat.totalAssignedConvo,
          'total_assigned_risk': stat.totalAssignedRisk,
          'total_assigned_gender': stat.totalAssignedGender,
          'total_assigned_decision': stat.totalAssignedDecision,
          'total_completed_physical': stat.totalCompletedPhysical,
          'total_completed_verbal': stat.totalCompletedVerbal,
          'total_completed_social': stat.totalCompletedSocial,
          'total_completed_convo': stat.totalCompletedConvo,
          'total_completed_risk': stat.totalCompletedRisk,
          'total_completed_gender': stat.totalCompletedGender,
          'total_completed_decision': stat.totalCompletedDecision,
          'completed_difficulty_score_physical':
              stat.completedDifficultyScorePhysical,
          'completed_difficulty_score_verbal':
              stat.completedDifficultyScoreVerbal,
          'completed_difficulty_score_social':
              stat.completedDifficultyScoreSocial,
          'completed_difficulty_score_convo':
              stat.completedDifficultyScoreConvo,
          'completed_difficulty_score_risk': stat.completedDifficultyScoreRisk,
          'completed_difficulty_score_gender':
              stat.completedDifficultyScoreGender,
          'completed_difficulty_score_decision':
              stat.completedDifficultyScoreDecision,
          'xp_physical': stat.xpPhysical,
          'xp_verbal': stat.xpVerbal,
          'xp_social': stat.xpSocial,
          'xp_convo': stat.xpConvo,
          'xp_risk': stat.xpRisk,
          'xp_gender': stat.xpGender,
          'xp_decision': stat.xpDecision,
        },
        where: 'id = ?',
        whereArgs: [1],
      );
      await tx.update(
        'active_task',
        {'is_completed': 1},
        where: 'id = ?',
        whereArgs: [task.id],
      );
      if (date.isStreak) {
        await tx.update(
          'date_values',
          {'is_streak': 1},
          where: 'id = ?',
          whereArgs: [1],
        );
      }
      await tx.insert('history', {
        'task_name': history.taskName,
        'xp_gained': history.xpGained,
        'date_completed': history.dateCompleted.toIso8601String(),
      });
      rows = await tx.update(
        'level_up',
        {'is_active': 1},
        where: 'level = ?',
        whereArgs: [level],
      );
    });
    return rows;
  }

  Future<int> checkLvlUpdates(
    LevelUp task,
    StatModel stat,
    DateValues date,
    HistoryModel history,
    int level,
  ) async {
    final db = await database;
    int rows = 0;
    db.transaction((tx) async {
      await tx.update(
        'stat_model',
        {
          'xp': stat.xp,
          'streak': stat.streak,
          'total_completed': stat.totalCompleted,
          'total_assigned': stat.totalAssigned,
          'completed_difficulty_score_total':
              stat.completedDifficultyScoreTotal,
          'total_assigned_easy': stat.totalAssignedEasy,
          'total_assigned_mid': stat.totalAssignedMid,
          'total_assigned_hard': stat.totalAssignedHard,
          'total_assigned_extreme': stat.totalAssignedExtreme,
          'total_assigned_impossible': stat.totalAssignedImpossible,
          'total_assigned_physical': stat.totalAssignedPhysical,
          'total_assigned_verbal': stat.totalAssignedVerbal,
          'total_assigned_social': stat.totalAssignedSocial,
          'total_assigned_convo': stat.totalAssignedConvo,
          'total_assigned_risk': stat.totalAssignedRisk,
          'total_assigned_gender': stat.totalAssignedGender,
          'total_assigned_decision': stat.totalAssignedDecision,
          'total_completed_physical': stat.totalCompletedPhysical,
          'total_completed_verbal': stat.totalCompletedVerbal,
          'total_completed_social': stat.totalCompletedSocial,
          'total_completed_convo': stat.totalCompletedConvo,
          'total_completed_risk': stat.totalCompletedRisk,
          'total_completed_gender': stat.totalCompletedGender,
          'total_completed_decision': stat.totalCompletedDecision,
          'completed_difficulty_score_physical':
              stat.completedDifficultyScorePhysical,
          'completed_difficulty_score_verbal':
              stat.completedDifficultyScoreVerbal,
          'completed_difficulty_score_social':
              stat.completedDifficultyScoreSocial,
          'completed_difficulty_score_convo':
              stat.completedDifficultyScoreConvo,
          'completed_difficulty_score_risk': stat.completedDifficultyScoreRisk,
          'completed_difficulty_score_gender':
              stat.completedDifficultyScoreGender,
          'completed_difficulty_score_decision':
              stat.completedDifficultyScoreDecision,
          'xp_physical': stat.xpPhysical,
          'xp_verbal': stat.xpVerbal,
          'xp_social': stat.xpSocial,
          'xp_convo': stat.xpConvo,
          'xp_risk': stat.xpRisk,
          'xp_gender': stat.xpGender,
          'xp_decision': stat.xpDecision,
        },
        where: 'id = ?',
        whereArgs: [1],
      );
      await tx.update(
        'level_up',
        {'is_active': 0},
        where: 'level = ?',
        whereArgs: [task.level],
      );
      if (date.isStreak) {
        await tx.update(
          'date_values',
          {'is_streak': 1},
          where: 'id = ?',
          whereArgs: [1],
        );
      }
      await tx.insert('history', {
        'task_name': history.taskName,
        'xp_gained': history.xpGained,
        'date_completed': history.dateCompleted.toIso8601String(),
      });
      rows = await tx.update(
        'level',
        {'is_active': 1},
        where: 'level = ?',
        whereArgs: [level],
      );
    });
    return rows;
  }

  Future<List<HistoryModel>> getHistory() async {
    final db = await database;
    final maps = await db.query('history');
    return maps.map((m) {
      final history = HistoryModel(
        taskName: m['task_name'] as String,
        xpGained: (m['xp_gained'] as num).toDouble(),
        dateCompleted: DateTime.parse(m['date_completed'] as String),
      );
      history.id = m['id'] as int?;
      return history;
    }).toList();
  }

  Future<List<LevelUp>> getLevelUps() async {
    final db = await database;
    final maps = await db.query(
      'level_up',
      where: 'is_active = ?',
      whereArgs: [1],
    );
    return maps
        .map(
          (m) => LevelUp(
            level: m['level'] as int,
            isActive: (m['is_active'] as int) == 1,
            difficulty: Difficulty.values.byName(m['difficulty'] as String),
            name: m['name'] as String,
            category: Category.values.byName(m['category'] as String),
            description: m['description'] as String,
          ),
        )
        .toList();
  }

  Future<List<Model>> getModels() async {
    final db = await database;
    final maps = await db.query('models');
    return maps.map((m) {
      final model = Model(
        name: m['name'] as String,
        description: m['description'] as String,
        difficulty: Difficulty.values.byName(m['difficulty'] as String),
        type: Type.values.byName(m['type'] as String),
        isEnabled: (m['is_enabled'] as int) == 1,
        category: Category.values.byName(m['category'] as String),
      );
      model.id = m['id'] as int?;
      return model;
    }).toList();
  }

  Future<List<Model>> getQualifiedModels() async {
    final db = await database;
    final maps = await db.query(
      'models',
      where: 'cooldown = ?',
      whereArgs: [0],
    );
    return maps.map((m) {
      final model = Model(
        name: m['name'] as String,
        description: m['description'] as String,
        difficulty: Difficulty.values.byName(m['difficulty'] as String),
        type: Type.values.byName(m['type'] as String),
        isEnabled: (m['is_enabled'] as int) == 1,
        category: Category.values.byName(m['category'] as String),
      );
      model.id = m['id'] as int?;
      return model;
    }).toList();
  }

  Future<List<StatModel>> getStatModels() async {
    final db = await database;
    final maps = await db.query('stat_model');
    return maps
        .map(
          (m) => StatModel(
            xp: (m['xp'] as num).toDouble(),
            streak: m['streak'] as int,
            totalCompleted: m['total_completed'] as int,
            totalAssigned: m['total_assigned'] as int,
            completedDifficultyScoreTotal:
                (m['completed_difficulty_score_total'] as num).toDouble(),
            totalAssignedEasy: m['total_assigned_easy'] as int,
            totalAssignedMid: m['total_assigned_mid'] as int,
            totalAssignedHard: m['total_assigned_hard'] as int,
            totalAssignedExtreme: m['total_assigned_extreme'] as int,
            totalAssignedImpossible: m['total_assigned_impossible'] as int,
            totalAssignedPhysical: m['total_assigned_physical'] as int,
            totalAssignedVerbal: m['total_assigned_verbal'] as int,
            totalAssignedSocial: m['total_assigned_social'] as int,
            totalAssignedConvo: m['total_assigned_convo'] as int,
            totalAssignedRisk: m['total_assigned_risk'] as int,
            totalAssignedGender: m['total_assigned_gender'] as int,
            totalAssignedDecision: m['total_assigned_decision'] as int,
            totalCompletedPhysical: m['total_completed_physical'] as int,
            totalCompletedVerbal: m['total_completed_verbal'] as int,
            totalCompletedSocial: m['total_completed_social'] as int,
            totalCompletedConvo: m['total_completed_convo'] as int,
            totalCompletedRisk: m['total_completed_risk'] as int,
            totalCompletedGender: m['total_completed_gender'] as int,
            totalCompletedDecision: m['total_completed_decision'] as int,
            completedDifficultyScorePhysical:
                (m['completed_difficulty_score_physical'] as num).toDouble(),
            completedDifficultyScoreVerbal:
                (m['completed_difficulty_score_verbal'] as num).toDouble(),
            completedDifficultyScoreSocial:
                (m['completed_difficulty_score_social'] as num).toDouble(),
            completedDifficultyScoreConvo:
                (m['completed_difficulty_score_convo'] as num).toDouble(),
            completedDifficultyScoreRisk:
                (m['completed_difficulty_score_risk'] as num).toDouble(),
            completedDifficultyScoreGender:
                (m['completed_difficulty_score_gender'] as num).toDouble(),
            completedDifficultyScoreDecision:
                (m['completed_difficulty_score_decision'] as num).toDouble(),
            xpPhysical: (m['xp_physical'] as num).toDouble(),
            xpVerbal: (m['xp_verbal'] as num).toDouble(),
            xpSocial: (m['xp_social'] as num).toDouble(),
            xpConvo: (m['xp_convo'] as num).toDouble(),
            xpRisk: (m['xp_risk'] as num).toDouble(),
            xpGender: (m['xp_gender'] as num).toDouble(),
            xpDecision: (m['xp_decision'] as num).toDouble(),
          ),
        )
        .toList();
  }

  Future<List<DateValues>> getDateValues() async {
    final db = await database;
    final maps = await db.query('date_values');
    return maps.map((m) {
      final dateValues = DateValues(
        lastUpdate: DateTime.parse(m['date_completed'] as String),
        weeklyUpdate: DateTime.parse(m['date_completed'] as String),
        monthlyUpdate: DateTime.parse(m['date_completed'] as String),
        isStreak: (m['is_streak'] as int) == 1,
      );
      if (m['app_start_date'] != null) {
        dateValues.appStartDate = DateTime.parse(m['date_completed'] as String);
      }
      return dateValues;
    }).toList();
  }

  // ---------------- Inserts ----------------

  Future<int> insertActiveTask(ActiveTask task) async {
    final db = await database;
    return db.insert('active_tasks', {
      'task_id': task.taskId,
      'active_task': task.activeTask,
      'task_type': task.taskType.name,
      'task_category': task.taskCategory.name,
      'task_difficulty': task.taskDifficulty.name,
      'description': task.description,
      'is_completed': task.isCompleted ? 1 : 0,
    });
  }

  Future<int> insertModel(Model model) async {
    final db = await database;
    return db.insert('models', {
      'name': model.name,
      'description': model.description,
      'difficulty': model.difficulty.name,
      'type': model.type.name,
      'is_enabled': model.isEnabled ? 1 : 0,
      'category': model.category.name,
    });
  }

  Future<int> updateModel(Model model) async {
    final db = await database;
    return db.update(
      'models',
      {'is_enabled': 0},
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> updateStatModel(StatModel stat) async {
    final db = await database;
    return db.update(
      'stat_model',
      {
        'xp': stat.xp,
        'streak': stat.streak,
        'total_completed': stat.totalCompleted,
        'total_assigned': stat.totalAssigned,
        'completed_difficulty_score_total': stat.completedDifficultyScoreTotal,
        'total_assigned_easy': stat.totalAssignedEasy,
        'total_assigned_mid': stat.totalAssignedMid,
        'total_assigned_hard': stat.totalAssignedHard,
        'total_assigned_extreme': stat.totalAssignedExtreme,
        'total_assigned_impossible': stat.totalAssignedImpossible,
        'total_assigned_physical': stat.totalAssignedPhysical,
        'total_assigned_verbal': stat.totalAssignedVerbal,
        'total_assigned_social': stat.totalAssignedSocial,
        'total_assigned_convo': stat.totalAssignedConvo,
        'total_assigned_risk': stat.totalAssignedRisk,
        'total_assigned_gender': stat.totalAssignedGender,
        'total_assigned_decision': stat.totalAssignedDecision,
        'total_completed_physical': stat.totalCompletedPhysical,
        'total_completed_verbal': stat.totalCompletedVerbal,
        'total_completed_social': stat.totalCompletedSocial,
        'total_completed_convo': stat.totalCompletedConvo,
        'total_completed_risk': stat.totalCompletedRisk,
        'total_completed_gender': stat.totalCompletedGender,
        'total_completed_decision': stat.totalCompletedDecision,
        'completed_difficulty_score_physical':
            stat.completedDifficultyScorePhysical,
        'completed_difficulty_score_verbal':
            stat.completedDifficultyScoreVerbal,
        'completed_difficulty_score_social':
            stat.completedDifficultyScoreSocial,
        'completed_difficulty_score_convo': stat.completedDifficultyScoreConvo,
        'completed_difficulty_score_risk': stat.completedDifficultyScoreRisk,
        'completed_difficulty_score_gender':
            stat.completedDifficultyScoreGender,
        'completed_difficulty_score_decision':
            stat.completedDifficultyScoreDecision,
        'xp_physical': stat.xpPhysical,
        'xp_verbal': stat.xpVerbal,
        'xp_social': stat.xpSocial,
        'xp_convo': stat.xpConvo,
        'xp_risk': stat.xpRisk,
        'xp_gender': stat.xpGender,
        'xp_decision': stat.xpDecision,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<int> updateDateValues(DateValues dateValues) async {
    final db = await database;
    return db.update(
      'date_values',
      {
        'last_update': dateValues.lastUpdate.toIso8601String(),
        'weekly_update': dateValues.weeklyUpdate.toIso8601String(),
        'monthly_update': dateValues.monthlyUpdate.toIso8601String(),
        'is_streak': dateValues.isStreak ? 1 : 0,
        'app_start_date': dateValues.appStartDate?.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
