import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("LoginScreen");
              }, icon: const Icon(Icons.logout))
        ],
      ),
      body:  Column(
        children: [
          FirebaseAuth.instance.currentUser!.emailVerified
              ? Text('Welcome To Our Application')
              : MaterialButton(onPressed: (){
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
                print("aaaaaaaaaaaaaaaaaaaaaaaaaa");
                },
            child: Text('press here to verify'),),
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