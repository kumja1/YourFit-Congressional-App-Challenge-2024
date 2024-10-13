import 'dart:core';
import 'package:yourfit/services/models/exercise.dart';

class UserData {
  final String id;

  final String firstName;

  final String lastName;

  final int age;

  final double height;

  final double caloriesBurned;

  final double milesTraveled;

  // final int roadmapData;

  final List<Exercise> exerciseData;
  

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.height,
    required this.caloriesBurned,
    required this.milesTraveled,
   // required this. ,
    required this.exerciseData,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        age: json["age"],
        caloriesBurned: json["calories_burned"],
        height: json["height"],
        milesTraveled: json["miles_traveled"],
       // roadmapIndex: json["roadmap_index"],
        exerciseData: json["exercise_data"]
            .map((exercise) => Exercise.fromJson(exercise)),
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "age": age,
      "calories_burned": caloriesBurned,
      "height": height,
      "miles_traveled": milesTraveled,
     // "roadmap_index": roadmapIndex,
      "exercise_data": exerciseData.map((exercise) => exercise.toJson()),
    };
  }
}
