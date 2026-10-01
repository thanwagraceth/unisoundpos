import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<bool> listingshopeelazadabysku(String skuth) async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-listing-1013364429662.asia-southeast3.run.app/newlistingunisoundbythai?sku=$skuth',
  ));
  if (resp.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
