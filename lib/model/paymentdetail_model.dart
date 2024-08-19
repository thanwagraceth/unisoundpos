class PaymentdetailModel {
  String solddate;
  String itemmname;
  String skuth;
  String skujp;
  String serialnum;
  int saleprice;
  String channelsale;
  String channelads;
  String telmember;
  bool thisitemsale;

  PaymentdetailModel({
    required this.solddate,
    required this.itemmname,
    required this.skujp,
    required this.skuth,
    required this.serialnum,
    required this.saleprice,
    required this.channelsale,
    required this.channelads,
    required this.telmember,
    required this.thisitemsale,
  });

  factory PaymentdetailModel.newModel() {
    return PaymentdetailModel(
      solddate: '',
      itemmname: '',
      skujp: '',
      skuth: '',
      serialnum: '',
      saleprice: 0,
      channelsale: '',
      channelads: '',
      telmember: '',
      thisitemsale: false,
    );
  }

  bool get checkElement {
    bool result = true;
    if (channelsale == '') {
      result = false;
    }
    if (itemmname == '') {
      result = false;
    }
    if (saleprice == 0) {
      result = false;
    }
    if (serialnum == '') {
      result = false;
    }
    if (skujp == '') {
      result = false;
    }
    if (skuth == '') {
      result = false;
    }
    if (solddate == '') {
      result = false;
    }

    return result;
  }
}
