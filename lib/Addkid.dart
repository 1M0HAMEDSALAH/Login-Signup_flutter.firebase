import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddKid extends StatefulWidget {
  const AddKid({super.key});

  @override
  State<AddKid> createState() => _AddKidState();
}

class _AddKidState extends State<AddKid> {
  GlobalKey<FormState> formstat = GlobalKey<FormState>();
  TextEditingController fname =  TextEditingController();
  TextEditingController lname =  TextEditingController();
  TextEditingController email =  TextEditingController();
  TextEditingController id    =  TextEditingController();

  CollectionReference Kids = FirebaseFirestore.instance.collection('Kids');

  addKid()async {
    if(formstat.currentState!.validate()){
        try{
          await Kids.add({
            'UserAccess':FirebaseAuth.instance.currentUser!.uid,
            'first name': fname.text,
            'last name': lname.text,
            'email': email.text,
            'ID': id.text,
          });
          Navigator.of(context).pushNamedAndRemoveUntil('HomePage',(route) => false,);
        }catch(error){
          print(error);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Kid'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formstat,
            child: Column(
              children: [
                TextFormField(
                  validator: (e){
                    if(e == ''){
                      return "Must Not Be Empty";
                    }
                  },
                  controller: fname,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'first name',
                    hintText: 'Type Your first name',
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                Container(height: 10,),
                TextFormField(
                  validator: (e){
                    if(e == ''){
                      return "Must Not Be Empty";
                    }
                  },
                  controller: lname,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'last name',
                    hintText: 'Type Your last name',
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                Container(height: 10,),
                TextFormField(
                  validator: (e){
                    if(e == ''){
                      return "Must Not Be Empty";
                    }
                  },
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Type Your Email',
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                Container(height: 10,),
                TextFormField(
                  validator: (e){
                    if(e == ''){
                      return "Must Not Be Empty";
                    }
                  },
                  controller: id,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                    hintText: 'Enter Your Kid ID',
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                const SizedBox(height: 50,),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                  ),
                    onPressed: (){
                      addKid();
                    },
                    child: const Text("ADD Kid",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





