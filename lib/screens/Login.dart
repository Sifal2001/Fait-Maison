import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/screens/Home.dart';
import 'package:login/utilities/getLunchMenuFromDB.dart';
import 'package:login/utilities/getUsername.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/screens/Register.dart';
import '../utilities/getBreakfastMenuFromDB.dart';
import '../utilities/getBreakfastPrefFromDB.dart';
import '../utilities/getDinnerMenuFromDB.dart';
import '../utilities/getDinnerPreFromDB.dart';
import '../utilities/getItemsForBlackList.dart';
import '../utilities/getLunchPreFromDB.dart';

String? uid;

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  final _formKey = GlobalKey<FormState>();

  //editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.redAccent,fixedSize: const Size(128, 40), alignment: Alignment.center,);
    return Scaffold(
        body: ListView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(10.0,00.0,10.0,00.0),
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: GradientText(
                  'FaitMaison',
                  style:const TextStyle(
                    fontSize: 48.0,
                  ),
                  colors: const[
                    Colors.red,
                    Colors.deepOrangeAccent
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(00.0,24.0,00.0,00.0),
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Enter your details to login',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )
              ),
              Container(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent
                margin: const EdgeInsets.fromLTRB(64.0,10.0,64.0,00.0),
                padding: const EdgeInsets.fromLTRB(20.0,80.0,20.0,80.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(232, 133, 22, 0.6),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey ,
                        blurRadius: 3.0,
                        offset: Offset(1.0,1.0)
                    )
                  ],
                  gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange,
                        Colors.deepOrangeAccent
                      ]
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child:Column(
                      children: <Widget>[
                        const Text(
                          'Username',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 640,
                          child:
                          TextFormField(
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors. white),
                            controller: emailController,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                              ),
                              hintText: 'Enter your email',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onSaved: (value){
                              emailController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(height: 56),
                        const Text(
                          'Password',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 640,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors. white),
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                              ),
                              hintText: 'Enter your Password',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onSaved: (value){
                              passwordController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          style: style,
                          onPressed: () async{
                            getBreakfastMenuFromDB();
                            getVeggies();
                            getFruits();
                            signIn(emailController.text,passwordController.text);
                          },
                          child: Text('Login'),
                        ),
                      ]
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(64.0,10.0,44.0,10.0),
                  padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,20.0),
                  alignment: Alignment.bottomRight,
                  child:
                  Row(
                      children: <Widget>[
                        const Spacer(),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            child: const Text('Register'),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyRegisterPage(title: "Register page")),
                              );
                            },
                          ),
                        ),
                      ]
                  )
              )
            ]// This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }
  void signIn(String email, String password) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      getUid();
      await getBreakfastMenuFromDB();
      await getBreakfastPreFromDB();
      await getLunchMenuFromDB();
      await getLunchPreFromDB();
      await getDinnerMenuFromDB();
      await getDinnerPreFromDB();
      await getUserName();

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home")),
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? 'Login failed');
    }
  }

  getUid() async {
    final User? user = _auth.currentUser;
    uid = user?.uid;
  }
}