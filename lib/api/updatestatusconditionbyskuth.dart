import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<bool> updatestatusconditionbyskuth(
    String skuth, String tostatus, String tocondition) async {
  bool resultcallback = false;
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-an.a.run.app/api/updatestatus?skuth_list=$skuth&status_list=$tostatus&condition_list=$tocondition',
  ));
  if (resp.statusCode == 200) {
    resultcallback = true;
  }
  return resultcallback;
}
