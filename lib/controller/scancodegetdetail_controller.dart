import 'package:unisoundpos/api/getimgurlfromshopifybysku.dart';
import 'package:unisoundpos/api/getitemdetailfromshopifybysku.dart';
import 'package:unisoundpos/api/getjpskufromthsku.dart';
import 'package:unisoundpos/model/itemdetail_model.dart';

Future<ItemdetailModel> scancodegetdetailController(String scansku) async {
  ItemdetailModel reItem = ItemdetailModel.newModel();
  String getimgurl = await getimgurlfromshopifybysku(scansku);
  Map getitemdetail = await getitemdetailfromshopifybysku(scansku);
  String getskujp = await getjpskufromthsku(scansku);
  reItem = ItemdetailModel(
    imgurl: getimgurl,
    itemdetail: getitemdetail['itemdetail'],
    itemmname: getitemdetail['itemname'],
    price: int.parse(getitemdetail['price']
        .toString()
        .split('.')[0]
        .replaceAll(',', "")
        .replaceAll('฿', "")),
    serialnum: getitemdetail['serialnumber'],
    skujp: getskujp,
    skuth: getitemdetail['sku'],
  );
  return reItem;
}
