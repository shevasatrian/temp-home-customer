import 'dart:async';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'extentions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePembayaran extends StatefulWidget {
  const HomePembayaran({super.key});

  @override
  State<HomePembayaran> createState() => _HomePembayaranState();
}

class _HomePembayaranState extends State<HomePembayaran>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   focusNodeLokasiTujuan.addListener(() {
  //     setState(() {});
  //   });
  //   focusNodeTitikJemput.addListener(() {
  //     setState(() {});
  //   });
  //   controller = TabController(length: 3, vsync: this);
  //   getCurrentLocation();
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool stateFocusTextfield = false;
  FocusNode focusNodeTitikJemput = FocusNode();
  FocusNode focusNodeLokasiTujuan = FocusNode();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  // LocationData? currentLocation;

  // void getCurrentLocation() {
  //   Location location = Location();

  //   location.getLocation().then((location) {
  //     setState(() {
  //       currentLocation = location;
  //     });
  //   });
  //   location.onLocationChanged.listen((newLoc) {
  //     setState(() {
  //       currentLocation = newLoc;
  //     });
  //   });
  // }

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

  // Widget buildMapBackground() {
  //   return currentLocation == null
  //       ? const Center(child: CircularProgressIndicator())
  //       : GoogleMap(
  //           mapType: MapType.normal,
  //           initialCameraPosition: CameraPosition(
  //             target: LatLng(
  //               currentLocation!.latitude!,
  //               currentLocation!.longitude!,
  //             ),
  //             zoom: 16.5,
  //           ),
  //           markers: {
  //             Marker(
  //               markerId: const MarkerId("currentLocation"),
  //               position: LatLng(
  //                   currentLocation!.latitude!, currentLocation!.longitude!),
  //             ),
  //           },
  //           onMapCreated: (GoogleMapController controller) {
  //             _controller.complete(controller);
  //           },
  //         );
  // }

  // Widget buildTopBar() {
  //   return Wrap(
  //     children: [
  //       Container(
  //         // height: 247.0,
  //         padding: const EdgeInsets.only(
  //           top: 10,
  //           bottom: 20,
  //           left: 20,
  //           right: 20,
  //         ),
  //         decoration: const BoxDecoration(
  //             color: Colors.white,
  //             boxShadow: [BoxShadow(blurRadius: 0)],
  //             borderRadius: BorderRadius.only(
  //                 bottomRight: Radius.circular(30.0),
  //                 bottomLeft: Radius.circular(30.0))),
  //         child: Column(
  //           children: [
  //             Container(
  //               color: Colors.white,
  //               padding: const EdgeInsets.symmetric(
  //                   // horizontal: 10,
  //                   ),
  //               child: Row(
  //                 children: [
  //                   Image.asset("img/profile.png"),
  //                   const Padding(
  //                     padding: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: const [
  //                       Text(
  //                         "Gandi Subara",
  //                         style: TextStyle(color: Colors.black, fontSize: 16.0),
  //                       ),
  //                       Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
  //                       Text(
  //                         "Fasilkom",
  //                         style: TextStyle(color: Colors.black, fontSize: 10.0),
  //                       ),
  //                     ],
  //                   ),
  //                   Expanded(child: Container()),
  //                   Image.asset(
  //                     "img/logo.png",
  //                     scale: 2.7,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Container(
  //               // padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
  //               child: TextField(
  //                 focusNode: focusNodeTitikJemput,
  //                 // style: TextStyle(color: Colors.pinkAccent, height:
  //                 //     MediaQuery.of(context).size.height/80),
  //                 decoration: InputDecoration(
  //                     contentPadding: EdgeInsets.symmetric(vertical: 10),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(30.0),
  //                     ),
  //                     filled: true,
  //                     hintStyle: TextStyle(color: Colors.grey[800]),
  //                     prefixIcon: Image.asset(
  //                       "img/titikJemput.png", scale: 3.0,
  //                     ),
  //                     hintText: "Titik Jemput",
  //                     fillColor: Colors.white70),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Container(
  //               // padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
  //               child: TextField(
  //                 focusNode: focusNodeLokasiTujuan,
  //                 decoration: InputDecoration(
  //                     contentPadding: EdgeInsets.symmetric(vertical: 10),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(30.0),
  //                     ),
  //                     filled: true,
  //                     hintStyle: TextStyle(color: Colors.grey[800]),
  //                     prefixIcon: Image.asset(
  //                       "img/tujuan.png", scale: 3.0,
  //                     ),
  //                     hintText: "Lokasi Tujuan",
  //                     fillColor: Colors.white70),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildBottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // kamu mau pergi
        // buildPesanSekarang(),
        Container(
          height: 735.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 0)],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0))),
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      // Text("Lokasi Jemput", style: TextStyle(fontWeight: FontWeight.w700),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Pilih metode pembayaran",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Metode pembayaran utama",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        "img/tunai.png",
                                        scale: 3.0,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                          Text(
                                            "Tunai",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                          Text(
                                            "Siapkan uang pas kamu, biar gak perlu",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                          Text(
                                            "nunggu kembalian lagi.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: SizedBox.fromSize()),
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Padding(padding: EdgeInsets.only(right: 5)),
                                      Image.asset(
                                        "img/radio-active.png",
                                        scale: 3.5,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFD4D8D6),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Metode pembayaran lainnya", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        "img/dana.png",
                        scale: 3.0,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        "Dana",
                        style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        "img/ovo.png",
                        scale: 3.0,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        "Ovo",
                        style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        "img/shopeepay.png",
                        scale: 3.0,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        "Shopeepay",
                        style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: 300.0,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: '#F3C703'.toColor()),
                  child: const Text("Lanjutkan"),
                  onPressed: (() => context),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            ],
          ),
        ),
      ],
    );
    //
  }

  Widget conditionalBuildBottomBar() {
    // print("lokasi tujuan : ${focusNodeLokasiTujuan.hasPrimaryFocus}");
    // print("lokasi jemput : ${focusNodeTitikJemput.hasPrimaryFocus}");
    return !focusNodeLokasiTujuan.hasFocus && !focusNodeTitikJemput.hasFocus
        ? Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomBar(),
          )
        : const SizedBox();
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
            // buildTopBar(),

            // Search
            // buildSearch(),

            // bottom bar
            conditionalBuildBottomBar(),
            // buildBottomBar(),
            // bottom navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              // child: bottomNavBar(),
            )
          ],
        ),
      ),
    );
  }
}
