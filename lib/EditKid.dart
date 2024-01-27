import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditKid extends StatefulWidget {

  final String doc_id ;
  final String Old_fname ;
  final String Old_lname ;
  final String Old_email ;
  final String Old_Id ;


  const EditKid({super.key,
        required this.doc_id,
        required this.Old_fname,
        required this.Old_email,
        required this.Old_Id,
        required this.Old_lname,
      });

  @override
  State<EditKid> createState() => _AddKidState();
}

class _AddKidState extends State<EditKid> {
  GlobalKey<FormState> formstat = GlobalKey<FormState>();
  TextEditingController fname =  TextEditingController();
  TextEditingController lname =  TextEditingController();
  TextEditingController email =  TextEditingController();
  TextEditingController id    =  TextEditingController();

  CollectionReference Kids = FirebaseFirestore.instance.collection('Kids');

  editKid()async {
    if(formstat.currentState!.validate()){
      try{
        await Kids.doc(widget.doc_id).update({
          'first name': fname.text,
          'last name': lname.text,
          'email':email.text,
          'ID': id.text,
        });
        Navigator.of(context).pushNamedAndRemoveUntil('HomePage',(route) => false,);
      }catch(error){
        print(error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fname.text = widget.Old_fname;
    lname.text = widget.Old_lname;
    email.text = widget.Old_email;
    id.text = widget.Old_Id;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kid'),
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
                    hintText: 'Enter New ID',
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                const SizedBox(height: 50,),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                  ),
                  onPressed: (){
                    editKid();
                  },
                  child: const Text("Edit Kid",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




