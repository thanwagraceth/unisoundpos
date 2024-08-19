import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Map> getitemdetailfromshopifybysku(String scansku) async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-an.a.run.app/getitemdetailfromshopifybysku_$scansku',
  ));
  dynamic jsonResp = jsonDecode(resp.body);
  return jsonResp;
}
