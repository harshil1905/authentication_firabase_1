import 'package:authentication_firabase/ui%201/post_screen.dart';
import 'package:authentication_firabase/ui%201/round_button.dart';
import 'package:authentication_firabase/ui%201/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  const VerifyScreen({super.key, required this.verificationId});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final verifyCodeController = TextEditingController();
  final pinController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: verifyCodeController,
              decoration: const InputDecoration(hintText: '6 digit code'),
            ),
            const SizedBox(
              height: 80,
            ),
            Pinput(
              controller: pinController,
              cursor: RoundButton(
                title: 'verify',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verifyCodeController.text.toString(),
                  );
                  // ignore: empty_catches
                  try {
                    await auth.signInWithCredential(credential);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = true;
                    });
                    Utils().toastMessage(e.toString());
                  }
                },
              ),
            ),

            // PinCodeFields(
            //   length: 4,
            //   fieldBorderStyle: FieldBorderStyle.square,
            //   responsive: false,
            //   fieldHeight: 40.0,
            //   fieldWidth: 40.0,
            //   borderWidth: 1.0,
            //   activeBorderColor: Colors.pink,
            //   activeBackgroundColor: Colors.pink.shade100,
            //   borderRadius: BorderRadius.circular(10.0),
            //   keyboardType: TextInputType.number,
            //   autoHideKeyboard: false,
            //   fieldBackgroundColor: Colors.black12,
            //   borderColor: Colors.black38,
            //   textStyle: const TextStyle(
            //     fontSize: 30.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   onComplete: (output) {
            //     // Your logic with pin code
            //     // ignore: avoid_print
            //     print(output);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
