import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'extentions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AkuntansiKeuangan extends StatefulWidget {
  const AkuntansiKeuangan({super.key});

  @override
  State<AkuntansiKeuangan> createState() => _AkuntansiKeuanganState();
}

class _AkuntansiKeuanganState extends State<AkuntansiKeuangan>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  bool card = true;
  Color warna = '#ffffff'.toColor();
  Widget box({width: 100.0, height: 100.0}) => Container(
        width: width,
        height: height,
        color: Colors.grey,
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool stateFocusTextfield = false;
  FocusNode focusNodeTitikJemput = FocusNode();
  FocusNode focusNodeLokasiTujuan = FocusNode();

  Widget buildTopBar() {
    return Wrap(
      children: [
        Container(
          // height: 247.0,
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    // horizontal: 10,
                    ),
                child: Row(
                  children: [
                    Image.asset("img/arrow-back.png"),
                  ],
                ),
              ),
              buildHeader(),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Text(
                    "Riwayat Transaksi Harian",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: Container()),
                  Image.asset(
                    "img/filter.png",
                    scale: 3.0,
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                ],
              ),
              buildTransaksi(),
              buildTransaksi(),
              buildTransaksi(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      width: MediaQuery.of(context).size.width,
      // height: 120.0,
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xFFF3C703),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
              vertical: 10,
            )),
            Row(
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 5)),
                Image.asset(
                  "img/tunai.png",
                  scale: 3.0,
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(right: 5)),
                Text(
                  "Hari ini",
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Image.asset(
                  "img/arrow-down.png",
                  scale: 3.0,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10)),
                Text(
                  "175.000",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                // Padding(padding: EdgeInsets.only(right: 10)),
                Expanded(child: Row()),
                Image.asset(
                  "img/information.png",
                  scale: 3.0,
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  left: 10,
                )),
                Expanded(
                  child: Card(
                    color: '#F3C703'.toColor(),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: '#FFFFFF'.toColor()),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "img/tunai-driver.png",
                            scale: 3.0,
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tunai",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 3)),
                              Text(
                                "Rp 50.000",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Image.asset(
                            "img/nontunai-driver.png",
                            scale: 3.0,
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Non-Tunai",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 3)),
                              Text(
                                "Rp 150.000",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  left: 10,
                )),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
          ],
        ),
      ),
    );
    //
  }

  Widget buildTransaksi() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      width: MediaQuery.of(context).size.width,
      // height: 120.0,
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xF7FCF93),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Image.asset(
                          "img/titikjemput.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Text(
                          "Fasilkom, Indralaya",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Image.asset(
                          "img/tujuan.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Text(
                          "Fasilkom, Indralaya",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    Card(
                      color: '#97DDA6'.toColor(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              "Rp 10.000",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text("1 Februari 2023", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                Padding(padding: EdgeInsets.only(right: 10)),
                Text("10.10 WIB", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
          ],
        ),
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            buildTopBar(),
          ],
        ),
      ),
    );
  }


    }