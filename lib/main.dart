import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './home.dart' as home;
import './homesearch.dart' as search;
import './homejemput.dart' as lokasiJemput;
import './homeTujuan.dart' as lokasiTujuan;
import './homeprice.dart' as homeprice;
import './homepembayaran.dart' as homepembayaran;
import './homepesan.dart' as homepesan;
import './hometerpesan.dart' as hometerpesan;
import './akuntansikeuangan.dart' as akuntansikeuangan;

void main() {
  runApp(MaterialApp(
    title: "Home",
    home: home.Home(),
    theme: ThemeData(fontFamily: 'Poppins'),
  ));
}