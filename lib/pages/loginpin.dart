import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/pages/salepage.dart';
import 'package:unisoundpos/style/color_unisound.dart';

class Loginpin extends StatefulWidget {
  const Loginpin({super.key});

  @override
  State<Loginpin> createState() => _LoginpinState();
}

class _LoginpinState extends State<Loginpin> {
  @override
  Widget build(BuildContext context) {
    double srcwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: UniSoundColor.black,
      body: SizedBox(
        width: srcwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Image.asset(
                "assets/icon/logoUniRe.jpg",
                width: 300,
                height: 300,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalePage(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: UniSoundColor.rePurple,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.caretRight,
                      color: UniSoundColor.wh,
                      size: 20,
                    ),
                    Icon(
                      FontAwesomeIcons.caretRight,
                      color: UniSoundColor.wh,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                        left: 8.0,
                      ),
                      child: Text(
                        "Esskeetit",
                        style: GoogleFonts.robotoCondensed(
                          color: UniSoundColor.wh,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.caretLeft,
                      color: UniSoundColor.wh,
                      size: 20,
                    ),
                    Icon(
                      FontAwesomeIcons.caretLeft,
                      color: UniSoundColor.wh,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
