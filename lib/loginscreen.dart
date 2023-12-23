import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  var email = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();


  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // if the user cancle the process
    if(googleUser == null){
      return ;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
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
                  Container(
                    child: Image.asset('assets/login.png'),
                  ),
                  Container(height: 30,),
                  const Text('Login Now!',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  SizedBox(height: 10,),
                  const Text('All Dreams Comes True',style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20,color: Colors.grey),),
                  Container(height: 40,),
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
                      labelText: 'E-mail',
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
                    controller: password,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
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
                        if(formkey.currentState!.validate()){
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                            if(credential.user!.emailVerified){
                              Navigator.of(context).pushReplacementNamed("HomePage");
                            }else{
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Verify Required',
                                desc: 'Please Verify Your Emaill..',
                              ).show();
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                              print('mohamed salah .com');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        }
                      },
                      child: const Text('Login',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
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
