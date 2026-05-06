import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:unisoundpos/model/countitemcheckstock_model.dart';

Future<CountitemcheckstockModel> updatechecksitllitem(String skuth) async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-eu.a.run.app/api/productstockroute_$skuth',
  ));
  return CountitemcheckstockModel(
    result: resp.body.split("checked").length == 2 ? true : false,
    skuth: skuth,
  );
}
