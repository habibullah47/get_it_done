import 'package:GID/core/ui_color_constant.dart';
import 'package:GID/core/ui_constants.dart';
import 'package:GID/ui/screens/auth/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.to(const RegistrationScreen());
          },
          icon: const Icon(Icons.cancel_rounded),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gap48,
            const Text(
              'Check your inbox',
              style: TextStyle(
                //fontFamily: 'Metropolis',
                fontSize: 30,
              ),
            ),
            gap16,

            //todo: $email show after 'email' on below text;
            const Text(
              'Please check your email for a \nlink to sign up to GIT ',
              textAlign: TextAlign.center,
            ),
            gap16,
            TextButton(
              onPressed: () {
                //todo: show dialog and return 'Email sent to '$email''
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
              },
              child: const Text(
                'Resend the link to sign in',
                style: TextStyle(
                  color: Color.fromARGB(255, 69, 167, 79),

                  //* Can use a bg picture here like madium.com versionView
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
