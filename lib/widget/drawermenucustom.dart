import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/pages/loginpin.dart';
import 'package:unisoundpos/pages/salepage.dart';
import 'package:unisoundpos/pages/stockpage.dart';
import 'package:unisoundpos/style/color_unisound.dart';

class DrawerMenuCustom extends StatefulWidget {
  const DrawerMenuCustom({super.key});

  @override
  _DrawerMenuCustomState createState() => _DrawerMenuCustomState();
}

class _DrawerMenuCustomState extends State<DrawerMenuCustom> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: UniSoundColor.wh,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: UniSoundColor.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icon/logoUniRe.jpg",
                      width: 100,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "UNISOUND",
                          style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "BANGKOK",
                          style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const FaIcon(FontAwesomeIcons.cashRegister),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'SALES',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SalePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const FaIcon(FontAwesomeIcons.box),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'STOCK MANAGEMENT',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StockPage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 650,
          ),
          ListTile(
            title: Row(
              children: [
                const SizedBox(
                  width: 13,
                ),
                // ignore: deprecated_member_use
                const FaIcon(FontAwesomeIcons.signOutAlt),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Logout',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            onTap: () async {
              // LOG OUT
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Loginpin(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
