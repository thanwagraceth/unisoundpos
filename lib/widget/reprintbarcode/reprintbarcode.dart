import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unisoundpos/api/reprintbaecodebysku.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/utility/convertskuth.dart';
import 'package:unisoundpos/widget/loading_widget.dart';
import 'package:unisoundpos/widget/reprintbarcode/showdialogreprint.dart';
import 'package:url_launcher/url_launcher.dart';

class Reprintbarcode extends StatefulWidget {
  const Reprintbarcode({super.key});

  @override
  State<Reprintbarcode> createState() => _ReprintbarcodeState();
}

class _ReprintbarcodeState extends State<Reprintbarcode> {
  TextEditingController scancodecontroller = TextEditingController();
  late bool loadingstate;
  late List<String> listskuth;
  late List<String> skureadytocall;
  late String receivepdfurl;

  @override
  void initState() {
    loadingstate = false;
    listskuth = [];
    skureadytocall = [];
    receivepdfurl = '';
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
                  FontAwesomeIcons.barcode,
                  size: 40,
                  color: UniSoundColor.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "REPRINT BARCODE",
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
                              padding: const EdgeInsets.only(
                                  top: 60, bottom: 60, right: 30, left: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loadingstate = true;
                                      });
                                      Response result =
                                          await reprintbaecodebysku(
                                              skureadytocall);
                                      if (result.statusCode == 200) {
                                        receivepdfurl =
                                            "https://uni-sound-euclid-viiamocvka-an.a.run.app/api/reprintbarcode.pdf";
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return resultdialogconfirmreprint();
                                          },
                                        );
                                      }
                                      setState(() {
                                        loadingstate = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 500,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: (skureadytocall.isNotEmpty)
                                            ? Colors.green
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 3,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Text(
                                        "CREATE BARCODE",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 40),
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
            ],
          )
        ],
      ),
    );
  }
}
