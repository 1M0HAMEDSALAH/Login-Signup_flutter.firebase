import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
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
                // TextFormField(
                //   controller: phone,
                //   keyboardType: TextInputType.phone,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'Phone Number',
                //     hintText: 'Phone Number',
                //     //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                //   ),
                // ),
                Container(
                  height: 10,
                ),
                TextFormField(
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
                // TextFormField(
                //   obscureText: true,
                //   keyboardType: TextInputType.visiblePassword,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'Confirm Password',
                //     hintText: 'Type Your password',
                //     //border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                //   ),
                // ),
                Container(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 150,
                  color: Colors.black,
                  child: MaterialButton(
                    onPressed: ()async {
                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        Navigator.of(context).pushReplacementNamed("HomePage");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
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
                        onPressed: () {},
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
    );
  }
}
