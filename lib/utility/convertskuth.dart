import 'package:unisoundpos/utility/regexpfindbarcodefromscanner.dart';

String convertskuth(String inputsku) {
  String aaa = inputsku;
  List<String> bbblsit = [];
  String bbb = "";
  aaa = aaa.replaceAll(" ", "");
  aaa = regexpMatchBarcode(aaa, "UNISOUND");
  aaa = aaa = aaa.replaceAll("\n", "");
  aaa = aaa.replaceAll(" ", "");
  int countstart = 1;
  for (String ae in aaa.split('')) {
    bbblsit.add(ae);
    if (countstart % 10 == 0) {
      bbblsit.add(' ');
    }
    countstart = countstart + 1;
  }
  bbb = bbblsit.join("");
  return bbb;
}
