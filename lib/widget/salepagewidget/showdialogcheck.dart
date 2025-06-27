import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget resultdialogcheck() {
  String wordresult = "";
  return Dialog(
    child: SizedBox(
      width: 800,
      height: 500,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                height: 250.0,
                width: 250.0,
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
