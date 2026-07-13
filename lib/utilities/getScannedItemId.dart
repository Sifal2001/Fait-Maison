// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:login/screens/ScanAndLearn.dart';
// import '../Modals/nutrition_information.dart';
// import 'getBreakfastMenuFromDB.dart';
// import 'getBreakfastPrefFromDB.dart';
//
//
// Future<nutritionInfrormation> fetchNIAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://api.spoonacular.com/food/ingredients/search?query=$image_content&number=1&apiKey=$apiKey'));
//
//   if (response.statusCode == 200) {
//     final rep = jsonDecode(response.body);
//     var id = rep['results'][0]['id'];
//     final response_2 = await http
//         .get(Uri.parse('https://api.spoonacular.com/food/ingredients/$id/information?amount=1&apiKey=$apiKey'));
//
//     final rep_2 = jsonDecode(response_2.body);
//     return nutritionInfrormation.fromJson(jsonDecode(response_2.body));
//
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load');
//   }
// }