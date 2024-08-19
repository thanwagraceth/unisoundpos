import 'package:http/http.dart';
import 'package:unisoundpos/api/updaterecivestatus.dart';

Future<Response> confirmreceiveController(
    List<String> listskuth, String startlot) async {
  Response result = await updaterecivestatus(listskuth, startlot);
  return result;
}
