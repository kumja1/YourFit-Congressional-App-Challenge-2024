enum ExerciseType {
  cardio,
  olympicWeightLifting,
  plyometrics,
  powerLifiting,
  stretching,
  strongman;

  factory ExerciseType.from(String type) {
    return switch (type) {
      ("plyometrics") => ExerciseType.plyometrics,
      ("stretching") => ExerciseType.stretching,
      ("strongman") => ExerciseType.strongman,
      ("powerLifting") => ExerciseType.powerLifiting,
      ("olympicWeightLifting") => ExerciseType.olympicWeightLifting,
      ("cardio") => ExerciseType.cardio,
      _ => throw FormatException("Invalid string value")
    };
  }
}
