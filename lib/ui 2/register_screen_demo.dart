// ignore_for_file: use_build_context_synchronously

import 'package:authentication_firabase/ui%202/firabase_fireauth_demo.dart';
import 'package:authentication_firabase/ui%202/verification_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  final registerFormKey = GlobalKey<FormState>();
  final txtnameController = TextEditingController();

  final txtemailController = TextEditingController();
  final txtpasswordController = TextEditingController();

  final focusName = FocusNode();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusName.unfocus();
        focusEmail.unfocus();
        focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent.shade100,
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: txtnameController,
                        focusNode: focusName,
                        onChanged: (value) =>
                            Validator.validateName(name: value.toString()),
                        decoration: InputDecoration(
                          hintText: "Name",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: txtemailController,
                        onChanged: (value) =>
                            Validator.validateEmail(email: value.toString()),
                        decoration: InputDecoration(
                          hintText: "Email",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: txtpasswordController,
                        focusNode: focusPassword,
                        obscureText: true,
                        onChanged: (value) => Validator.validatePassword(
                            password: value.toString()),
                        decoration: InputDecoration(
                          hintText: "Password",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      isProcessing
                          ? const CircularProgressIndicator()
                          : Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    color: Colors.deepOrangeAccent.shade100,
                                    onPressed: () async {
                                      setState(() {
                                        isProcessing = true;
                                      });
                                      if (registerFormKey.currentState!
                                          .validate()) {
                                        User? user = await FireAuth
                                            .registerUsingEmailPassword(
                                          name: txtnameController.text,
                                          email: txtemailController.text,
                                          password: txtpasswordController.text,
                                        );
                                        setState(() {
                                          isProcessing = false;
                                        });
                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationUi(user: user),
                                            ),
                                            ModalRoute.withName('/'),
                                          );
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//   TextEditingController txtnamecontroller = TextEditingController();

//   TextEditingController txtemailcontroller = TextEditingController();
//   TextEditingController txtpasswordcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//       ),
//       body: SafeArea(
//           child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Login',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepOrangeAccent.shade100,
//                   fontSize: 30),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Form(
//               key: GlobalKey(),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: txtnamecontroller,
//                     decoration: const InputDecoration(
//                       hintText: 'Name',
//                       alignLabelWithHint: true,
//                     ),
//                   ),
//                   TextField(
//                     controller: txtemailcontroller,
//                     decoration: const InputDecoration(
//                       hintText: 'Email',
//                       alignLabelWithHint: true,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: txtpasswordcontroller,
//                     decoration: const InputDecoration(
//                       hintText: 'Password',
//                       alignLabelWithHint: true,
//                     ),
//                     obscureText: true,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             MaterialButton(
//               color: Colors.deepOrangeAccent.shade100,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const VerificationUi(user: User,),
//                   ),
//                 );

//                 setState(() {});
//               },
//               child: const Text('sign up'),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }