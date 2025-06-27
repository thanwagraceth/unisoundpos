import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget resultdialogcheck() {
  String wordresult = "Please send the sales summary report for yesterday.";
  return Dialog(
    child: SizedBox(
      width: 800,
      height: 300,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          wordresult,
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoCondensed(
            color: Colors.red,
            fontWeight: FontWeight.w900,
            fontSize: 50,
          ),
        ),
      ),
    ),
  );
}
