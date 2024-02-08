import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vitali/screen/signup_screen.dart';
import 'package:vitali/screen/welcome_screen.dart';

import '../firebase_auth_services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool _obscureText = true;

  Future<void> login() async{
    if(formKey.currentState?.validate() ?? false){
      String email = usernameController.text;
      String password = passwordController.text;

        //Authenticate user entered email and password
        final FirebaseAuthService _auth = FirebaseAuthService();
        User? userFromFirebase = await _auth.signInWithEmailAndPassword(email, password);

        //If user authentication is valid, get the user details
        if (userFromFirebase != null) {
          print("User is successfully signedIn");



        } else {
          print("Some error happend");
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
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
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(4),

          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/vitali.png',
                    width: 300.0,
                    height: 300.0,
                    fit: BoxFit.cover
                ),

                Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                 width: 360,
                 height: 90,
                 child : TextFormField(
                   controller: usernameController,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    labelText: ' Username',
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
                ),

                Container(
                  width: 360,
                  height: 90,
                 child : TextFormField(
                    obscureText: _obscureText,
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
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Password is required';
                      }
                      return null;
                    }
                ),
                ),

                const SizedBox(
                  height: 16,
                ),

                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C2D57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(330, 57
                    ),

                  ),

                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),

                  ),
                ),
                const SizedBox(
                  height: 15,
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
                  text: "Don't have an account?",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign-Up',
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
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
