import 'package:fbase/components/my_button.dart';
import 'package:fbase/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 213, 204, 213),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    height: 100,
                    alignment: Alignment.center,
                  ),
                ],
              ),
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 109, 70, 109)),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                hintText: 'Username',
                hide: false,
                controller: usernameController,
              ),
              MyTextField(
                hintText: 'Password',
                hide: true,
                controller: passwordController,
              ),
              const SizedBox(
                height: 25,
              ),
              PurpleButton(text: 'Login', onPressed: () {}),
              const Padding(
                padding: EdgeInsets.only(right: 26, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Dont have an accout? ',
                      style: TextStyle(fontSize: 11),
                    ),
                    InkWell(
                        child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.blue, fontSize: 11),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                child: Image.asset(
                  'lib/images/google.png',
                  height: 30,
                ),
              )
            ],
          )),
    );
  }
}
