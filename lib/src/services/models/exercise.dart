class Exercise {
  final bool isCompleted;
  final int? timeLeft;
  final String name;

  Exercise({
    required this.timeLeft,
    required this.name,
    required this.isCompleted,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        timeLeft: json["timeLeft"],
        isCompleted: json["isCompleted"] ?? false,
      );

  Map<String, dynamic> toJson() {
    return {"name": name, "timeLeft": timeLeft, "isCompleted": isCompleted};
  }
}
