import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:vitali/Dashboard/upper_workout_screen.dart';

import 'lower_workout_screen.dart';
import 'meal.dart';
import 'meal_detail_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: height * 0.10,
            left: 0,
            right: 0,
            child: SizedBox(
              height: height * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                      left: 32,
                      right: 16,
                    ),
                    child: Text(
                      "MEALS FOR TODAY",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 35,
                          ),
                          for (int i = 0; i < meals.length; i++)
                            _MealCard(
                              meal: meals[i],
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  OpenContainer(
                    closedElevation: 0,
                    transitionType: ContainerTransitionType.fade,
                    transitionDuration: Duration(milliseconds: 1000),
                    closedColor: Color(0xFFE9E9E9),
                    openBuilder: (context, _) {
                      return UpperWorkoutScreen();
                    },
                    closedBuilder: (context, VoidCallback openContainer) {
                      return GestureDetector(
                        onTap: openContainer,
                        child: Container(
                          margin: EdgeInsets.only(top: 0, bottom: 20, left: 32, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF20008B),
                                Color(0xFF200087),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 16),
                                child: Text(
                                  "YOUR NEXT WORKOUT",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Upper Body",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          child: Image.asset(
                                            "assets/chest.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/back.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/biceps.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/back.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  OpenContainer(
                    closedElevation: 0,
                    transitionType: ContainerTransitionType.fade,
                    transitionDuration: Duration(milliseconds: 1000),
                    closedColor: Color(0xFFE9E9E9),
                    openBuilder: (context, _) {
                      return LowerWorkoutScreen();
                    },
                    closedBuilder: (context, VoidCallback openContainer) {
                      return GestureDetector(
                        onTap: openContainer,
                        child: Container(
                          margin: EdgeInsets.only(top: 0, bottom: 20, left: 32, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF20008B),
                                Color(0xFF200087),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 16),
                                child: Text(
                                  "YOUR NEXT WORKOUT",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Lower Body",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          child: Image.asset(
                                            "assets/back.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/jump_rope.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/biceps.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Color(0xFF5B4D9D),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/back.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 20,
      ),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: OpenContainer(
                closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                transitionDuration: const Duration(milliseconds: 1000),
                openBuilder: (context, _) {
                  return MealDetailScreen(
                    meal: meal,
                  );
                },
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: openContainer,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        meal.imagePath,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      meal.mealTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${meal.kiloCaloriesBurnt} kcal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.access_time,
                          size: 15,
                          color: Colors.black12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${meal.timeTaken} min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

