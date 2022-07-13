import 'dart:convert';

import 'package:http/http.dart' as http;

final _client = http.Client();

Future<Map<String, dynamic>> getProductInfo(String productCode) async {
  //Gets the json for the users info
  String urlsearch = 'http://192.168.20.14/page?key=magickey&code=$productCode';

  print(urlsearch);

  final response = await _client.get(
    Uri.parse(urlsearch),
  );
  print(response);

  var data = jsonDecode(response.body);
  print(data);
  return data;
}
