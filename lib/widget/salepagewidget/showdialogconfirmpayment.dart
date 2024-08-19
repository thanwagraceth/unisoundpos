import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget resultdialogconfirmpayment(bool result) {
  String wordresult = '';
  if (result) {
    wordresult = "SALESREPORT COMPLETELY";
  } else {
    wordresult = "SALESREPORT ERROR";
  }
  return Dialog(
    child: SizedBox(
      width: 800,
      height: 300,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          wordresult,
          style: GoogleFonts.robotoCondensed(
            color: result ? Colors.green : Colors.red,
            fontWeight: FontWeight.w900,
            fontSize: 50,
          ),
        ),
      ),
    ),
  );
}
