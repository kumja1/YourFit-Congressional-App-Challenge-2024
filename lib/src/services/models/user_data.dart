import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:yourfit/src/services/models/exercise.dart';

class UserData extends ChangeNotifier {
  final String id;

  final DateTime? createdAt;

  final String firstName;

  final String lastName;

  final int age;

  final int height;

  final double weight;

  final double caloriesBurned;

  final double milesTraveled;

  // final int roadmapData;

  final Map<String, Map<String, dynamic>> exerciseData;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.height,
    required this.weight,
    required this.caloriesBurned,
    required this.milesTraveled,
    this.createdAt,
    required this.exerciseData,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        age: json["age"],
        caloriesBurned: json["calories_burned"].toDouble(),
        height: json["height"],
        weight: json["weight"].toDouble(),
        milesTraveled: json["miles_traveled"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        // roadmapIndex: json["roadmap_index"],
        exerciseData:
            !json["exercise_data"].isEmpty ? json["exercise_data"] : {},
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "age": age,
      "calories_burned": caloriesBurned,
      "height": height,
      "weight": weight,
      "miles_traveled": milesTraveled,
      "created_at": createdAt,
      // "roadmap_index": roadmapIndex,
      "exercise_data": jsonEncode(exerciseData)
    };
  }
}
