import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screens/user_profile_screen.dart';


class UpdateProfileScreen extends StatefulWidget {
  final String email;

  const UpdateProfileScreen({super.key, required this.email});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final userDoc = FirebaseFirestore.instance.collection('Users').doc(widget.email);
    final userData = await userDoc.get();

    if (userData.exists) {
      final data = userData.data() as Map<String, dynamic>;
      setState(() {
        firstNameController.text = data['First Name'];
        lastNameController.text = data['Last Name'];
        genderController.text = data['Gender'];
        dobController.text = data['Date of Birth'];
        weightController.text = data['Weight'].toString();
        heightController.text = data['Height'].toString();
      });
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> update() async {
    final userDoc = FirebaseFirestore.instance.collection('Users').doc(widget.email);

    await userDoc.update({
      'First Name': firstNameController.text,
      'Last Name': lastNameController.text,
      'Gender': genderController.text,
      'Date of Birth': dobController.text,
      'Weight': double.parse(weightController.text),
      'Height': double.parse(heightController.text),
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileView(userEmail: ''))
    );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF284494),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF284494), size: 25,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileView(userEmail: '')),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      RichText(
                        text: const TextSpan(
                          text: 'Update Your ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Profile',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(
                              text: ' Here',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50,),

                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: const Icon(
                                  Icons.person,
                                  size: 28,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                  child: TextFormField(
                                    readOnly: true, // To make the field non-editable
                                    controller: genderController,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: const Text('Male'),
                                                  onTap: () {
                                                    setState(() {
                                                      genderController.text = 'Male';
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  title: const Text('Female'),
                                                  onTap: () {
                                                    setState(() {
                                                      genderController.text = 'Female';
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  title: const Text('Other'),
                                                  onTap: () {
                                                    setState(() {
                                                      genderController.text = 'Other';
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Choose Gender',
                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  )
                              )
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: dobController,
                        decoration: InputDecoration(
                          hintText: "Date of Birth",
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: weightController,
                              decoration: InputDecoration(
                                  hintText: "Weight (kg)",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  )
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8,),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blueAccent, Colors.blueAccent],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "KG",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: heightController,
                              decoration: InputDecoration(
                                  hintText: "Height (cm)",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  )
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8,),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blueAccent, Colors.blueAccent],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "CM",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 47,),
                      ElevatedButton(
                        onPressed: update,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0C2D57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(330, 55),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}