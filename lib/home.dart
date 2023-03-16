import 'dart:async';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'extentions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  // String _warnaAktif = "#F3C703";
  // String _warnaTidakAktif = "#1E1E1E";
  // String _warnaBeranda = "#F3C703";
  // String _warnaRiwayat = "#1E1E1E";
  // String _warnaMenu = "#1E1E1E";

  bool card = true;
  Color warna = '#ffffff'.toColor();
  Widget box({width: 100.0, height: 100.0}) => Container(
        width: width,
        height: height,
        color: Colors.grey,
      );

  int selectedCard = -1;

  void _ubahWarna(int indexActiveCard) {
    setState(() {
      if (indexActiveCard == selectedCard) {
        // toggle border
        selectedCard = -1;
      } else {
        selectedCard = indexActiveCard;
      }
    });
  }

  int selectedTabbar = -1;

  void _ubahWarna2(int indexActiveTabbar) {
    setState(() {
      if (indexActiveTabbar == selectedTabbar) {
        // toggle tabbar
        selectedTabbar = -1;
      } else {
        selectedTabbar = indexActiveTabbar;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    focusNodeLokasiTujuan.addListener(() {
      setState(() {});
    });
    focusNodeTitikJemput.addListener(() {
      setState(() {});
    });
    controller = TabController(length: 3, vsync: this);
    getCurrentLocation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool stateFocusTextfield = false;
  FocusNode focusNodeTitikJemput = FocusNode();
  FocusNode focusNodeLokasiTujuan = FocusNode();

  Widget buildTopBar() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                  color: Color(0xFFF3C703),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Stack(
                children: [
                  _buildTopBar(),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 70.0,
          child: Container(
            child: buildSearch(),
          ),
        )
      ],
    );
  }

  Widget _buildTopBar() {
    return Wrap(
      children: [
        Container(
          // height: 100.0,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF3C703),
            // boxShadow: [BoxShadow(blurRadius: 0)],
            // borderRadius: BorderRadius.only(
            //     bottomRight: Radius.circular(30.0),
            //     bottomLeft: Radius.circular(30.0))
          ),
          child: Column(
            children: [
              Container(
                // color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    // horizontal: 10,
                    ),
                child: Row(
                  children: [
                    Image.asset("img/profile.png"),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Gandi Subara",
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
                        Text(
                          "Fasilkom",
                          style: TextStyle(color: Colors.black, fontSize: 10.0),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Image.asset(
                      "img/logo-2.png",
                      scale: 3.0,
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 50,
              // )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPesanSekarang() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: MediaQuery.of(context).size.width,
      // height: 120.0,
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Color(0xFFF3C703),
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
              vertical: 8,
            )),
            Text(
              "😀🤚🏻",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Kamu Mau Pergi?",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Buruan isi alamatnya, segera berangakat deh",
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "Metode Pembayaran",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Color(0xFFFAE897),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "img/ceklist.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Text(
                          "Tunai",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Card(
                  color: Color(0xFFFAE897),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "img/ceklist.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Text(
                          "QRIS",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Card(
                  color: Color(0xFFFAE897),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "img/ceklist.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Text(
                          "Dana",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
    //
  }

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // kamu mau pergi
          buildPesanSekarang(),
          Container(
            // height: 260.0,
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    spreadRadius: 4,
                    blurRadius: 21,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      // child: Card(
                      // // color: '#FFFFFF'.toColor(),
                      // shape: RoundedRectangleBorder(
                      //     side: BorderSide(
                      //       // color: '#FFFFFF'.toColor(),
                      //     ),
                      // borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "img/ojek.png",
                                      scale: 3.6,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Ojeknya Sikuning",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Akan membantu kamu untuk mengantar pergi & pulang ngampus",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Nantikan fitur terbaru mangjek ya",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Color(0xFF8C8C8C),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Expanded(child: SizedBox.fromSize()),
                                // Column(
                                //   // crossAxisAlignment: CrossAxisAlignment.end,
                                //   children: [
                                //     // Padding(padding: EdgeInsets.only(right: 5)),
                                //     Text(
                                //       "Rp 10.000",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.w600,
                                //           fontSize: 15),
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // ),
                    ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       _ubahWarna(0);
                    //     },
                    //     child: Card(
                    //       color: selectedCard == 0
                    //                 ? '#F7FCF9'.toColor()
                    //                 : "#FFFFFF".toColor(),
                    //       shape: RoundedRectangleBorder(
                    //           side: BorderSide(
                    //             color: selectedCard == 0
                    //                 ? '#33BC51'.toColor()
                    //                 : "#EBEFED".toColor(),
                    //           ),
                    //           borderRadius: BorderRadius.circular(10.0)),
                    //       child: Container(
                    //         padding: EdgeInsets.all(10.0),
                    //         decoration: BoxDecoration(),
                    //         child: Column(
                    //           // mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Image.asset("img/motor.png"),
                    //             Text("Motor")
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       _ubahWarna(1);
                    //     },
                    //     child: Card(
                    //       color: selectedCard == 1
                    //                 ? '#F7FCF9'.toColor()
                    //                 : "#FFFFFF".toColor(),
                    //       shape: RoundedRectangleBorder(
                    //           side: BorderSide(
                    //             color: selectedCard == 1
                    //                 ? '#33BC51'.toColor()
                    //                 : "#EBEFED".toColor(),
                    //           ),
                    //           borderRadius: BorderRadius.circular(10.0)),
                    //       child: Container(
                    //         padding: EdgeInsets.all(10.0),
                    //         decoration: BoxDecoration(),
                    //         child: Column(
                    //           children: [
                    //             Image.asset("img/makanan.png"),
                    //             Text("Makanan")
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       _ubahWarna(2);
                    //     },
                    //     child: Card(
                    //       color: selectedCard == 2
                    //                 ? '#F7FCF9'.toColor()
                    //                 : "#FFFFFF".toColor(),
                    //       shape: RoundedRectangleBorder(
                    //           side: BorderSide(
                    //             color: selectedCard == 2
                    //                 ? '#33BC51'.toColor()
                    //                 : "#EBEFED".toColor(),
                    //           ),
                    //           borderRadius: BorderRadius.circular(10.0)),
                    //       child: Container(
                    //         padding: EdgeInsets.all(10.0),
                    //         decoration: BoxDecoration(),
                    //         child: Column(
                    //           children: [
                    //             Image.asset("img/pesanAntar.png"),
                    //             Text("Pesan Antar")
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFF3C703))
                        // backgroundColor: Color(0xFFF3C703),
                        ),
                    child: const Text("Pesan Sekarang"),
                    onPressed: (() => context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    //
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
    location.onLocationChanged.listen((newLoc) {
      setState(() {
        currentLocation = newLoc;
      });
    });
  }

  Widget buildMapBackground() {
    return currentLocation == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
              zoom: 16.5,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("currentLocation"),
                position: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
  }

  Widget buildSearch() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      // height: 120.0,
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 4,
              blurRadius: 21,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Color(0xFFF7FCF9),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 7,
        ),
        child: Column(
          children: [
            Container(
              // padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                focusNode: focusNodeTitikJemput,
                // style: TextStyle(color: Colors.pinkAccent, height:
                //     MediaQuery.of(context).size.height/80),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: Image.asset(
                      "img/titikjemput.png",
                      scale: 3.0,
                    ),
                    hintText: "Titik Jemput",
                    fillColor: Colors.white70),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
              child: TextField(
                focusNode: focusNodeLokasiTujuan,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: Image.asset(
                      "img/tujuan.png",
                      scale: 3.0,
                    ),
                    hintText: "Lokasi Tujuan",
                    fillColor: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            // background / map
            // buildMapBackground(),
            // bar atas
            buildTopBar(),
            // search bar
            // buildSearch(),
            // bottom bar
            conditionalBuildBottomBar(),
            // bottom navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomNavBar(),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
          color: '#EBEFED'.toColor(),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))),
      child: TabBar(
        controller: controller,
        tabs: [
          Tab(
            icon: Image.asset(
              "img/home.png",
              // scale: 1.5,
              // color: _warnaBeranda.toColor(),
              // width: 100.0,
              color: '#F3C703'.toColor(),
            ),
            // ),

            child: Text(
              "Beranda",
              style: TextStyle(color: '#1E1E1E'.toColor()),
            ),
            // SizedBox(height: 0,)
          ),
          Tab(
            icon: Image.asset(
              "img/book.png",
              // scale: 1.5,
              // color: _warnaBeranda.toColor(),
              // width: 100.0,
              color: '#D4D8D6'.toColor(),
            ),
            // ),

            child: Text(
              "Riwayat",
              style: TextStyle(color: '#1E1E1E'.toColor()),
            ),
            // SizedBox(height: 0,)
          ),
          Tab(
            icon: Image.asset(
              "img/menu.png",
              // scale: 1.5,
              // color: _warnaBeranda.toColor(),
              // width: 100.0,
              color: '#D4D8D6'.toColor(),
            ),
            // ),

            child: Text(
              "Menu",
              style: TextStyle(color: '#1E1E1E'.toColor()),
            ),
            // SizedBox(height: 0,)
          ),
        ],
      ),
    );
  }

  Widget conditionalBuildBottomBar() {
    // print("lokasi tujuan : ${focusNodeLokasiTujuan.hasPrimaryFocus}");
    // print("lokasi jemput : ${focusNodeTitikJemput.hasPrimaryFocus}");
    return !focusNodeLokasiTujuan.hasFocus && !focusNodeTitikJemput.hasFocus
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 70,
              ),
              child: buildBottomBar(),
            ),
          )
        : const SizedBox();
  }
}
