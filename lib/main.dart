import 'dart:developer' as devtools show log;

import 'package:GID/core/ui_color_constant.dart';
import 'package:GID/firebase_options.dart';
import 'package:GID/ui/screens/auth/starting_screen.dart';
import 'package:GID/ui/screens/auth/verify_email_screen.dart';
import 'package:GID/ui/screens/home/home_nav_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito',
        appBarTheme: AppBarTheme(
          backgroundColor: getBackgroundColor(),
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: getBackgroundColor(),
      ),
      home: const PreScreen(),
    );
  }
}

class PreScreen extends StatelessWidget {
  const PreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              FirebaseAuth.instance.currentUser?.reload();
              final user = FirebaseAuth.instance.currentUser;
              devtools.log('PreScreen user status-- ${user.toString()}');

              if (user != null) {
                if (user.emailVerified) {
                  devtools.log('Email is done');
                  return const HomeNavbarScreen();
                } else {
                  devtools.log(FirebaseAuth.instance.currentUser.toString());
                  devtools.log('Email is not yet verified');
                  return const VerifyEmailScreen();
                }
              } else {
                return const StartingScreen();
              }

            default:
              return const CircularProgressIndicator();

            // case ConnectionState.none:
            // [add]No network screen
          }
        });
  }
}
