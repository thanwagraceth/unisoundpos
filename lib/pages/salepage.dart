import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/widget/drawermenucustom.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  TextEditingController scancodecontroller = TextEditingController();

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
                          size: 20,
                          color: UniSoundColor.rePurple,
                        ),
                        Text(
                          "ITEM DETAIL",
                          style: GoogleFonts.robotoCondensed(
                            color: UniSoundColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "SCANCODE : ",
                          style: GoogleFonts.robotoCondensed(
                            color: UniSoundColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: UniSoundColor.rePurple,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 3,
                              color: UniSoundColor.black,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.end,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
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
                      ],
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: UniSoundColor.reGray,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.image,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 5,
                    ),
                    child: Text(
                      "NAME : ",
                      style: GoogleFonts.robotoCondensed(
                        color: UniSoundColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      "SKU : ",
                      style: GoogleFonts.robotoCondensed(
                        color: UniSoundColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      "PRICE : ",
                      style: GoogleFonts.robotoCondensed(
                        color: UniSoundColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 2, color: UniSoundColor.reGray),
                  right: BorderSide(width: 2, color: UniSoundColor.reGray),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
