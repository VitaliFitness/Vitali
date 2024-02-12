import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  final String userEmail;

  ProfileView({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map<String, dynamic> userData = {};
  late SharedPreferences prefs;
  late String email;

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString('Email') ?? '';
    fetchData(email);
  }

  Future<void> fetchData(String email) async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(email).get();

    if (userSnapshot.exists) {
      setState(() {
        userData = userSnapshot.data() ?? {};
      });
    } else {
      print('User data not found for email: $email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF0C2D57),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFF0C2D57),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile picture and edit button
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "images/Firefly fitness app logo 73872.jpg",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userData['First Name']} ${userData['Last Name']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: const Color(0xFF0C2D57),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Do something on button press
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // Display user details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFF93A1C9),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${userData['Height']}',
                              style: const TextStyle(
                                color: Color(0xFF01AAEC),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Height",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8), // Add spacing between containers
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFF93A1C9),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${userData['Weight']}',
                              style: const TextStyle(
                                color: Color(0xFF01AAEC),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Weight",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Add spacing between containers
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFF93A1C9),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${userData['Date of Birth']}',
                              style: const TextStyle(
                                color: Color(0xFF01AAEC),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "DOB",
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

              const SizedBox(
                height: 25,
              ),
              // Personal details cards
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF93A1C9),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Personal Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildPersonalDetailCard(
                      icon: Icons.person,
                      title: "Gender:",
                      detail: "${userData['Gender']}",
                    ),
                    _buildPersonalDetailCard(
                      icon: Icons.mail,
                      title: "Contact:",
                      detail: "${userData['Email Address']}",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // Other options cards
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF93A1C9),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Other",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Contact us card
                    _buildOtherOptionsCard(
                      icon: Icons.phone,
                      title: "Contact Us",
                    ),
                    // Privacy policy card
                    _buildOtherOptionsCard(
                      icon: Icons.policy,
                      title: "Privacy Policy",
                    ),
                    // Settings card
                    _buildOtherOptionsCard(
                      icon: Icons.settings,
                      title: "Settings",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  // Implement your logout logic here
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
      ),
    );
  }

  Widget _buildPersonalDetailCard(
      {required IconData icon, required String title, required String detail}) {
    return Card(
      elevation: 2,
      color: const Color(0xFFEAEDF5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF01AAEC),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherOptionsCard(
      {required IconData icon, required String title}) {
    return Card(
      elevation: 2,
      color: const Color(0xFFEAEDF5),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF01AAEC),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.navigate_next,
          color: Color(0xFF01AAEC),
        ),
      ),
    );
  }
}
