import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/controller/confirmupdatestatuscondition_controller.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/utility/convertskuth.dart';
import 'package:unisoundpos/widget/loading_widget.dart';
import 'package:unisoundpos/widget/stockpagewidget/currentlystatuswidget.dart';

class Updatestatuswidget extends StatefulWidget {
  const Updatestatuswidget({super.key});

  @override
  State<Updatestatuswidget> createState() => _UpdatestatuswidgetState();
}

class _UpdatestatuswidgetState extends State<Updatestatuswidget> {
  TextEditingController scancodecontroller = TextEditingController();
  late List<String> listskuth;
  late List<String> skureadytocall;
  late bool loadingstate;

  /// FOR DROP
  List<String> statuslist = <String>[
    'Recieve/受取済',
    'Sold/売却済',
    'Cleaned/クリーン済み',
    'Auction/オークション',
    'Shopify/ショッピファイ',
    'Pricing/価格設定',
    'Photoshoot/撮影',
    'Repair/修理中'
  ];
  List<String> conditionlist = <String>[
    'Junk/ジャンク',
    'Need repair/修理が必要',
    'Ready for sale/販売準備完了',
  ];
  String? conditionlistValue;
  String? statuslistValue;

  Color? colorstate(String statein) {
    switch (statein) {
      case "Recieve/受取済":
        return UniSoundColor.recieve;
      case "Sold/売却済":
        return UniSoundColor.sold;
      case "Cleaned/クリーン済み":
        return UniSoundColor.cleaned;
      case "Auction/オークション":
        return UniSoundColor.auction;
      case "Shopify/ショッピファイ":
        return UniSoundColor.shopify;
      case "Pricing/価格設定":
        return UniSoundColor.pricing;
      case "Photoshoot/撮影":
        return UniSoundColor.photoshoot;
      case "Repair/修理中":
        return UniSoundColor.repair;
      case "Junk/ジャンク":
        return UniSoundColor.junk;
      case "Need repair/修理が必要":
        return UniSoundColor.needrepair;
      case "Ready for sale/販売準備完了":
        return UniSoundColor.readyforsale;
    }
    return null;
  }

  @override
  void initState() {
    loadingstate = false;
    listskuth = [];
    skureadytocall = [];
    super.initState();
  }

  lookuptoskureadytocall() {
    skureadytocall = [];
    for (String element in listskuth) {
      if (element.split('').length == 10) {
        skureadytocall.add(element);
      }
    }
  }

  clearinputstate() {
    skureadytocall = [];
    listskuth = [];
    scancodecontroller.text = '';
    statuslistValue = null;
    conditionlistValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.repeat,
                  size: 40,
                  color: UniSoundColor.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "UPDATE STATUS",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                    left: 40,
                  ),
                  child: loadingstate
                      ? const SizedBox(
                          width: 200,
                          height: 400,
                          child: LoadingWidget(),
                        )
                      : Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
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
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    height: 400,
                                    decoration: BoxDecoration(
                                      color: UniSoundColor.wh,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 3,
                                        color: UniSoundColor.black,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 25,
                                        right: 25,
                                        bottom: 10,
                                      ),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.start,
                                        maxLines: null,
                                        expands: true,
                                        onChanged: (value) {
                                          scancodecontroller.text =
                                              convertskuth(value);
                                          List<String> getlistskujp =
                                              scancodecontroller.text
                                                  .split(' ');
                                          listskuth =
                                              getlistskujp.toSet().toList();
                                          listskuth.removeWhere(
                                              (item) => item == '');
                                          lookuptoskureadytocall();
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          hintText: "SKU TH",
                                          hintStyle:
                                              GoogleFonts.robotoCondensed(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: scancodecontroller,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "TOTAL ITEM :",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "       ${skureadytocall.length}       UNIT",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "UPDATE STATUS :",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: statuslistValue == null
                                            ? Colors.white
                                            : colorstate(statuslistValue!),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          width: 3,
                                          color: UniSoundColor.black,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 30,
                                          left: 30,
                                        ),
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            "Status",
                                            style: GoogleFonts.robotoCondensed(
                                              color: UniSoundColor.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          isExpanded: true,
                                          value: statuslistValue,
                                          icon: Icon(
                                            Icons.arrow_downward,
                                            color: UniSoundColor.black,
                                          ),
                                          elevation: 16,
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                          underline: const SizedBox(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              statuslistValue = value!;
                                            });
                                          },
                                          items: statuslist
                                              .map<DropdownMenuItem<String>>(
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
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "UPDATE CONDITION :",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: conditionlistValue == null
                                            ? Colors.white
                                            : colorstate(conditionlistValue!),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          width: 3,
                                          color: UniSoundColor.black,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 30,
                                          left: 30,
                                        ),
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            "Condition",
                                            style: GoogleFonts.robotoCondensed(
                                              color: UniSoundColor.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          isExpanded: true,
                                          value: conditionlistValue,
                                          icon: Icon(
                                            Icons.arrow_downward,
                                            color: UniSoundColor.black,
                                          ),
                                          elevation: 16,
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                          underline: const SizedBox(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              conditionlistValue = value!;
                                            });
                                          },
                                          items: conditionlist
                                              .map<DropdownMenuItem<String>>(
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
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 60, bottom: 60, right: 30, left: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (skureadytocall.isNotEmpty &&
                                          statuslistValue != null &&
                                          conditionlistValue != null) {
                                        setState(() {
                                          loadingstate = true;
                                        });
                                        bool result =
                                            await confirmupdatestatusconditionController(
                                                skureadytocall,
                                                statuslistValue!,
                                                conditionlistValue!);
                                        if (result) {
                                          clearinputstate();
                                          loadingstate = false;
                                          setState(() {});
                                        }
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 500,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: (skureadytocall.isNotEmpty &&
                                                statuslistValue != null &&
                                                conditionlistValue != null)
                                            ? Colors.green
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 3,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Text(
                                        "CONFIRM UPDATE STATUS AND CONDITION",
                                        style: GoogleFonts.robotoCondensed(
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
                          ],
                        ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CURRENTLY STATUS AND CONDITION",
                        style: GoogleFonts.robotoCondensed(
                          color: UniSoundColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "SKU TH",
                                  style: GoogleFonts.robotoCondensed(
                                    color: UniSoundColor.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "STATUS",
                                  style: GoogleFonts.robotoCondensed(
                                    color: UniSoundColor.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "CONDITION",
                                  style: GoogleFonts.robotoCondensed(
                                    color: UniSoundColor.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: 740,
                          child: ListView.builder(
                              itemCount: skureadytocall.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Currentlystatuswidget(
                                  skuthin: listskuth[index],
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
