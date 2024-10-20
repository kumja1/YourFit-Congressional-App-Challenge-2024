import '../../enums/index.dart';

class Exercise {
  final ExerciseType type;
  final DateTime dayCompleted;
  final String name;

  Exercise({required this.dayCompleted, required this.type, required this.name});

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
      dayCompleted: DateTime.parse(json["dayCompleted"]),
      type: ExerciseType.from(json["exercise_type"]),
      name: json["name"]);

  Map<String, dynamic> toJson() {
    return {
      "dayCompleted": dayCompleted.toString(),
      "type": type.name,
      "name": name
    };
  }
}
