String encryptskuthtobarcode(String skuth, String storename) {
  String storecode = "";
  String sourcecode = "";
  String lotcode = "";
  String skucode = "";
  //// Define Store
  switch (storename.toUpperCase()) {
    case "UNITCAMERA":
      storecode = "01";
      break;
    case "UNISOUND":
      storecode = "02";
      break;
  }
  //// Define Source
  switch (skuth.split("-")[0].toUpperCase()) {
    case "UN":
      sourcecode = "01";
      break;
    case "LH":
      sourcecode = "02";
      break;
  }
  //// Define Lot
  lotcode = skuth.split("-")[1].toUpperCase().padLeft(3, "0");
  //// Define SKU
  skucode = skuth.split("-")[2].toUpperCase();
  return "$storecode$sourcecode$lotcode$skucode";
}
