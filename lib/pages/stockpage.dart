import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/widget/drawermenucustom.dart';
import 'package:unisoundpos/widget/stockpagewidget/checkstockwidget.dart';
import 'package:unisoundpos/widget/stockpagewidget/genqrcodetoshopify.dart';
import 'package:unisoundpos/widget/stockpagewidget/receivewidget.dart';
import 'package:unisoundpos/widget/reprintbarcode/reprintbarcode.dart';
import 'package:unisoundpos/widget/stockpagewidget/updatestatuswidget.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late int currectlyselect;

  @override
  void initState() {
    currectlyselect = 1;
    super.initState();
  }

  Widget showwidgetbycurrentlyselected(int selected) {
    switch (selected) {
      case 1:
        return const Updatestatuswidget();
      case 2:
        return const Receivewidget();
      case 3:
        return const Checkstockwidget();
      case 4:
        return const Reprintbarcode();
      case 5:
        return const Genqrcodetoshopify();
      default:
        return const Updatestatuswidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenuCustom(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: UniSoundColor.wh),
        backgroundColor: UniSoundColor.black,
        title: Text(
          "UNISOUND BAGKOK : STOCK",
          style: GoogleFonts.robotoCondensed(
            color: UniSoundColor.wh,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 15,
            child: Container(
              decoration: BoxDecoration(
                color: UniSoundColor.fadeGray,
                border: Border(
                  right: BorderSide(width: 2, color: UniSoundColor.black),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currectlyselect = 1;
                      });
                    },
                    child: Container(
                      height: 80,
                      color: currectlyselect == 1
                          ? UniSoundColor.rePurple
                          : UniSoundColor.reGray,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.caretRight,
                              size: 30,
                              color: UniSoundColor.wh,
                            ),
                            Text(
                              "UPDATE STATUS",
                              style: GoogleFonts.robotoCondensed(
                                color: UniSoundColor.wh,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currectlyselect = 2;
                      });
                    },
                    child: Container(
                      height: 80,
                      color: currectlyselect == 2
                          ? UniSoundColor.rePurple
                          : UniSoundColor.reGray,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.caretRight,
                              size: 30,
                              color: UniSoundColor.wh,
                            ),
                            Text(
                              "RECEIVE",
                              style: GoogleFonts.robotoCondensed(
                                color: UniSoundColor.wh,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currectlyselect = 3;
                      });
                    },
                    child: Container(
                      height: 80,
                      color: currectlyselect == 3
                          ? UniSoundColor.rePurple
                          : UniSoundColor.reGray,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.caretRight,
                              size: 30,
                              color: UniSoundColor.wh,
                            ),
                            Text(
                              "CHECK STOCK",
                              style: GoogleFonts.robotoCondensed(
                                color: UniSoundColor.wh,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currectlyselect = 4;
                      });
                    },
                    child: Container(
                      height: 80,
                      color: currectlyselect == 4
                          ? UniSoundColor.rePurple
                          : UniSoundColor.reGray,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.caretRight,
                              size: 30,
                              color: UniSoundColor.wh,
                            ),
                            Text(
                              "REPRINT BARCODE",
                              style: GoogleFonts.robotoCondensed(
                                color: UniSoundColor.wh,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currectlyselect = 5;
                      });
                    },
                    child: Container(
                      height: 80,
                      color: currectlyselect == 5
                          ? UniSoundColor.rePurple
                          : UniSoundColor.reGray,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.caretRight,
                              size: 30,
                              color: UniSoundColor.wh,
                            ),
                            Text(
                              "GEN QRCODE SHOPIFY",
                              style: GoogleFonts.robotoCondensed(
                                color: UniSoundColor.wh,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 85,
            child: showwidgetbycurrentlyselected(currectlyselect),
          ),
        ],
      ),
    );
  }
}
