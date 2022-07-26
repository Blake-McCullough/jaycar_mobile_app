import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final _client = http.Client();

Future<Map<String, dynamic>> getProductInfo(String productCode) async {
  //Gets the json for the users info
  String urlsearch = 'http://192.168.20.14/page?key=magickey&code=$productCode';

  print(urlsearch);

  final response = await _client.get(
    Uri.parse(urlsearch),
  );
  print(response);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  print("Product Code");
  print(productCode);

  var data = jsonDecode(response.body);
  bool existed = true;
  data['Favourites'] = existed ? "True" : "False";

  print(data);
  return data;
}
