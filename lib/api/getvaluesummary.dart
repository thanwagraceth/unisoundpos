import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:unisoundpos/model/paymentdetail_model.dart';

Future<bool> getvaluechecksheet(PaymentdetailModel paymentset) async {
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-an.a.run.app/api/getvaluesummary',
  ));
  // 27/10/2025
  String getdatefromsheet = resp.body.toString();
  // 27/10/2025 or 28/10/2025
  String setformsolddate =
      '${paymentset.solddate.split("-")[2]}/${paymentset.solddate.split("-")[1]}/${paymentset.solddate.split("-")[0]}';
  if (setformsolddate.split("/")[2] == getdatefromsheet.split("/")[2] &&
      setformsolddate.split("/")[1] == getdatefromsheet.split("/")[1] &&
      int.parse(setformsolddate.split("/")[0]) -
              int.parse(getdatefromsheet.split("/")[0]) ==
          1) {
    return true;
  } else {
    return false;
  }
}
