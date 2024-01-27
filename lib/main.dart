import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Addkid.dart';
import 'package:untitled/asdfghjkl;.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/loginscreen.dart';
import 'package:untitled/EditKid.dart';
import 'package:untitled/onboarding.dart';
import 'package:untitled/registerscreen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomePage()
          : loginscreen(),
      routes: {
        'RegisterScreen': (context) => const RegisterScreen(),
        'LoginScreen': (context) => const loginscreen(),
        'HomePage': (context) => const HomePage(),
        'AddKid': (context) => const AddKid(),
      },
    );
  }
}
