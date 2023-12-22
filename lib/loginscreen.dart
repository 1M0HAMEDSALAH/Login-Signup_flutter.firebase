import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  var email = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
                  Container(
                    child: Image.asset('assets/login.png'),
                  ),
                  Container(height: 30,),
                  const Text('Login Now!',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  SizedBox(height: 10,),
                  const Text('All Dreams Comes True',style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20,color: Colors.grey),),
                  Container(height: 40,),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'E-mail',
                      hintText: 'Type Your Email',
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                  Container(height: 10,),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Type Your password',
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(onPressed: (){},
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            color: Colors.black,
                          ),)),
                  ),
                  Container(height: 10,),
                  Container(
                    height: 50,
                    width: 150,
                    color: Colors.black,
                    child: MaterialButton(
                      onPressed: ()async {
                        try {
                           await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                          );
                          Navigator.of(context).pushReplacementNamed("HomePage");
                        }on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'No user found for that email.',
                                      ).show();
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');

                          }
                        }
                      },
                      child: const Text('Login',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont\' have account ?'),
                      MaterialButton(onPressed: (){
                        Navigator.of(context).pushReplacementNamed('RegisterScreen');
                      },
                        child: const Text('Register Now'),
                      ),
                    ],
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
