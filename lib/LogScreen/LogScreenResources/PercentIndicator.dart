import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class showPercentIndicator extends StatelessWidget {
  double percentage;
  String indicatorName;

  showPercentIndicator(
      {required this.percentage,
        required this.indicatorName,
      });

  Color getColor() {
    if (percentage > 75) {
      return Colors.green;
    } else if (percentage >= 40) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = getColor();

    return Column(
      children: [
        Row(
          children: [
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 50,
              lineWidth: 10,
              percent: percentage / 100.0,
              progressColor: color,
              backgroundColor: Color.fromRGBO(200, 200, 200, 1.0),
              circularStrokeCap: CircularStrokeCap.round,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${percentage.toInt()}%", style: TextStyle(fontSize: 25)),
                  Text("$indicatorName", style: TextStyle(fontSize: 12)),
                ],

              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // LinearPercentIndicator(
                  //   animation: true,
                  //   animationDuration: 1000,
                  //   lineHeight: 10,
                  //   percent: percentage / 100.0,
                  //   progressColor: color,
                  //   backgroundColor: Color.fromRGBO(200, 200, 200, 1.0),
                  //   linearStrokeCap: LinearStrokeCap.roundAll,
                  //   center: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text("${percentage.toInt()}%", style: TextStyle(fontSize: 25)),
                  //       Text("$indicatorName", style: TextStyle(fontSize: 12)),
                  //     ],
                  //
                  //   ),
                  // ),

                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}