import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/api/listingshopeelazadabysku.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/widget/loading_widget.dart';

class Listingshopeelazadawidget extends StatefulWidget {
  const Listingshopeelazadawidget({super.key});

  @override
  State<Listingshopeelazadawidget> createState() => _ListingshopeelazadawidgetState();
}

class _ListingshopeelazadawidgetState extends State<Listingshopeelazadawidget> {

  TextEditingController skucodecontroller = TextEditingController();
  late bool loadingstate;

 
  @override
  void initState() {
    loadingstate = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView( child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.clipboardList,
                    size: 40,
                    color: UniSoundColor.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "LISTING SHOPEE LAZADA",
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
            loadingstate
                        ? const SizedBox(
                            width: 200,
                            height: 400,
                            child: LoadingWidget(),
                          )
                        : Padding(
              padding: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Expanded(
                      flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 5),
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            child: Text(
                              "SKU :",
                              style: GoogleFonts.robotoCondensed(
                                color: UniSoundColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: UniSoundColor.wh,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 3,
                                            color: UniSoundColor.black,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10,
                                          ),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.start,
                                            maxLines: null,
                                            expands: true,
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
                                            keyboardType:
                                                TextInputType.multiline,
                                            controller: skucodecontroller,
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
                                      flex: 4,
                                      child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 60, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            loadingstate = true;
                                          });
                                          listingshopeelazadabysku(skucodecontroller.text).then((value) {
                                            setState(() {
                                              loadingstate = false;
                                            });
                                            if (value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'CREATE LISTING SUCCESS'),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'CREATE LISTING FAIL'),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 500,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: (skucodecontroller.text.isNotEmpty)
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
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}