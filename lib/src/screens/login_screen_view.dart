import 'package:class_assignment_2/src/firebase/firebase_methods.dart';
import 'package:class_assignment_2/src/screens/create_profile_screen_view.dart';
import 'package:class_assignment_2/src/screens/open_vacancies_screen.dart';
import 'package:class_assignment_2/src/screens/register_screen_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({Key? key}) : super(key: key);
  @override
  State<LoginScreenView> createState() => _LoginScreenView();
}

class _LoginScreenView extends State<LoginScreenView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Login'.toUpperCase(),
              style: TextStyle(
                fontSize: 36,
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  TextFormField(
                      validator: (String? value) {
                        if (value == null || _emailController.text.isEmpty) {
                          return 'Email Required';
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        counterText: ' ',
                        filled: true,
                        fillColor: Color.fromARGB(255, 209, 209, 209),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || _passwordController.text.isEmpty) {
                        return 'Password Required';
                      } else {
                        return null;
                      }
                    },
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      counterText: ' ',
                      filled: true,
                      fillColor: Color.fromARGB(255, 209, 209, 209),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final validForm = _formKey.currentState!.validate();
                        if (validForm) {
                          final _output = await FirebaseMethods().logInUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          if (_output == null) {
                            navigator.push(MaterialPageRoute(
                              builder: (context) =>
                                  const CreateProfileScreenView(),
                            ));
                          }

                          if (_output != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('$_output'),
                              duration: const Duration(
                                milliseconds: 2300,
                              ),
                              backgroundColor: Colors.red.shade500,
                            ));
                          }
                        }
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have account? ',
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreenView(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
