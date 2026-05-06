import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:unisoundpos/model/paymentdetail_model.dart';

Future<bool> salesreporteucild(PaymentdetailModel setpayment) async {
  bool resultcallback = false;
  String adsprefix = '';
  String changesolddateformat =
      "${setpayment.solddate.split("-")[2]}-${setpayment.solddate.split("-")[1]}-${setpayment.solddate.split("-")[0]}";
  switch (setpayment.channelads) {
    case 'Instagram':
      adsprefix = 'IG';
      break;
    case 'Shopify':
      adsprefix = 'HP';
      break;
    case 'Facebook':
      adsprefix = 'FB';
      break;
    case 'Shopee':
      adsprefix = 'SP';
      break;
    case 'Lazada':
      adsprefix = 'LZ';

      break;
    case 'Google':
      adsprefix = 'GG';

      break;
    default:
      adsprefix = '';
  }
  Response resp = await http.get(Uri.parse(
    'https://uni-sound-euclid-viiamocvka-eu.a.run.app/api/pos/salesreport?solddate=$changesolddateformat&itemname=${setpayment.itemmname}&skuth=${setpayment.skuth}&skujp=${setpayment.skujp}&serial=${setpayment.serialnum}&price=${setpayment.saleprice}&channel=${setpayment.channelsale}&ads=$adsprefix&member=${setpayment.telmember}&sale=${setpayment.thisitemsale}&junk=${setpayment.thisisjunk}&wheelflag=${setpayment.getwheeldiscount}&wheeldiscount=${setpayment.wheeldiscountnumber}&paymentchannel=${setpayment.channelpayment}&fee=${setpayment.feeplatformprice}',
  ));
  if (resp.statusCode == 200) {
    resultcallback = true;
  }
  print(resp.body);

  return resultcallback;
}
