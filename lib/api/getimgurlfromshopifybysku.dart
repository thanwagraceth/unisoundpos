import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<String> getimgurlfromshopifybysku(String scansku) async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-eu.a.run.app/getimgurlbyskushopify_$scansku',
  ));
  return resp.body;
}
