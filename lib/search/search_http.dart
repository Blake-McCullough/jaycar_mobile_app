import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final _client = http.Client();

Future<Map<String, dynamic>> getSearchQuery(
    String searchQuery, String pageNumber) async {
  //Gets the json for the users info
  String urlsearch =
      'http://192.168.20.14/search?key=magickey&search=$searchQuery&page=$pageNumber';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  print(urlsearch);

  final response = await _client.get(
    Uri.parse(urlsearch),
  );
  print(response);

  var data = jsonDecode(response.body);
  print(data);
  return data;
}
