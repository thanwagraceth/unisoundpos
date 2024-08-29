import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/api/createchecksheet.dart';
import 'package:unisoundpos/api/getcheckstocksheet.dart';
import 'package:unisoundpos/api/updatechecksitllitem.dart';
import 'package:unisoundpos/model/countitemcheckstock_model.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/utility/convertskuth.dart';
import 'package:unisoundpos/widget/loading_widget.dart';
import 'package:unisoundpos/widget/stockpagewidget/responcheckstock.dart';

class Checkstockwidget extends StatefulWidget {
  const Checkstockwidget({super.key});

  @override
  State<Checkstockwidget> createState() => _CheckstockwidgetState();
}

class _CheckstockwidgetState extends State<Checkstockwidget> {
  TextEditingController scanskujpController = TextEditingController();
  late int expecteditem = 0;
  late int actualitem = 0;
  late List<String> listsku;
  late List<String> skureadytocall;
  late List<String> skumemory;
  late List<CountitemcheckstockModel> countitemresult;
  late bool sheetstill;
  late bool loadingstate;

  lookuptoskureadytocall() async {
    skureadytocall = [];
    for (String element in listsku) {
      if (element.split('').length == 10 && element.split("-").length == 3) {
        skureadytocall.add(element);
      }
    }

    if (skureadytocall.length - skumemory.length > 0) {
      List<String> skureadytocalltmp = skureadytocall;
      for (String element in skumemory) {
        skureadytocalltmp.remove(element);
      }
      for (String element in skureadytocalltmp) {
        CountitemcheckstockModel countitemresultelemetnt =
            await updatechecksitllitem(element);
        if (countitemresult.isNotEmpty) {
          if (countitemresult.last.skuth != countitemresultelemetnt.skuth) {
            countitemresult.add(countitemresultelemetnt);
            skumemory.add(countitemresultelemetnt.skuth);
          }
        } else {
          countitemresult.add(countitemresultelemetnt);
          skumemory.add(countitemresultelemetnt.skuth);
        }
      }
      int countactrulitem = 0;
      for (CountitemcheckstockModel elementcc in countitemresult) {
        if (elementcc.result) {
          countactrulitem = countactrulitem + 1;
        }
      }
      actualitem = countactrulitem;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {});
      });
    }
  }

  getchecksheetstatus() async {
    Map<String, dynamic> getstockcheet = await getcheckstocksheet();
    sheetstill = getstockcheet['status'];
    expecteditem = int.parse(getstockcheet['total']);
    actualitem = int.parse(getstockcheet['count']);
    loadingstate = false;
    setState(() {});
  }

  @override
  void initState() {
    sheetstill = false;
    loadingstate = true;
    listsku = [];
    skureadytocall = [];
    skumemory = [];
    countitemresult = [];
    getchecksheetstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.clipboardList,
                    size: 40,
                    color: UniSoundColor.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "CHECK STOCK",
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
                  child: loadingstate
                      ? const SizedBox(
                          width: 200,
                          height: 400,
                          child: LoadingWidget(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          "TODAY DATE :",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
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
                                  top: 20,
                                  bottom: 30,
                                  right: 40,
                                  left: 40,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (!sheetstill) {
                                      setState(() {
                                        loadingstate = true;
                                      });
                                      await createchecksheet();
                                      await getchecksheetstatus();
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: !sheetstill
                                          ? Colors.green
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    child: Text(
                                      !sheetstill
                                          ? "START CHECK STOCK"
                                          : "CHECKSTOCK SHEET IS WORKING",
                                      style: GoogleFonts.robotoCondensed(
                                        color: UniSoundColor.wh,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40, right: 40, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          "CHECK STOCK :",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "${DateTime.now().month}-${DateTime.now().year}",
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
                                  left: 40,
                                  right: 40,
                                  bottom: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          "EXPECTED ITEM :",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        "$expecteditem  UNIT",
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
                                  left: 40,
                                  right: 40,
                                  bottom: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          "ACTUAL ITEM :",
                                          style: GoogleFonts.robotoCondensed(
                                            color: UniSoundColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        "$actualitem  UNIT",
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
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5, left: 40),
                          child: Text(
                            "SCAN SKU TH",
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                expands: true,
                                onChanged: (value) async {
                                  scanskujpController.text =
                                      convertskuth(value);
                                  List<String> getlistsku =
                                      scanskujpController.text.split(' ');
                                  listsku = getlistsku.toSet().toList();
                                  listsku.removeWhere((item) => item == '');
                                  if (listsku.isNotEmpty) {
                                    if (skumemory.isNotEmpty) {
                                      if (listsku.last != skumemory.last) {
                                        await lookuptoskureadytocall();
                                      }
                                    } else {
                                      await lookuptoskureadytocall();
                                    }
                                  }
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 740,
                            child: ListView.builder(
                              itemCount: countitemresult.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Responcheckstock(
                                  resultin: countitemresult[index],
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
