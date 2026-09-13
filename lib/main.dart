import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login/screens/login.dart';
import 'package:login/utilities/ingredient_weights.dart';
import 'package:login/utilities/score_candidate.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // load ingredient weights for similarity score calculation
  await loadIngredientWeights();
  print('weights loaded: ${ingredientWeights.length}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(166, 42, 0, 1),//219, 65, 18,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyLoginPage(title: 'FaitMaison'),
    );
  }
}





