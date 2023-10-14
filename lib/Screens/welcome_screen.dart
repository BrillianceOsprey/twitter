import 'package:flutter/material.dart';
import 'package:twitter/Screens/login_screen.dart';
import 'package:twitter/Screens/registration_screen.dart';
import 'package:twitter/Widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    height: 200,
                    width: 200,
                  ),
                  const Text(
                    'See what’s happening in the world right now',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  RoundedButton(
                      btnText: 'LOG IN',
                      onBtnPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                      btnText: 'Create account',
                      onBtnPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationScreen()));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
