import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/api/getstatusconditionbyskuth.dart';
import 'package:unisoundpos/style/color_unisound.dart';

class Currentlystatuswidget extends StatefulWidget {
  final String skuthin;
  const Currentlystatuswidget({super.key, required this.skuthin});

  @override
  State<Currentlystatuswidget> createState() => _CurrentlystatuswidgetState();
}

class _CurrentlystatuswidgetState extends State<Currentlystatuswidget> {
  late String statusitem;
  late String? conditionitem;

  getdatafromsheet() async {
    dynamic getdata = await getstatusconditionbyskuth(widget.skuthin);
    statusitem = getdata['status']!;
    conditionitem = getdata['condition'];
    setState(() {});
  }

  Color? colorstate(String? statein) {
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
    statusitem = "-----";
    conditionitem = "-----";
    getdatafromsheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.skuthin,
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
                decoration: BoxDecoration(
                  color: colorstate(statusitem),
                ),
                child: Text(
                  statusitem,
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
                decoration: BoxDecoration(
                  color: colorstate(conditionitem),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  conditionitem ?? "----",
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
    );
  }
}
