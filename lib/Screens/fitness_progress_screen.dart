import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:vitali/Screens/user_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Progress',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FitnessProgressScreen(),
    );
  }
}

class FitnessProgressScreen extends StatefulWidget {
  final double goalCompleted = 0.7;

  const FitnessProgressScreen({Key? key}) : super(key: key);

  @override
  _FitnessProgressScreenState createState() => _FitnessProgressScreenState();
}

class _FitnessProgressScreenState extends State<FitnessProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _radialProgressAnimationController;
  late Animation<double> _progressAnimation;
  final Duration fadeInDuration = const Duration(milliseconds: 500);
  final Duration fillDuration = const Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Progress",
          style: TextStyle(
            color: Color(0xFF0C2D57),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 220.0,
                  height: 220.0,
                  child: CustomPaint(
                    painter: RadialPainter(progressDegrees),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: AnimatedOpacity(
                          opacity: progressDegrees > 30 ? 1.0 : 0.0,
                          duration: fadeInDuration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Workout',
                                style: TextStyle(
                                    fontSize: 24.0, letterSpacing: 1.5),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Container(
                                height: 5.0,
                                width: 80.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF93A1C9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                '1.225',
                                style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'CALORIES BURNT',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF01AAEC),
                                    letterSpacing: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF93A1C9),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            SizedBox(width: 8),
                            Text(
                              "Goal:",
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Gaining Weight",
                              style: TextStyle(
                              color: Color(0xFF01AAEC),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            
            const SizedBox(
              height: 15,
            ),
            Row(
                children: [
                  Expanded(
                    child: Container(
              padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF93A1C9),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                            Icons.monitor_weight_rounded,
                            color: Color(0xFF01AAEC),
                          ),
                            SizedBox(width: 8, height: 8,),
                            Text(
                            "49Kg",
                            style: TextStyle(
                              color: Color(0xFF01AAEC),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                            SizedBox(width: 8),
                            Text(
                            "Current Weight",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
              padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF93A1C9),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                            Icons.monitor_weight_rounded,
                            color: Color(0xFF01AAEC),
                          ),
                            SizedBox(width: 8, height: 8,),
                            Text(
                            "53Kg",
                            style: TextStyle(
                              color: Color(0xFF01AAEC),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                            SizedBox(width: 8),
                            Text(
                            "Target Weight",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
                  ),
                  
                ],
              ),
              
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C2D57),
                elevation: 3,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = const LinearGradient(
              colors: [Color(0xFF01AAEC), Color(0xFF0C2D57), Color(0xFF2BEEFB)])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
