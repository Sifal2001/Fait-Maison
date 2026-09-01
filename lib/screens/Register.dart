import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:login/screens/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Modals/user_model.dart';
import '../utilities/getItemsForBlackList.dart';
import 'black_list.dart';


class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key,required this.title});

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();

  final String title;
}
// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

class _MyRegisterPageState extends State<MyRegisterPage>{

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  //Logged in user Id


  //controllers
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      backgroundColor: Colors.redAccent,
      foregroundColor: Colors.white,
      fixedSize: const Size(128, 40),
      alignment: Alignment.center,
    );

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
                    'Enter your details to Register',
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
                  child:
                  Column(
                      children: <Widget>[
                        const Text(
                          'Full name',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 640,
                          child:
                          TextFormField(
                              textAlign: TextAlign.center,
                              controller: nameEditingController,
                              style: const TextStyle(color: Colors. white),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                hintText: 'Enter your Full name',
                              ),
                              validator: (value){
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty){
                                  return ("Please Enter your full name to register");
                                }
                                if (!regex.hasMatch(value)){
                                  return ("Enter Your full name to proceed");
                                }
                                return null;
                              },
                              onSaved: (value){
                                nameEditingController.text = value!;
                              }
                          ),
                        ),
                        const SizedBox(height: 56),
                        const Text(
                          'Email',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 640,
                          child:
                          TextFormField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors. white),
                              controller: emailEditingController,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                hintText: 'Enter your Email',
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{10,}$');
                                if (value!.isEmpty) {
                                  return ("Please Enter your full name to register");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Your full name to proceed");
                                }
                                return null;
                              },
                              onSaved: (value){
                                emailEditingController.text = value!;
                              }
                          ),
                        ),
                        const SizedBox(height: 56),
                        const Text(
                          'Password',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 640,
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors. white),
                              controller: passwordEditingController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                hintText: 'Enter your Password',
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{10,}$');
                                if (value!.isEmpty) {
                                  return ("Please Enter your full name to register");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Your full name to proceed");
                                }
                                return null;
                              },
                              onSaved: (value){
                                passwordEditingController.text = value!;
                              }
                          ),
                        ),
                        const SizedBox(height: 56),
                        ElevatedButton(
                          style: style,
                          onPressed: ()
                          {
                            signUp(emailEditingController.text, passwordEditingController.text);
                            getVeggies();
                            getFruits();
                            UserSiged();
                          },
                          child: const Text('Register'),
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
                            style: style,
                            child: const Text('Login'),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyLoginPage(title: "Login page")),
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
  void signUp(String email, String password) async
  {
    if(_formKey.currentState!.validate()){
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postUsersToDB()})
          .catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
        return <dynamic>{};
      });
    }
  }
  postUsersToDB() async
  {
    //Registering new users in Firestore db
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    uid = user?.uid;

    UserModel userModel = UserModel();

    //writing value to db
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg:"Account created!");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context)=> const BlackList(title:"BlackList")),
            (route) => false);
  }
}

void UserSiged(){
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}




