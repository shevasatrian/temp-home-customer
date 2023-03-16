import 'dart:async';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'extentions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTujuan extends StatefulWidget {
  const HomeTujuan({super.key});

  @override
  State<HomeTujuan> createState() => _HomeTujuanState();
}

class _HomeTujuanState extends State<HomeTujuan>
    with SingleTickerProviderStateMixin {
  late TabController controller;

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
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 0)],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0))),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // kamu mau pergi
        // buildPesanSekarang(),
        Container(
          // height: 100.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 0)],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14.0),
                  topLeft: Radius.circular(14.0))),
          child: Column(
            children: [
              Container(child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left:35)),
                      Text("Lokasi Tujuan", style: TextStyle(fontWeight: FontWeight.w700),)
                    ],
                  ),
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
                  const SizedBox(
                height: 20,
              ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left:35)),
                      Image.asset("img/tujuan.png", scale: 3.0,),
                      Padding(padding: EdgeInsets.only(left:10)),
                      Text("Gang Buntu")
                    ],
                  )
                  
                ],
              ) ),
              const SizedBox(
                height: 20,
              ),
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
              )
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
            buildMapBackground(),
            // bar atas
            buildTopBar(),

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
