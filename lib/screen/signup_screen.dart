import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vitali/screen/signupprofiledetail_screen.dart';
import 'package:vitali/screen/welcome_screen.dart';

import '../firebase_auth_services.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isCheck = false;
  bool _obscureText = true;

  Future<void> authenticateSignup(BuildContext context) async{
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(context, email, password);
    print(user);
    if (user != null) {

      print('success');
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SignupDetail(email: email)));
    } else{
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sign Up',
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
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/logovitali.png',
                    width: 270.0,
                    height: 270.0,

                ),
                const Text(
                  "Hey there,",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const Text(
                  "Create an Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    labelText: ' Email',
                    labelStyle: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFF284494)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFF284494)),
                    ),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                 TextFormField(
                   controller: passwordController,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                     labelText: 'Password',
                     labelStyle: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
                     enabledBorder: const OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Color(0xFF284494)),
                      ),
                       focusedBorder: const OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                       borderSide: BorderSide(color: Color(0xFF284494)),
                     ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black54,
                        ),
                        onPressed:(){
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Password is required';
                       }
                       return null;
                     },
                 ),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                        isCheck
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        "By continuing you accept our Privacy Policy and\nTerm of Use",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                  onPressed: (){
                    authenticateSignup(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C2D57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(330, 59
                    ),

                  ),

                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),

                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    const Text(
                      "  Or  ",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                  RichText(
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                );
                              },
                          )
                        ]
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
