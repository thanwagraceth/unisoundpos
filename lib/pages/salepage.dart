import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unisoundpos/api/getflagsummary.dart';
import 'package:unisoundpos/api/getvaluesummary.dart';
import 'package:unisoundpos/controller/confirmpayment_controller.dart';
import 'package:unisoundpos/controller/scancodegetdetail_controller.dart';
import 'package:unisoundpos/model/itemdetail_model.dart';
import 'package:unisoundpos/model/paymentdetail_model.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/utility/decryptbarcodetoskuth.dart';
import 'package:unisoundpos/utility/senddatatousb.dart';
import 'package:unisoundpos/widget/drawermenucustom.dart';
import 'package:unisoundpos/widget/loading_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unisoundpos/widget/salepagewidget/showdialogcheck.dart';
import 'package:unisoundpos/widget/salepagewidget/showdialogconfirmpayment.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  late ItemdetailModel getitem;
  late PaymentdetailModel setpayment;
  late bool loadingitemdetail;
  late bool loadingsummary;
  NumberFormat fcomma = NumberFormat("###,###,###");

  /// FOR DROP
  List<String> channelSaleList = <String>[
    'Walk-in Customer',
    'Shopee Customer',
    'Lazada Customer',
    'Shopify Customer',
    'Instagram Customer',
    'Facebook Customer',
    'Line Customer',
    'TikTok Customer',
    'Contractor',
  ];
  List<String> channelAdvList = <String>[
    'Not specified',
    'Instagram',
    'Facebook',
    'Shopify',
    'Shopee',
    'Lazada',
    'Google',
    'TikTok',
  ];
  List<String> channelPayment = <String>[
    'Cash',
    'Credit card',
    'Bank tranfers',
    'Shopify',
    'Shopee',
    'Lazada',
    'TikTok',
  ];

  /// VARIABLE INPUT
  String? channelSaleListValue;
  String? channelAdvListValue;
  String? channelPaymentValue;
  late String solddateController;
  TextEditingController scancodecontroller = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController platformfeepriceController = TextEditingController();
  TextEditingController telmemberController = TextEditingController();
  TextEditingController wheeldiscountController = TextEditingController();
  bool thisitemonsale = false;
  bool thisisjunk = false;
  bool getwheeldiscount = false;
  bool customermember = false;

  @override
  void initState() {
    loadingitemdetail = false;
    loadingsummary = false;
    getitem = ItemdetailModel.newModel();
    setpayment = PaymentdetailModel.newModel();
    solddateController = "Sold Date";
    wheeldiscountController.text = '';
    super.initState();
  }

  clearInputPaymentPart() {
    channelSaleListValue = null;
    channelAdvListValue = null;
    channelPaymentValue = null;
    solddateController = "Sold Date";
    priceController.text = '';
    platformfeepriceController.text = '';
    telmemberController.text = '';
    thisitemonsale = false;
    customermember = false;
    getwheeldiscount = false;
    wheeldiscountController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenuCustom(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: UniSoundColor.wh),
        backgroundColor: UniSoundColor.black,
        title: Text(
          "UNISOUND BANGKOK : SALE",
          style: GoogleFonts.robotoCondensed(
            color: UniSoundColor.wh,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 1000,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: 30,
                  right: 30,
                ),
                child: loadingitemdetail
                    ? const LoadingWidget()
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.caretRight,
                                    size: 40,
                                    color: UniSoundColor.rePurple,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "ITEM DETAIL",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 30,
                                left: 20,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      "SCANCODE :",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: UniSoundColor.rePurple,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 2,
                                        color: UniSoundColor.black,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: 15,
                                      ),
                                      child: TextFormField(
                                        inputFormatters: [
                                          UpperCaseTextFormatter(),
                                        ],
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textAlign: TextAlign.start,
                                        onChanged: (value) {
                                          if (value.split("").length == 12) {
                                            if ("${value.split("")[0]}${value.split("")[1]}" ==
                                                    "01" ||
                                                "${value.split("")[0]}${value.split("")[1]}" ==
                                                    "02") {
                                              Map<String, String>
                                                  resultdecrypt =
                                                  decryptbarcodetoskuth(value);
                                              if (resultdecrypt['storename'] ==
                                                  "UNISOUND") {
                                                scancodecontroller.text =
                                                    resultdecrypt['skuth']!;
                                                setState(() {});
                                              }
                                            }
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "SKU TH",
                                          hintStyle:
                                              GoogleFonts.robotoCondensed(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: scancodecontroller,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (scancodecontroller.text != '') {
                                          setState(() {
                                            loadingitemdetail = true;
                                          });
                                          getitem =
                                              await scancodegetdetailController(
                                                  scancodecontroller.text);
                                          setpayment.itemmname =
                                              getitem.itemmname;
                                          setpayment.skujp = getitem.skujp;
                                          setpayment.skuth = getitem.skuth;
                                          setpayment.serialnum =
                                              getitem.serialnum;
                                          setState(() {
                                            loadingitemdetail = false;
                                          });
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: scancodecontroller.text != ''
                                              ? Colors.blue
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        child: Text(
                                          "GET",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (scancodecontroller.text != '') {
                                          scancodecontroller.text = '';
                                          getitem = ItemdetailModel.newModel();
                                          setpayment =
                                              PaymentdetailModel.newModel();
                                          clearInputPaymentPart();
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: scancodecontroller.text != ''
                                              ? const Color.fromARGB(
                                                  255, 255, 101, 91)
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        child: Text(
                                          "CLEAR",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Container(
                                width: 280,
                                height: 280,
                                decoration: getitem.imgurl == ''
                                    ? BoxDecoration(
                                        color: UniSoundColor.reGray,
                                        borderRadius: BorderRadius.circular(5),
                                      )
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(getitem.imgurl),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                child: getitem.imgurl == ''
                                    ? const Icon(
                                        FontAwesomeIcons.image,
                                        color: Colors.white,
                                        size: 50,
                                      )
                                    : Container(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 5,
                                left: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 15,
                                    child: Text(
                                      "NAME :  ",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Text(
                                      getitem.itemmname,
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 15,
                                    child: Text(
                                      "SKU TH : ",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Text(
                                      getitem.skuth,
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 15,
                                    child: Text(
                                      "SKU JP : ",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Text(
                                      getitem.skujp,
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 28,
                                    child: Text(
                                      "SERIAL NUMBER : ",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 72,
                                    child: Text(
                                      getitem.serialnum,
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 15,
                                    child: Text(
                                      "PRICE : ",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Text(
                                      getitem.price == 0
                                          ? ""
                                          : "${fcomma.format(getitem.price)} THB",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 20,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 15,
                                    child: Text(
                                      "DETAIL : ",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Text(
                                      getitem.itemdetail,
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 1000,
              decoration: BoxDecoration(
                color: getitem.checkElementForget
                    ? UniSoundColor.wh
                    : UniSoundColor.fadeGray,
                border: Border(
                  left: BorderSide(width: 2, color: UniSoundColor.reGray),
                  right: BorderSide(width: 2, color: UniSoundColor.reGray),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.caretRight,
                              size: 40,
                              color: UniSoundColor.rePurple,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "PAYMENT DETAIL",
                                style: GoogleFonts.robotoCondensed(
                                  color: getitem.checkElementForget
                                      ? UniSoundColor.black
                                      : UniSoundColor.reGray,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      !getitem.checkElementForget
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 20),
                                  child: Text(
                                    "Sold Channel",
                                    style: GoogleFonts.robotoCondensed(
                                      color: UniSoundColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: UniSoundColor.wh,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 25,
                                          right: 25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 2,
                                            color: UniSoundColor.black,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: SizedBox(
                                            height: 40.0,
                                            child: DropdownButton<String>(
                                              hint: Text(
                                                "Sold Channel",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              isExpanded: true,
                                              value: channelSaleListValue,
                                              icon: Icon(
                                                Icons.arrow_downward,
                                                color: UniSoundColor.black,
                                              ),
                                              elevation: 16,
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                color: UniSoundColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: UniSoundColor.wh,
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  channelSaleListValue = value!;
                                                  setpayment.channelsale =
                                                      channelSaleListValue!;
                                                });
                                              },
                                              items: channelSaleList.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 20),
                                  child: Text(
                                    "Advertising Channel",
                                    style: GoogleFonts.robotoCondensed(
                                      color: UniSoundColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: UniSoundColor.wh,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 25,
                                          right: 25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 2,
                                            color: UniSoundColor.black,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: SizedBox(
                                            height: 40.0,
                                            child: DropdownButton<String>(
                                              hint: Text(
                                                "Advertising Channel",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              isExpanded: true,
                                              value: channelAdvListValue,
                                              icon: Icon(
                                                Icons.arrow_downward,
                                                color: UniSoundColor.black,
                                              ),
                                              elevation: 16,
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                color: UniSoundColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: UniSoundColor.wh,
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  channelAdvListValue = value!;
                                                  setpayment.channelads =
                                                      channelAdvListValue!;
                                                });
                                              },
                                              items: channelAdvList.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 20),
                                  child: Text(
                                    "Sold Date",
                                    style: GoogleFonts.robotoCondensed(
                                      color: UniSoundColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, left: 25, right: 25),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 2,
                                        color: UniSoundColor.black,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: SizedBox(
                                                width: 600,
                                                height: 800,
                                                child: SfDateRangePicker(
                                                  headerHeight: 100,
                                                  selectionMode:
                                                      DateRangePickerSelectionMode
                                                          .single,
                                                  showNavigationArrow: true,
                                                  backgroundColor:
                                                      UniSoundColor.wh,
                                                  selectionColor:
                                                      UniSoundColor.black,
                                                  showActionButtons: true,
                                                  cancelText: "Cancel",
                                                  confirmText: "Confirm",
                                                  todayHighlightColor:
                                                      UniSoundColor.black,
                                                  headerStyle:
                                                      DateRangePickerHeaderStyle(
                                                    textStyle: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                  ),
                                                  selectionTextStyle:
                                                      GoogleFonts
                                                          .robotoCondensed(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  monthCellStyle:
                                                      DateRangePickerMonthCellStyle(
                                                    todayTextStyle: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                    textStyle: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                    leadingDatesTextStyle:
                                                        GoogleFonts
                                                            .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                    trailingDatesTextStyle:
                                                        GoogleFonts
                                                            .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                    weekendTextStyle:
                                                        GoogleFonts
                                                            .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                  ),
                                                  yearCellStyle:
                                                      DateRangePickerYearCellStyle(
                                                    todayTextStyle: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                    textStyle: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                    leadingDatesTextStyle:
                                                        GoogleFonts
                                                            .robotoCondensed(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                  ),
                                                  monthViewSettings:
                                                      DateRangePickerMonthViewSettings(
                                                    viewHeaderStyle:
                                                        DateRangePickerViewHeaderStyle(
                                                      textStyle: GoogleFonts
                                                          .robotoCondensed(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            UniSoundColor.black,
                                                      ),
                                                    ),
                                                  ),
                                                  onCancel: () {
                                                    Navigator.pop(context);
                                                  },
                                                  onSubmit: (p0) {
                                                    setState(() {
                                                      DateTime soldDatetime =
                                                          DateTime.parse(
                                                              p0.toString());
                                                      solddateController =
                                                          soldDatetime
                                                              .toString()
                                                              .split(" ")[0];
                                                      setpayment.solddate =
                                                          solddateController;
                                                    });

                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: 35.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  solddateController,
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    color: UniSoundColor.black,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: UniSoundColor.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 20),
                                  child: Text(
                                    "Payment Channel",
                                    style: GoogleFonts.robotoCondensed(
                                      color: UniSoundColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: UniSoundColor.wh,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 25,
                                          right: 25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 2,
                                            color: UniSoundColor.black,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: SizedBox(
                                            height: 40.0,
                                            child: DropdownButton<String>(
                                              hint: Text(
                                                "Payment Channel",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              isExpanded: true,
                                              value: channelPaymentValue,
                                              icon: Icon(
                                                Icons.arrow_downward,
                                                color: UniSoundColor.black,
                                              ),
                                              elevation: 16,
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                color: UniSoundColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: UniSoundColor.wh,
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  channelPaymentValue = value!;
                                                  setpayment.channelpayment =
                                                      channelPaymentValue!;
                                                });
                                              },
                                              items: channelPayment.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 20),
                                  child: Text(
                                    "Sold Price",
                                    style: GoogleFonts.robotoCondensed(
                                      color: UniSoundColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, bottom: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 2,
                                        color: UniSoundColor.black,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        onChanged: (value) {
                                          if (value != '') {
                                            setpayment.saleprice =
                                                int.parse(priceController.text);
                                            setState(() {});
                                          }
                                        },
                                        controller: priceController,
                                        keyboardType: TextInputType.text,
                                        style: GoogleFonts.robotoCondensed(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: UniSoundColor.black,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\b|\b\s")),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Price",
                                          hintStyle:
                                              GoogleFonts.robotoCondensed(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            color: UniSoundColor.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                channelSaleListValue == "Shopee Customer" ||
                                        channelSaleListValue ==
                                            'TikTok Customer' ||
                                        channelSaleListValue ==
                                            'Lazada Customer'
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5, left: 20),
                                            child: Text(
                                              "Platform Fee Price",
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                color: UniSoundColor.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25,
                                                right: 25,
                                                bottom: 15),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 2,
                                                  color: UniSoundColor.black,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: TextField(
                                                  onChanged: (value) {
                                                    if (value != '') {
                                                      setpayment
                                                              .feeplatformprice =
                                                          int.parse(
                                                              platformfeepriceController
                                                                  .text);
                                                      setState(() {});
                                                    }
                                                  },
                                                  controller:
                                                      platformfeepriceController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    color: UniSoundColor.black,
                                                  ),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(RegExp(
                                                            r"\s\b|\b\s")),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Platform Fee Price",
                                                    hintStyle: GoogleFonts
                                                        .robotoCondensed(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18,
                                                      color:
                                                          UniSoundColor.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 37,
                                        child: Text(
                                          "This product is on sale",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 65,
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Checkbox(
                                            value: thisitemonsale,
                                            onChanged: (value) {
                                              setState(() {
                                                thisitemonsale = value!;
                                                setpayment.thisitemsale =
                                                    thisitemonsale;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 37,
                                        child: Text(
                                          "This product is junk",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 65,
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Checkbox(
                                            value: thisisjunk,
                                            onChanged: (value) {
                                              setState(() {
                                                thisisjunk = value!;
                                                setpayment.thisisjunk =
                                                    thisisjunk;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Wheel discount",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Checkbox(
                                            value: getwheeldiscount,
                                            onChanged: (value) {
                                              if (value!) {
                                                wheeldiscountController.text =
                                                    "0";
                                                setpayment.wheeldiscountnumber =
                                                    int.parse(
                                                        wheeldiscountController
                                                            .text);
                                              } else {
                                                setpayment.wheeldiscountnumber =
                                                    0;
                                                wheeldiscountController.text =
                                                    "";
                                              }
                                              setState(() {
                                                getwheeldiscount = value;
                                                setpayment.getwheeldiscount =
                                                    getwheeldiscount;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, bottom: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 2,
                                        color: UniSoundColor.black,
                                      ),
                                      color: getwheeldiscount
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        readOnly: !getwheeldiscount,
                                        controller: wheeldiscountController,
                                        onChanged: (value) {
                                          if (wheeldiscountController.text !=
                                              "") {
                                            setpayment.wheeldiscountnumber =
                                                int.parse(
                                                    wheeldiscountController
                                                        .text);
                                          } else {
                                            setpayment.wheeldiscountnumber = 0;
                                          }

                                          setState(() {});
                                        },
                                        keyboardType: TextInputType.text,
                                        style: GoogleFonts.robotoCondensed(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: UniSoundColor.black,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\b|\b\s")),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Discount (THB)",
                                          hintStyle:
                                              GoogleFonts.robotoCondensed(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            color: UniSoundColor.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 15,
                                        child: Text(
                                          "Member",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 85,
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Checkbox(
                                            value: customermember,
                                            onChanged: (value) {
                                              if (value!) {
                                                setpayment.telmember =
                                                    telmemberController.text;
                                              } else {
                                                setpayment.telmember = "";
                                              }
                                              setState(() {
                                                customermember = value;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, bottom: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 2,
                                        color: UniSoundColor.black,
                                      ),
                                      color: customermember
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        readOnly: !customermember,
                                        controller: telmemberController,
                                        onChanged: (value) {
                                          setpayment.telmember =
                                              telmemberController.text;
                                          setState(() {});
                                        },
                                        keyboardType: TextInputType.text,
                                        style: GoogleFonts.robotoCondensed(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: UniSoundColor.black,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\b|\b\s")),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Tel",
                                          hintStyle:
                                              GoogleFonts.robotoCondensed(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            color: UniSoundColor.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 1000,
              decoration: BoxDecoration(
                color: setpayment.checkElement
                    ? UniSoundColor.wh
                    : UniSoundColor.fadeGray,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: 30,
                  right: 30,
                ),
                child: loadingsummary
                    ? const LoadingWidget()
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.caretRight,
                                    size: 40,
                                    color: UniSoundColor.rePurple,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "SUMMARY",
                                      style: GoogleFonts.robotoCondensed(
                                        color: setpayment.checkElement
                                            ? UniSoundColor.black
                                            : UniSoundColor.reGray,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            setpayment.checkElement
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 15,
                                              child: Text(
                                                "NAME :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 85,
                                              child: setpayment.thisitemsale &&
                                                      setpayment.thisisjunk
                                                  ? Text(
                                                      "**SALE** **JUNK** ${setpayment.itemmname}",
                                                      style: GoogleFonts
                                                          .robotoCondensed(
                                                        color:
                                                            UniSoundColor.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  : Text(
                                                      setpayment.thisitemsale
                                                          ? "**SALE** ${setpayment.itemmname}"
                                                          : setpayment
                                                                  .thisisjunk
                                                              ? "**JUNK** ${setpayment.itemmname}"
                                                              : setpayment
                                                                  .itemmname,
                                                      style: GoogleFonts
                                                          .robotoCondensed(
                                                        color:
                                                            UniSoundColor.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 15,
                                              child: Text(
                                                "SKU TH :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 85,
                                              child: Text(
                                                setpayment.skuth,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 15,
                                              child: Text(
                                                "SKU JP :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 85,
                                              child: Text(
                                                setpayment.skujp,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 25,
                                              child: Text(
                                                "SOLD PRICE :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 75,
                                              child: Text(
                                                "${fcomma.format(setpayment.saleprice)} THB",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      channelSaleListValue ==
                                                  "Shopee Customer" ||
                                              channelSaleListValue ==
                                                  'TikTok Customer' ||
                                              channelSaleListValue ==
                                                  'Lazada Customer'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5, left: 20),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 25,
                                                    child: Text(
                                                      "PLATFOM FEE PRICE :  ",
                                                      style: GoogleFonts
                                                          .robotoCondensed(
                                                        color:
                                                            UniSoundColor.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 75,
                                                    child: Text(
                                                      "${fcomma.format(setpayment.feeplatformprice)} THB",
                                                      style: GoogleFonts
                                                          .robotoCondensed(
                                                        color:
                                                            UniSoundColor.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 25,
                                              child: Text(
                                                "SOLD DATE :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 75,
                                              child: Text(
                                                setpayment.solddate,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 30,
                                              child: Text(
                                                "SERIAL NUMBER :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 70,
                                              child: Text(
                                                setpayment.serialnum,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 30,
                                              child: Text(
                                                "PAYMENT CHANNEL :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 70,
                                              child: Text(
                                                setpayment.channelpayment,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 30,
                                              child: Text(
                                                "SOLD CHANNEL :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 70,
                                              child: Text(
                                                setpayment.channelsale,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 40,
                                              child: Text(
                                                "ADVERTISING CHANNEL :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 60,
                                              child: Text(
                                                setpayment.channelads,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 40,
                                              child: Text(
                                                "WHEEL DISCOUNT :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 60,
                                              child: setpayment
                                                          .wheeldiscountnumber ==
                                                      0
                                                  ? Text(
                                                      "0 THB (MISS)",
                                                      style: GoogleFonts
                                                          .robotoCondensed(
                                                        color:
                                                            UniSoundColor.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  : Text(
                                                      "${fcomma.format(setpayment.wheeldiscountnumber)} THB",
                                                      style: GoogleFonts
                                                          .robotoCondensed(
                                                        color:
                                                            UniSoundColor.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 15,
                                              child: Text(
                                                "MEMBER :  ",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 85,
                                              child: Text(
                                                setpayment.telmember == ''
                                                    ? "Not member"
                                                    : setpayment.telmember,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, bottom: 60, right: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  loadingsummary = true;
                                                });
                                                //bool resultcheck =
                                                //    await getflgchecksheet();
                                                bool resultcheck =
                                                    await getvaluechecksheet(
                                                        setpayment);
                                                //print(resultcheck);
                                                if (resultcheck) {
                                                  bool resultconfrim =
                                                      await confirmpaymentController(
                                                          setpayment);
                                                  if (resultconfrim) {
                                                    sendcommandopendrawer();
                                                    scancodecontroller.text =
                                                        '';
                                                    getitem = ItemdetailModel
                                                        .newModel();
                                                    setpayment =
                                                        PaymentdetailModel
                                                            .newModel();
                                                  }
                                                  setState(() {
                                                    loadingsummary = false;
                                                  });
                                                  clearInputPaymentPart();
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return resultdialogconfirmpayment(
                                                          resultconfrim,
                                                        );
                                                      });
                                                } else {
                                                  setState(() {
                                                    loadingsummary = false;
                                                  });
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return resultdialogcheck();
                                                      });
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 200,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color:
                                                      scancodecontroller.text !=
                                                              ''
                                                          ? Colors.green
                                                          : Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 3,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                                child: Text(
                                                  "CONFIRM PAYMENT",
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    color: UniSoundColor.wh,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Text(
                                          "* Don't forget to write the invoice in the invoice book for the customer.",
                                          style: GoogleFonts.robotoCondensed(
                                              color: UniSoundColor.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 20),
                                        child: Text(
                                          "   อย่าลืมเขียนบิลในเล่มให้คุณลูกค้าด้วยน้า",
                                          style: GoogleFonts.kanit(
                                              color: UniSoundColor.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
