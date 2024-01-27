import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var username = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String inputText = "example@gmail.com";

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // if the user cancle the process
    if(googleUser == null){
      return ;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil('HomePage' , (route)=> false );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const Text(
                    'Lets Register',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'SignUp To More !',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  Container(
                    height: 40,
                  ),
                  TextFormField(
                    validator: (e){
                      if(e == ''){
                        return "Must Not Be Empty";
                      }
                    },
                    controller: username,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'UserName',
                      hintText: 'UserName',
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (e){
                      if(e == ''){
                        return "Must Not Be Empty";
                      }
                    },
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'E-mail',
                      hintText: 'Type Your Email',
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (e){
                      if(e == ''){
                        return "Must Not Be Empty";
                      }
                    },
                    obscureText: true,
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Type Your password',
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    color: Colors.black,
                    child: MaterialButton(
                      onPressed: ()async {
                        if(formkey.currentState!.validate()) {
                          if (inputText.contains('@gmail')) {
                            print('Input text contains "@gmail".');
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();
                              Navigator.of(context).pushReplacementNamed(
                                  "LoginScreen");
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'weak-password',
                                  desc: 'The password provided is too weak.',
                                ).show();
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: 'Already exists',
                                  desc: 'Email-already-in-use',
                                ).show();
                              }
                              else {
                                print('Input text does not contain "@gmail".');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Input text does not contain "@gmail".',
                                ).show();
                              }
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Simple Dialog'),
                                  content: Text('This is a simple dialog in Flutter.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            size: 50,
                          )),
                      Container(
                        width: 32,
                      ),
                      IconButton(
                          onPressed: () {
                            signInWithGoogle();
                          },
                          icon: Icon(
                            FontAwesomeIcons.google,
                            size: 50,
                          )),
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('LoginScreen');
                    },
                    child: const Text('Have an Account!  LOGIN'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


