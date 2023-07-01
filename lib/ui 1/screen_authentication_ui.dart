import 'package:authentication_firabase/ui%201/firabase_services.dart';
import 'package:flutter/material.dart';

class AuthenticationUI extends StatefulWidget {
  const AuthenticationUI({super.key});

  @override
  State<AuthenticationUI> createState() => _AuthenticationUIState();
}

class _AuthenticationUIState extends State<AuthenticationUI> {
  @override
  void initState() {
    FirabaseServices authenticationUI = FirabaseServices();
    super.initState();
    authenticationUI.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'AuthenticationUI',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
