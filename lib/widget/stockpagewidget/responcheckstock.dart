import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/model/countitemcheckstock_model.dart';
import 'package:unisoundpos/style/color_unisound.dart';

class Responcheckstock extends StatefulWidget {
  final CountitemcheckstockModel resultin;
  const Responcheckstock({super.key, required this.resultin});

  @override
  State<Responcheckstock> createState() => _ResponcheckstockState();
}

class _ResponcheckstockState extends State<Responcheckstock> {
  late bool callbackstatus;
  late Icon showicon;

  drfineicon(bool iconin) {
    if (callbackstatus) {
      showicon = const Icon(
        FontAwesomeIcons.checkCircle,
        color: Colors.green,
        size: 18,
      );
    } else {
      showicon = const Icon(
        FontAwesomeIcons.circleXmark,
        color: Colors.red,
        size: 18,
      );
    }
  }

  @override
  void initState() {
    callbackstatus = widget.resultin.result;
    showicon = const Icon(
      FontAwesomeIcons.circleXmark,
      color: Colors.red,
      size: 18,
    );
    drfineicon(widget.resultin.result);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.resultin.skuth,
                style: GoogleFonts.robotoCondensed(
                  color: UniSoundColor.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  showicon,
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.resultin.result ? "SUCCESS" : "ERROR",
                      style: GoogleFonts.robotoCondensed(
                        color: callbackstatus ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
