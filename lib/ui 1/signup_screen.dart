
import 'package:authentication_firabase/ui%201/login_screen.dart';
import 'package:authentication_firabase/ui%201/round_button.dart';
import 'package:authentication_firabase/ui%201/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _autn = FirebaseAuth.instance;
  bool loading = false;
  @override
  Future<void> dispose() async {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void signup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
    }
    _autn
        .createUserWithEmailAndPassword(
      email: emailcontroller.text.toString(),
      password: passwordcontroller.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError(
      (error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(
          () {
            loading = false;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outlined),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
              title: 'Sign Up',
              loading: loading,
              onTap: () {
                signup();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
