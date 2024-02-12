import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitali/Screens/user_profile_screen.dart';

class FitnessProgress extends StatefulWidget {
  final String userEmail;

  FitnessProgress({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<FitnessProgress> createState() => _FitnessProgressState();
}

class _FitnessProgressState extends State<FitnessProgress> {
  Map<String, dynamic> userData = {};

  double totalCalories = 0;
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFat = 0;
  late String email;


  @override
  void initState() {
    super.initState();
    // Manually specify the email
    email = 'test@gmail.com';
    fetchData(email);
  }


  Future<void> fetchData(String email) async {
    final CollectionReference userDataCollection =
    FirebaseFirestore.instance.collection('User Data').doc(email).collection('Dates');

    try {
      QuerySnapshot querySnapshot = await userDataCollection.get();
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic>? userData = document.data() as Map<String, dynamic>?;

        if (userData != null) {
          setState(() {
            totalCalories += (userData['Calories'] ?? 0).toDouble();
            totalProtein += (userData['Protein'] ?? 0).toDouble();
            totalCarbs += (userData['Carbs'] ?? 0).toDouble();
            totalFat += (userData['Fat'] ?? 0).toDouble();
          });
        }
      });
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Calories: $totalCalories',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              'Total Protein: $totalProtein',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              'Total Carbs: $totalCarbs',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              'Total Fat: $totalFat',
              style: const TextStyle(fontSize: 20.0),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileView(userEmail: ''),
                  ),
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
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
