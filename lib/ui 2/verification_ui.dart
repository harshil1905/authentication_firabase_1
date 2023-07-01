// ignore_for_file: unnecessary_null_comparison
import 'package:authentication_firabase/ui%202/login_screen_demo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationUi extends StatefulWidget {
  final User user;

  const VerificationUi({super.key, required this.user});

  @override
  State<VerificationUi> createState() => _VerificationUiState();
}

class _VerificationUiState extends State<VerificationUi> {
  bool isSendingVerification = false;
  bool isSigningOut = false;
  late User currentUser;

  @override
  void initState() {
    currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar(
      backgroundColor: Colors.deepOrangeAccent.shade100,
      title: const Text('profilre'),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${currentUser.displayName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            Text(
              'EMAIL: ${currentUser.email}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20.0),
            // currentUser.emailVerified
            //     ? const Text(
            //         'Email verified',
            //         style: TextStyle(color: Colors.green),
            //       )
            //     : const Text(
            //         'Email not verified',
            //         style: TextStyle(color: Colors.red),
            //       ),
            // MaterialButton(
            //   color: Colors.deepOrangeAccent.shade100,
            //   onPressed: () async {
            //     await currentUser.sendEmailVerification();

            //     setState(() {});
            //   },
            //   child: const Text('verify email'),
            // ),
            // IconButton(
            //   icon: const Icon(Icons.refresh),
            //   onPressed: () async {
            //     Future<User?> user = FireAuth.refreshUser(currentUser);
            //     // refreshUser(currentUser);
            //     if (user != null) {
            //       setState(() {
            //         currentUser = user as User;
            //       });
            //     }
            //   },
            // ),
            MaterialButton(
                color: Colors.deepOrange.shade100,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginUi1(),
                    ),
                  );
                },
                child: const Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
