import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
              onPressed: ()async {
                GoogleSignIn googlesignin = GoogleSignIn();
                googlesignin.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("LoginScreen");
              }, icon: const Icon(Icons.logout))
        ],
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome To Our Application'),
          SizedBox(height: 200,),
          FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.add),
          ),
          Slider(
              value: 100,
              min: 0,
              max: 200,
              onChanged: (value){
                print(value);
              },)
        ],
      ),
    );
  }
}