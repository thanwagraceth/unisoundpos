import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unisoundpos/style/color_unisound.dart';
import 'package:unisoundpos/widget/drawermenucustom.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenuCustom(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: UniSoundColor.wh),
        backgroundColor: UniSoundColor.black,
        title: Text(
          "UNISOUND BAGKOK : STOCK",
          style: GoogleFonts.robotoCondensed(
            color: UniSoundColor.wh,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
