import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';


List<List<dynamic>> data = [];

loadAsset() async {
  var myData = await rootBundle.loadString("assets/csvFiles/similarRecipes.csv");
  List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
  data = csvTable;
  print(data[1]);
}