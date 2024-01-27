import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/EditKid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<QueryDocumentSnapshot> data = [];

  bool _isloading = true ;

  _getData()async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance
        .collection("Kids")
        .where('UserAccess' ,isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    _isloading = false;
    setState(() {
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("AddKid");
        },
        child: const Icon(Icons.add),
      ),
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
      body: _isloading ?
              const Center(
                child: CircularProgressIndicator(),
              )
           :  ListView.builder(
        scrollDirection: Axis.vertical,
        //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 300),
        itemBuilder: (context , index){
          return InkWell(
            onTap: (){
               AwesomeDialog(
                context: context,
                desc: 'Choose The Operation.',
                btnCancelText: 'Delete',
                btnCancelIcon: FontAwesomeIcons.remove,
                btnCancelOnPress: ()async {
                  await FirebaseFirestore.instance.collection("Kids").doc(data[index].id).delete();
                  Navigator.of(context).pushReplacementNamed('HomePage');
                },
                btnOkText: 'Edit',
                btnOkIcon: FontAwesomeIcons.edit,
                btnOkOnPress: () async{
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder:
                      (context) =>
                          EditKid(
                              doc_id: data[index].id,
                            Old_fname: data[index]['first name'],
                              Old_lname: data[index]['last name'],
                              Old_email: data[index]['email'],
                              Old_Id: data[index]['ID'],
                          )
                  )
                  );
                },
              ).show();
            },
            child: Card(
              child: Column(
                children: [
                  Text(data[index]['last name']),
                  Text("${data[index]['first name']}"),
                ],
              ),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}