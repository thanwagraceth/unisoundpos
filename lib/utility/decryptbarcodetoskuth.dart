Map<String, String> decryptbarcodetoskuth(String barcode) {
  String storename = "";
  String sourcetext = "";
  String lottext = "";
  String skutext = "";
  barcode = barcode.replaceAll("\n", "");
  //// Define Store
  switch ("${barcode.split('')[0]}${barcode.split('')[1]}") {
    case "01":
      storename = "UNITCAMERA";
      break;
    case "02":
      storename = "UNISOUND";
      break;
  }
  //// Define Source
  switch ("${barcode.split('')[2]}${barcode.split('')[3]}") {
    case "01":
      sourcetext = "UN";
      break;
    case "02":
      sourcetext = "LH";
      break;
  }
  //// Define Lot
  if (barcode.split('')[4] != "0") {
    lottext =
        "${barcode.split('')[4]}${barcode.split('')[5]}${barcode.split('')[6]}";
  } else {
    lottext = "${barcode.split('')[5]}${barcode.split('')[6]}";
  }
  //// Define SKU
  skutext =
      "${barcode.split('')[7]}${barcode.split('')[8]}${barcode.split('')[9]}${barcode.split('')[10]}";
  return {
    "skuth": "$sourcetext-$lottext-$skutext",
    "storename": storename,
  };
}
