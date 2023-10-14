// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:twitter/Constants/Constants.dart';
import 'package:twitter/Services/auth_service.dart';
import 'package:twitter/Widgets/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  String _email = '';
  String _password = '';
  String _name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTweeterColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Registration',
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
                hintText: 'Name',
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
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
                hintText: 'Password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            RoundedButton(
              btnText: 'Create account',
              onBtnPressed: () async {
                bool isValid =
                    await AuthService.signUp(_name, _email, _password);
                if (isValid) {
                  Navigator.pop(context);
                } else {
                  print('something wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
