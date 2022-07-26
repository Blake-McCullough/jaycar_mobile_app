import 'dart:convert';

import 'package:http/http.dart' as http;

final _client = http.Client();

Future<Map<String, dynamic>> getCategoriesQuery(
    String searchQuery, String pageNumber) async {
  //Gets the json for the users info
  String urlsearch =
      'http://192.168.20.14/cat?key=magickey&search=$searchQuery&page=$pageNumber';

  print(urlsearch);

  final response = await _client.get(
    Uri.parse(urlsearch),
  );
  print(response);

  var data = jsonDecode(response.body);
  print(data);
  return data;
}
