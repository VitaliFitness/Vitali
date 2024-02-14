
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitali/Login_Singup_Screens/signup_screen.dart';
import 'login_screen.dart';


class SignupDetail extends StatefulWidget {
  final String email;

  SignupDetail({required this.email});

  @override
  State<SignupDetail> createState() => _SignupDetailState();
}

class _SignupDetailState extends State<SignupDetail> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  late DateTime selectedDate = DateTime.now();
  late String imagePath;

  Future<void> save(String signupEmail) async {
    final firestore = FirebaseFirestore.instance.collection('Users');

    String fname = firstNameController.text;
    String lname = lastNameController.text;
    String email = signupEmail;
    String gender = genderController.text;
    String dob = dobController.text;
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);

    firestore.doc(email).set({
      'First Name' : fname,
      'Last Name' : lname,
      'Email Address' : email,
      'Date of Birth': dob,
      'Gender' : gender,
      'Weight' : weight,
      'Height' : height,

    }).then((value){
      print('Successfully Registered');
    }).onError((error, stackTrace){
      print('Registering User Details Failed');
      print((error, stackTrace));
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

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

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [

                const Text(
                  "Let’s complete your profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [

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
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          save(widget.email);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0C2D57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(330, 57
                          ),

                        ),

                        child: const Text(
                          "Finish",
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
