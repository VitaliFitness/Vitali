import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class showPercentIndicator extends StatelessWidget {
  double caloriesPercentage;
  double proteinPercentage;
  double carbsPercentage;
  double fatPercentage;
  double currentCalories;
  double currentProtein;
  double currentCarbs;
  double currentFat;

  showPercentIndicator({
    required this.caloriesPercentage,
    required this.proteinPercentage,
    required this.carbsPercentage,
    required this.fatPercentage,
    required this.currentCalories,
    required this.currentProtein,
    required this.currentCarbs,
    required this.currentFat,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 50,
              lineWidth: 5,
              percent: caloriesPercentage,
              progressColor: Color(0xFF01AAEC),
              backgroundColor: Color.fromRGBO(200, 200, 200, 1.0),
              circularStrokeCap: CircularStrokeCap.round,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${currentCalories.toInt()} / 1500", style: TextStyle(fontSize: 12)),
                  Text("Kcal", style: TextStyle(fontSize: 10)),
                ],

              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Protein",
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        "${currentProtein.toInt()} / 100g",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 5,
                    percent: proteinPercentage,
                    progressColor: Color(0xFF01AAEC),
                    backgroundColor: Color.fromRGBO(200, 200, 200, 1.0),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Carbs",
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        "${currentCarbs.toInt()} / 200g",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 5,
                    percent: carbsPercentage,
                    progressColor: Color(0xFF01AAEC),
                    backgroundColor: Color.fromRGBO(200, 200, 200, 1.0),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Fat",
                        style: TextStyle(fontSize: 12),
                      ),Spacer(),
                      Text(
                        "${currentFat.toInt()} / 50g",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 5,
                    percent: fatPercentage,
                    progressColor: Color(0xFF01AAEC),
                    backgroundColor: Color.fromRGBO(200, 200, 200, 1.0),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}