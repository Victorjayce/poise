import 'package:flutter/material.dart';
import 'package:poise/pages/home.dart';
import 'package:poise/model/model.dart';

void main() {
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
