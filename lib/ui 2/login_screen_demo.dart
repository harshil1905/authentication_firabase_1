// ignore_for_file: use_build_context_synchronously

import 'package:authentication_firabase/ui%202/register_screen_demo.dart';
import 'package:authentication_firabase/ui%202/firabase_fireauth_demo.dart';
import 'package:authentication_firabase/ui%202/verification_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginUi1 extends StatefulWidget {
  const LoginUi1({super.key});

  @override
  State<LoginUi1> createState() => _LoginUi1State();
}

class _LoginUi1State extends State<LoginUi1> {
  final formKey = GlobalKey<FormState>();
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VerificationUi(
            user: user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  TextEditingController txtemailcontroller = TextEditingController();
  TextEditingController txtpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        title: const Text('Firebase Authentication'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent.shade100,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextField(
                      controller: txtemailcontroller,
                      onChanged: (value) =>
                          Validator.validateEmail(email: value),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: txtpasswordcontroller,
                      onChanged: (value) =>
                          Validator.validatePassword(password: value),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        alignLabelWithHint: true,
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: Colors.deepOrangeAccent.shade100,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        User? user = await FireAuth.signInUsingEmailPassword(
                          email: txtemailcontroller.text,
                          password: txtpasswordcontroller.text,
                          context: context,
                        );
                        if (user != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => VerificationUi(
                                user: user,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('sign up'),
                  ),
                  MaterialButton(
                    color: Colors.deepOrangeAccent.shade100,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterUi(),
                        ),
                      );
                      setState(() {});
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
