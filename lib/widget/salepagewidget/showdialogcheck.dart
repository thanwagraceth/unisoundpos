import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget resultdialogcheck() {
  String wordresult = "Please send the sales summary report for yesterday.";
  return Dialog(
    child: SizedBox(
      width: 800,
      height: 200,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                wordresult,
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoCondensed(
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                  fontSize: 50,
                ),
              ),
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/youngmeme.jpeg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
