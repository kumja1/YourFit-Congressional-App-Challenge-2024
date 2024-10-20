import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  var name;

  var intensity;
  
  var duration;

  ExerciseCard({
    this.name,
    this.intensity,
    this.duration,
  });
  @override
  State<StatefulWidget> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    throw UnimplementedError();
  }
}
