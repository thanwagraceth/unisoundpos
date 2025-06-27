import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<bool> getflgchecksheet() async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-an.a.run.app/api/getflagsalesummary',
  ));
  dynamic jsonResp = jsonDecode(resp.body);
  if (jsonResp.toString() == "true") {
    return true;
  } else {
    return false;
  }
}
