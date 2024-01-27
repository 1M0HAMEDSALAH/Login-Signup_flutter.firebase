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
  String inputText = "example@gmail.com";
  bool _islaoding = false ;


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
      body: _islaoding ? const Center(child: CircularProgressIndicator(),)
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Image.asset('assets/login.png'),
                  Container(height: 30,),
                  const Text(
                    'Login Now!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'All Dreams Comes True'
                    ,style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 20,
                      color: Colors.grey,
                  ),
                  ),
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
                    child: TextButton(
                        onPressed: () async {
                          if (inputText.contains('@gmail')) {
                            print('Input text contains "@gmail".');
                            if(email.text == ''){
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                desc: 'Please Email Must Not Be Empty..',
                              ).show();
                              return;
                            }
                            try {
                              await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                desc: 'Please Check Your Email..',
                              ).show();
                            }
                            catch(e){
                              print(e);
                            }
                          }
                          else {
                            print('Input text does not contain "@gmail".');
                          }
                        },
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
                            _islaoding = true;
                            setState(() {
                            });
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                            _islaoding = false;
                            setState(() {
                            });
                            if(credential.user!.emailVerified){
                              Navigator.of(context).pushReplacementNamed("HomePage");
                            }else{
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Verify Required',
                                desc: 'Please Verify Your Email..',
                              ).show();
                            }
                          } on FirebaseAuthException catch (e) {
                            _islaoding = false;
                            setState(() {
                            });
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        }else{
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The Email and Password Must not be Empty',
                          ).show();
                        }
                      },
                      child: const Text('Login',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                     "------OR------",
                     style: TextStyle(fontSize: 20),),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          onPressed: (){
                            signInWithGoogle();
                          },
                          child: const Row(
                            children: [
                              Text("Login With Google"),
                              SizedBox(width: 5,),
                              Icon(FontAwesomeIcons.google),
                            ],
                          ),
                      ),
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