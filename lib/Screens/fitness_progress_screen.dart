import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitali/Screens/user_profile_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FitnessProgress extends StatefulWidget {
  final String userEmail;

  const FitnessProgress({super.key, required this.userEmail});

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
    email = 'test@gmail.com';
    fetchData(email);
  }

  Future<void> fetchData(String email) async {
    final CollectionReference userDataCollection = FirebaseFirestore.instance
        .collection('User Data')
        .doc(email)
        .collection('Dates');

    try {
      QuerySnapshot querySnapshot = await userDataCollection.get();
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic>? userData =
        document.data() as Map<String, dynamic>?;

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

      setState(() {
        userData = {
          'Calories': totalCalories,
          'Protein': totalProtein,
          'Carbs': totalCarbs,
          'Fat': totalFat,
        };
      });
    } catch (e) {
      ('Error fetching data: $e');
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
      return userRecords.first;
    }

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
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFDAF0FF),
                Color(0xFFEAEDF5),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hi! See Your Progress Records!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.scoreboard_rounded,
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 250,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF01AAEC),),
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2BEEFB),
                              Color(0xFF0040FF),
                              Color(0xFF0C2D57),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Total Calories",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${userData['Calories']}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 250,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF90FFF8)),
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFB1FEFA),
                              Color(0xFF00C3B8),
                              Color(0xFF00726B),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Total Protein",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${userData['Protein']}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 250,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF90FFF8)),
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFB1FEFA),
                              Color(0xFF00C3B8),
                              Color(0xFF00726B),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Total Carbs",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${userData['Carbs']}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 250,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF90FFF8)),
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2BEEFB),
                              Color(0xFF0040FF),
                              Color(0xFF0C2D57),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Total Fat",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${userData['Fat']}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
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
      ),
    );
  }
}

