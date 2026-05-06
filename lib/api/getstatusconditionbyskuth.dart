import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getstatusconditionbyskuth(String skuth) async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-eu.a.run.app/api/getstatus_$skuth',
  ));
  dynamic jsonResp = jsonDecode(resp.body);
  return jsonResp;
}
