import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitali/Screens/user_profile_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


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
            updateLocalData(userData);
          });
        }
      });

      // Update userData map here
      setState(() {
        userData = {
          'Calories': totalCalories,
          'Protein': totalProtein,
          'Carbs': totalCarbs,
          'Fat': totalFat,
        };
      });

    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  Future<void> updateLocalData(Map<String, dynamic> userData) async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'user_data.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user_data(calories INTEGER, protein INTEGER, carbs INTEGER, fat INTEGER)",
        );
      },
      version: 1,
    );

    await db.insert(
      'user_data',
      {
        'calories': userData['Calories'] ?? 0,
        'protein': userData['Protein'] ?? 0,
        'carbs': userData['Carbs'] ?? 0,
        'fat': userData['Fat'] ?? 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>> getLocalData() async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'user_data.db'),
    );

    final List<Map<String, dynamic>> userRecords = await db.query('user_data');

    if (userRecords.isNotEmpty) {
      // Assuming there's only one record in the database
      return userRecords.first;
    }

    // If no records found, return default values
    return {
      'calories': 0,
      'protein': 0,
      'carbs': 0,
      'fat': 0,
    };
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Progress Records'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total Calories: ${userData['Calories']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Protein: ${userData['Protein']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Carbs: ${userData['Carbs']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Fat: ${userData['Fat']}',
              style: TextStyle(fontSize: 18),
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
                "View Profile",
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
