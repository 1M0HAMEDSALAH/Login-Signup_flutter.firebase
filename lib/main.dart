import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/loginscreen.dart';
import 'package:untitled/registerscreen.dart';


void main()async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home:FirebaseAuth.instance.currentUser == null ? loginscreen() : HomePage(),
      routes: {
        'RegisterScreen': (context) => const RegisterScreen(),
        'LoginScreen': (context) => const loginscreen(),
        'HomePage': (context) => const HomePage(),
      },
    );
  }
}
