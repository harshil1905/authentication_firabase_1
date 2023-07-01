import 'package:authentication_firabase/ui%201/round_button.dart';
import 'package:authentication_firabase/ui%201/utils.dart';
import 'package:authentication_firabase/ui%201/verify_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final phoneNumbercontroller = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextField(
              controller: phoneNumbercontroller,
              decoration: const InputDecoration(hintText: '+91 99133 99028'),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                  phoneNumber: phoneNumbercontroller.text,
                  verificationCompleted: (_) {},
                  verificationFailed: (e) {
                    Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VerifyScreen(verificationId: verificationId)),
                    );
                    setState(() {
                      loading = true;
                    });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = true;
                    });
                  },
                );
              },
              title: 'Login',
            )
          ],
        ),
      ),
    );
  }
}
