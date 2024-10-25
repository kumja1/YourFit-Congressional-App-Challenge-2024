import 'dart:convert';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourfit/src/services/functions/fitness_service.dart';
import 'package:yourfit/src/widgets/sized_decorated_box.dart';
import '../../utils/constants.dart'; // Import groq package

@RoutePage()
class ExercisesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExercisesScreen> {
  final FitnessLLMService _fitnessService = getIt<FitnessLLMService>();

  late Map<String, dynamic>? _text = {};

  Future<void> testAI() async {
    var result = await _fitnessService.invoke(
      {
        "age": 99,
        "weight": 400,
        "height": "7ft 7",
        "optionalParameters": "",
        "input": "Give a 1 day exercise plan for the user"
      },
      onError: _handleErr,
    );

    if (result == null) return;
    setState(() => _text = (jsonDecode(result
        .substring(
          result.indexOf("```json"),
        )
        .replaceAll("```json", "")
        .replaceAll("```", "")))[0]);
        
    print(_text);
  }

  @override
  void initState() {
    testAI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
      ),
      body: SingleChildScrollView(
          child: SizedBox.expand(child: _text != null ? _buildListView() : const Text("No Data"))),
    );
  }

  _buildListView() {
      if (_text == null || _text!["exercises"] == null) {
    return const Center(child: Text("No exercises found.")); 
  }
  var exercisesList = _text!["exercises"];
    return ListView.builder(
    itemCount: exercisesList.length,
    padding: EdgeInsets.all(20),
    itemBuilder: (_, i) {
      return NiceButtons(
        onTap: () => null,
        height: 40,
        width: 300,
        stretch: false,
        borderRadius: 10,
        startColor: Colors.blue,
        endColor: Colors.blue,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                exercisesList[i]["name"],
                style: const TextStyle(color: Colors.black),
              ),
                  )
                ],
              ));
        });
  }

  _handleErr(Exception err) {
    print(err);
  }
}
