import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'fitnessdetail_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}
Future<void> update() async {

}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  late DateTime selectedDate = DateTime.now();
  late String imagePath;

  @override
  void initState(){
    super.initState();
    imagePath = '';
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
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedfile != null){
      setState(() {
        imagePath = pickedfile.path;
      });
    }
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
              MaterialPageRoute(builder: (context) => const FitnessLevelScreen()),
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
                      GestureDetector(
                        onTap: pickImage,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: const Color(0xFFEAF3FF),
                          backgroundImage:
                          imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
                          child: imagePath.isEmpty ? const Icon(Icons.add_a_photo, size:25,):null,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),

                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
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
                                          return Container(
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
                      const SizedBox(
                        height: 20,
                      ),

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
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: weightController,
                              decoration: InputDecoration(
                                hintText: "Your Weight",
                                prefixIcon: const Icon(
                                  Icons.fitness_center,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
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
                                  color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: heightController,
                              decoration: InputDecoration(
                                hintText: "Your Height",
                                prefixIcon: const Icon(
                                  Icons.height,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
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
                                  color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: update,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0C2D57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(330, 57
                          ),

                        ),

                        child: const Text(
                          "Save",
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
