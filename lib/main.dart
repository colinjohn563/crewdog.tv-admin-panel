// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewdogadmin/firebase_options.dart';
import 'package:crewdogadmin/screens/alljobs.dart';
import 'package:crewdogadmin/screens/allusers.dart';
import 'package:crewdogadmin/screens/dashboard.dart';
import 'package:crewdogadmin/screens/loginscreen.dart';
import 'package:crewdogadmin/screens/splash.dart';
import 'package:crewdogadmin/theme_pallete.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CrewDog TV Admin',
      theme: ThemeData(
        primaryColor: Palette.cToDark,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.cToDark)
            .copyWith(background: const Color(0xfffafafa)),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const Dashboard(),
        '/jobs': (context) => const Jobs(),
        '/allusers': (context) => const AllUsersScreen(),
      },
    );
  }
}
