import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Response> reprintbaecodebysku(List<String> listskujp) async {
  String removespace = listskujp.toString().replaceAll(' ', '');
  // /api/updatereceivestatus?skujp_list=[014033,003280,013580]&lot_start=UN-22-1647
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-eu.a.run.app/api/createreprintbarcode?skuth_list=$removespace',
  ));
  return resp;
}
