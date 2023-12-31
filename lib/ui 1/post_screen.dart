import 'package:authentication_firabase/ui%201/login_screen.dart';
import 'package:authentication_firabase/ui%201/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    )).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              });
            },
            icon: const Icon(Icons.login_outlined),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
