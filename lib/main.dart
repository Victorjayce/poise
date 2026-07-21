import 'package:flutter/material.dart';
import 'package:poise/pages/home.dart';
import 'package:poise/model/model.dart';
import 'logics/dbservice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelProvider(
      appModel: appModel,
      child: MaterialApp(
        title: 'Poise Engine',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: HomePage(),
      ),
    );
  }
}
