import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<String> getlastskuth() async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-an.a.run.app/api/pos/getlastestskuth',
  ));
  dynamic jsonResp = jsonDecode(resp.body);
  return jsonResp.toString();
}
