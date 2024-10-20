import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExercisesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
      ),
    );
  }
}
