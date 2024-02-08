import 'package:flutter/material.dart';
import 'package:vitali/screen/signup_screen.dart';
import 'package:vitali/screen/signupprofiledetail_screen.dart';



class FitnessLevelScreen extends StatefulWidget {
  const FitnessLevelScreen({super.key});

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
 int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF284494), size: 25,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Select your fitness level",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF284494), // Assuming TColor.secondaryText represents grey color
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 35,),
            FitnessLevelSelector(
              title: "Beginner",
              subtitle: "You are new to fitness training",
              isSelect: selectIndex == 0,
              onPressed: () {
                setState(() {
                  selectIndex = 0;
                });
              },
            ),

            FitnessLevelSelector(
              title: "Intermediate",
              subtitle: "You have been training regularly",
              isSelect: selectIndex == 1,
              onPressed: () {
                setState(() {
                  selectIndex = 1;
                });
              },
            ),

            FitnessLevelSelector(
              title: "Advanced",
              subtitle: "You're fit and ready for an intensive workout plan",
              isSelect: selectIndex == 2,
              onPressed: () {
                setState(() {
                  selectIndex = 2;
                });
              },
            ),
           const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C2D57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(330, 57),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupDetail()),
                  );
                },
                child: const Text("Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class FitnessLevelSelector extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final bool isSelect;

  const FitnessLevelSelector({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isSelect,
    required this.onPressed,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: media.width * 0.05,
                bottom: media.width * 0.05,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: isSelect ? Colors.blue : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  if (isSelect)
                    Image.asset(
                      "images/tick.png",
                      width: 20,
                      height: 20,
                    )
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey, height: 1),
          SizedBox(height: media.width * 0.05),
        ],
      ),
    );
  }
}

