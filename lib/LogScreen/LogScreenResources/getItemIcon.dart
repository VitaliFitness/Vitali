import 'package:flutter/material.dart';

List<dynamic> getFoodIcon(String foodType) {
  IconData icon;
  Color color;

  switch (foodType.toLowerCase()) {
    case 'bread and floors':
      icon = Icons.local_dining;
      color = Colors.brown;
      break;
    case 'cereals':
      icon = Icons.grain;
      color = Colors.amber;
      break;
    case 'chicken meat':
      icon = Icons.restaurant;
      color = Colors.deepOrange;
      break;
    case 'fish and seafood':
      icon = Icons.restaurant_menu;
      color = Colors.blue;
      break;
    case 'fruits':
      icon = Icons.local_florist;
      color = Colors.green;
      break;
    case 'grains':
      icon = Icons.grain;
      color = Colors.amber;
      break;
    case 'legumes':
      icon = Icons.nature;
      color = Colors.green;
      break;
    case 'milk':
      icon = Icons.local_drink;
      color = Colors.white;
      break;
    case 'nuts':
      icon = Icons.eco;
      color = Colors.brown;
      break;
    case 'others':
      icon = Icons.fastfood;
      color = Colors.grey;
      break;
    default:
      icon = Icons.fastfood;
      color = Colors.grey;
      break;
  }

  return [icon, color];
}

List<dynamic> getExerciseIcon(String exercise) {
  IconData icon;
  Color color;

  switch (exercise.toLowerCase()) {
    case 'yoga':
      icon = Icons.self_improvement;
      color = Colors.purple;
      break;
    case 'bicycling':
      icon = Icons.directions_bike;
      color = Colors.blue;
      break;
    case 'cricket':
      icon = Icons.sports_cricket;
      color = Colors.orange;
      break;
    case 'dancing':
      icon = Icons.music_note;
      color = Colors.pink;
      break;
    case 'elliptical machine':
      icon = Icons.directions_walk;
      color = Colors.teal;
      break;
    case 'football':
      icon = Icons.sports_soccer;
      color = Colors.green;
      break;
    case 'lifting weights':
      icon = Icons.fitness_center;
      color = Colors.red;
      break;
    case 'running':
      icon = Icons.directions_run;
      color = Colors.grey;
      break;
    case 'swimming':
      icon = Icons.pool;
      color = Colors.blueAccent;
      break;
    default:
      icon = Icons.directions_run;
      color = Colors.grey;
      break;
  }

  return [icon, color];
}