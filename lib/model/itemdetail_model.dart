class ItemdetailModel {
  String imgurl;
  String itemmname;
  String skuth;
  String skujp;
  String serialnum;
  int price;
  String itemdetail;

  ItemdetailModel({
    required this.imgurl,
    required this.itemdetail,
    required this.itemmname,
    required this.price,
    required this.serialnum,
    required this.skujp,
    required this.skuth,
  });

  factory ItemdetailModel.fromJson(Map<String, dynamic> json) {
    return ItemdetailModel(
      imgurl: json['imgurl'],
      itemdetail: json['itemdetail'],
      itemmname: json['itemmname'],
      price: json['price'],
      serialnum: json['serialnum'],
      skujp: json['skujp'],
      skuth: json['skuth'],
    );
  }

  factory ItemdetailModel.newModel() {
    return ItemdetailModel(
      imgurl: '',
      itemdetail: '',
      itemmname: '',
      price: 0,
      serialnum: '',
      skujp: '',
      skuth: '',
    );
  }

  bool get checkElement {
    bool result = true;

    if (imgurl == '') {
      result = false;
    }
    if (itemdetail == '') {
      result = false;
    }
    if (itemmname == '') {
      result = false;
    }
    if (price == 0) {
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

    return result;
  }

  bool get checkElementForget {
    bool result = true;

    if (imgurl == '') {
      result = false;
    }
    if (itemmname == '') {
      result = false;
    }
    if (skujp == '') {
      result = false;
    }
    if (skuth == '') {
      result = false;
    }

    return result;
  }
}
