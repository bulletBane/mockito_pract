import 'dart:convert';

import 'package:http/http.dart' as http;

Future fetchFromDatabase(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('exception occured!!!!!!');
  }
}
