import 'package:GID/core/ui_color_constant.dart';
import 'package:GID/core/ui_constants.dart';
import 'package:GID/firebase_options.dart';
import 'package:GID/ui/screens/auth/login_screen.dart';
import 'package:GID/ui/widgets/app_button.dart';
import 'package:GID/ui/widgets/app_edit_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController _email;
  late final TextEditingController
      _password; //May be use of this type _controller is wrong.

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getBackgroundColor(),
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: padding24,
        child: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a new \nAccount',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const AppEditText(
                      autoCorrect: true,
                      enableSuggestions: true,
                      keyboardType: TextInputType.name,
                      hint: 'Full name',
                    ),
                    AppEditText(
                      controller: _email,
                      autoCorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      hint: 'Email',
                    ),
                    AppEditText(
                      controller: _password,
                      autoCorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.visiblePassword,
                      hint: 'Password',
                      isObscure: true,
                    ),
                    AppButton(
                        onTap: () async {
                          final email = _email.text;
                          final password = _password.text;
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          print(userCredential);
                        },
                        title: 'Register Now'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Get.to(const LoginScreen());
                          },
                          child: const Text(
                            ' Sign in',
                            style: TextStyle(
                                color: Color.fromARGB(255, 69, 167, 79)),
                          ),
                        ),
                      ],
                    ),
                    divider,
                    const Center(
                      child: Text(
                        'Or Sign up with',
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: AppButton(onTap: () {}, title: 'facebook'),
                        ),
                        gap10,
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            whiteButtton: true,
                            onTap: () {},
                            title: 'Google',
                          ),
                        )
                      ],
                    ),
                  ],
                );
              default:
                return const Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}
