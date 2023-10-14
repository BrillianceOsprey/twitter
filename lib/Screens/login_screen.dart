// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:twitter/Constants/Constants.dart';
import 'package:twitter/Services/auth_service.dart';
import 'package:twitter/Widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTweeterColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Log in',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Your email',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter Your password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            RoundedButton(
              btnText: 'LOG IN',
              onBtnPressed: () async {
                bool isValid = await AuthService.login(_email, _password);
                if (isValid) {
                  Navigator.pop(context);
                } else {
                  print('login problem');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
