class LowerBodyWorkout {
  final String imagePath, name, instruction;

  LowerBodyWorkout({required this.imagePath, required this.name, required this.instruction});
}

final lowerBody = [
  [
    LowerBodyWorkout(
      imagePath: "assets/chest.png",
      name: "Squats",
      instruction: "3 sets - 6 repitions",
    ),
    LowerBodyWorkout(
      imagePath: "assets/chest.png",
      name: "Lunges",
      instruction: "4 sets - 6 repitions",
    ),
    LowerBodyWorkout(
      imagePath: "assets/chest.png",
      name: "Deadlifts",
      instruction: "2 sets - 10 repitions",
    ),
  ],
  [
    LowerBodyWorkout(
      imagePath: "assets/back.png",
      name: "Leg Press",
      instruction: "2 sets - 8 repitions",
    ),
    LowerBodyWorkout(
      imagePath: "assets/back.png",
      name: "Calf Raises",
      instruction: "2 sets - 4 repitions",
    ),
    LowerBodyWorkout(
      imagePath: "assets/back.png",
      name: "Romanian Deadlifts",
      instruction: "4 sets - 6 repitions",
    ),
  ],
  [
    LowerBodyWorkout(
      imagePath: "assets/chest.png",
      name: "Glute Bridge",
      instruction: "3 sets - 6 repitions",
    ),
    LowerBodyWorkout(
      imagePath: "assets/chest.png",
      name: "Step-Ups",
      instruction: "4 sets - 6 repitions",
    ),
    LowerBodyWorkout(
      imagePath: "assets/chest.png",
      name: "Wall Sits",
      instruction: "2 sets - 10 repitions",
    ),
    LowerBodyWorkout(
      imagePath: "assets/back.png",
      name: "Hamstring Curls",
      instruction: "2 sets - 8 repitions",
    ),
  ],
];

