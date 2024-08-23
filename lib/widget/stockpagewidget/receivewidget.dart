import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unisoundpos/api/getlastskuth.dart';
import 'package:unisoundpos/controller/confirmreceive_contolller.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/utility/convertrawtosix.dart';
import 'package:unisoundpos/widget/loading_widget.dart';
import 'package:unisoundpos/widget/stockpagewidget/showdialogreceive.dart';
import 'package:url_launcher/url_launcher.dart';

class Receivewidget extends StatefulWidget {
  const Receivewidget({super.key});

  @override
  State<Receivewidget> createState() => _ReceivewidgetState();
}

class _ReceivewidgetState extends State<Receivewidget> {
  TextEditingController scanskujpController = TextEditingController();
  late bool newlotschecked;
  late String startsku;
  late String lastestsku;
  late List<String> listskujp;
  late bool loadingsummary;
  late String receivepdfurl;

  @override
  void initState() {
    listskujp = [];
    newlotschecked = true;
    startsku = "----------";
    lastestsku = "----------";
    receivepdfurl = '';
    loadingsummary = false;
    getintitaldata();
    super.initState();
  }

  getintitaldata() async {
    lastestsku = await getlastskuth();
    setupstartsku();
    setState(() {});
  }

  setupstartsku() {
    String fisrtflag = lastestsku.split('-')[0];
    String secondflag = lastestsku.split('-')[1];
    String thridflag = lastestsku.split('-')[2];
    if (newlotschecked) {
      startsku =
          "$fisrtflag-${int.parse(secondflag) + 1}-${int.parse(thridflag) + 1}";
    } else {
      startsku = "$fisrtflag-$secondflag-${int.parse(thridflag) + 1}";
    }
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
                  FontAwesomeIcons.plus,
                  size: 40,
                  color: UniSoundColor.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "RECEIVE NEW ITEM",
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
                flex: 3,
                child: loadingsummary
                    ? const SizedBox(
                        width: 200,
                        height: 500,
                        child: LoadingWidget(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, bottom: 5, right: 30),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "NEW LOTS",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: newlotschecked,
                                                onChanged: (value) {
                                                  if (value!) {
                                                    newlotschecked = value;
                                                    setupstartsku();
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                              Text(
                                                "YES",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: !newlotschecked,
                                                onChanged: (value) {
                                                  if (value!) {
                                                    newlotschecked = !value;
                                                    setupstartsku();
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                              Text(
                                                "NO",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  color: UniSoundColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 200, bottom: 5, right: 30),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "LASTEST SKU",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        lastestsku,
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 200, bottom: 5, right: 30),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "START SKU",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        startsku,
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, top: 10, bottom: 5, right: 30),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "TOTAL ITEM",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            listskujp.length.toString(),
                                            style: GoogleFonts.robotoCondensed(
                                              color: UniSoundColor.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 70,
                                          ),
                                          Text(
                                            "UNIT",
                                            style: GoogleFonts.robotoCondensed(
                                              color: UniSoundColor.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 60, right: 30, left: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      bool result = false;
                                      setState(() {
                                        loadingsummary = true;
                                      });
                                      Response resultconfrim =
                                          await confirmreceiveController(
                                              listskujp, startsku);
                                      if (resultconfrim.statusCode == 200) {
                                        receivepdfurl =
                                            "https://uni-sound-euclid-viiamocvka-an.a.run.app/api/barcodelist.pdf";
                                        result = true;
                                      }
                                      setState(() {
                                        loadingsummary = false;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return resultdialogconfirmreceive(
                                            result,
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: listskujp.isNotEmpty
                                            ? Colors.green
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 3,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Text(
                                        "CONFIRM RECEIVE",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.wh,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (listskujp.isNotEmpty) {
                                        scanskujpController.text = '';
                                        listskujp = [];
                                        newlotschecked = true;
                                        receivepdfurl = '';
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: listskujp.isNotEmpty
                                            ? Colors.red
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 3,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Text(
                                        "CLEAR",
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
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, bottom: 5, left: 40),
                        child: Text(
                          "SCAN SKU JAPAN",
                          style: GoogleFonts.robotoCondensed(
                            color: UniSoundColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 15),
                        child: Container(
                          height: 750,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: UniSoundColor.black,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              expands: true,
                              onChanged: (value) {
                                scanskujpController.text =
                                    convertrawtosix(value);
                                List<String> getlistskujp =
                                    scanskujpController.text.split(' ');
                                listskujp = getlistskujp.toSet().toList();
                                listskujp.removeWhere((item) => item == '');
                                setState(() {});
                              },
                              controller: scanskujpController,
                              style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: UniSoundColor.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "SCAN",
                                hintStyle: GoogleFonts.robotoCondensed(
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
                ),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 40),
                        child: Text(
                          "RESULTs",
                          style: GoogleFonts.robotoCondensed(
                            color: UniSoundColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      receivepdfurl == ''
                          ? Container()
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    height: 650,
                                    child: SfPdfViewer.network(
                                      receivepdfurl,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (receivepdfurl != '') {
                                        String filePath = receivepdfurl;
                                        final Uri uri = Uri.parse(filePath);
                                        launchUrl(uri);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: receivepdfurl == ''
                                            ? Colors.grey
                                            : Colors.blue,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 3,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Text(
                                        "PRINT STICKERS",
                                        style: GoogleFonts.robotoCondensed(
                                          color: UniSoundColor.wh,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
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
            ],
          )
        ],
      ),
    );
  }
}
