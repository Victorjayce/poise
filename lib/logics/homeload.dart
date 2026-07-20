import 'package:poise/model/model.dart';

void loading(
  List<Model> models,
  List<ActiveTask> oldActiveTasks,
  StatModel statModel,
  DateValues date,
  bool newDay,
  List<ProgressionRule> progressionRules,
) {
  List<int?> oldTasks = [];
  ({List<ActiveTask> tasks, List<Model> models}) weeklyResult;
  ({List<ActiveTask> tasks, List<Model> models}) dailyResult;
  ({List<ActiveTask> tasks, List<Model> models}) monthlyResult;

  final weekModels = models.where((a) => a.type == Type.weekly);
  final monthModels = models.where((a) => a.type == Type.monthly);

  List<Model> modelsToUpdate = [];
  List<ActiveTask> newTasks = [];
  int taskCount = 0;

  date.appStartDate ??= DateTime.now();
  final currentDate = DateTime.now();
  if (date.lastUpdate.day < currentDate.day) {
    final dayModels = models.where((a) => a.type == Type.daily);
    int missedDays = currentDate.day - date.lastUpdate.day;
    if (missedDays > 0) statModel.streak = 0;
    date.lastUpdate = DateTime.now();
    newDay = true;
    //getrule
    //generate task dailyResult
    modelsToUpdate.addAll(dailyResult.models);
    taskCount += dailyResult.tasks.length;
    var old = oldActiveTasks.where((a) => a.taskType == Type.daily).toList();
  }
}
