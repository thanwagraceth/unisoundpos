import 'package:unisoundpos/utility/decryptbarcodetoskuth.dart';

String regexpMatchBarcode(String stateinput, String storename) {
  RegExp regExStore;
  List<String> decryptlist = [];
  List<String?> result = [];
  String resultstring = "";
  if (storename == "UNITCAMERA") {
    regExStore = RegExp(
      r"01\d{10,10}",
      caseSensitive: false,
      multiLine: false,
    );
  } else {
    regExStore = RegExp(
      r"02\d{10,10}",
      caseSensitive: false,
      multiLine: false,
    );
  }
  RegExp regExpUN = RegExp(
    r"UN-\d{2,2}-\d{4,4}",
    caseSensitive: false,
    multiLine: false,
  );
  RegExp regExpLH = RegExp(
    r"LH-\d{2,2}-\d{4,4}",
    caseSensitive: false,
    multiLine: false,
  );
  List<String?> matchBarcode =
      regExStore.allMatches(stateinput).map((z) => z.group(0)).toList();
  List<String?> matchUN =
      regExpUN.allMatches(stateinput).map((z) => z.group(0)).toList();
  List<String?> matchLH =
      regExpLH.allMatches(stateinput).map((z) => z.group(0)).toList();
  if (matchBarcode.isNotEmpty) {
    for (String? elementBarcode in matchBarcode) {
      Map<String, String> result = decryptbarcodetoskuth(elementBarcode!);
      if (result['storename'] == storename) {
        decryptlist.add(result['skuth']!);
      }
    }
    result.addAll(matchUN);
    result.addAll(matchLH);
    result.addAll(decryptlist);
    resultstring = result.join(" ");
  } else {
    resultstring = stateinput;
  }
  return resultstring;
}
