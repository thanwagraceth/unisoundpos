import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<String> createchecksheet() async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-an.a.run.app/api/createcheckstockroute',
  ));
  return resp.body;
}
