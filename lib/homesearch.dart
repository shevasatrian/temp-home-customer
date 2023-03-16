import 'dart:async';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'extentions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
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

// top bar
  Widget buildTopBar() {
    return Wrap(
      children: [
        Container(
          // height: 247.0,

          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
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
                          Image.asset("img/arrow-back.png")
                          // IconButton(
                          //     onPressed: () => _controller,
                          //     icon: Icon(Icons.arrow_back), style: ButtonStyle(),),
                          // const Padding(
                          //   padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                              "img/titikjemput.png", scale: 3.0,
                            ),
                            hintText: "Titik Jemput",
                            fillColor: Colors.white70),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      focusNode: focusNodeLokasiTujuan,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          prefixIcon: Image.asset(
                            "img/tujuan.png", scale: 3.0,
                          ),
                          hintText: "Lokasi Tujuan",
                          fillColor: Colors.white70),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10.0,
                // color: Color.fromRGBO(0, 0, 0, 0),
              ),
              buildSearch()
            ],
          ),
        ),
      ],
    );
  }

// map background
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

  List<String> lokasiSuggestions = ["Fasilkom, Indralaya", "FKIP, Indralaya"];

  Widget buildSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 0)],
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Column(
        children: [
          // SizedBox(),
          // lokasi saat ini, pilih dari maps
          Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("img/location.png"),
                        Text("Lokasi saat ini")
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("img/maps.png"),
                        Text("Pilih dari Maps")
                      ],
                    ),
                  ),
                )),
                // Text("data")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            height: 145,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                const border = BorderSide(
                  color: Color(0xFFD4D8D6),
                );
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("tapped");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: (index == 0) ? border : BorderSide.none,
                          bottom: border,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Text(lokasiSuggestions[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
            buildMapBackground(),
            // bar atas
            buildTopBar(),

            // Search
            // buildSearch(),

            // bottom bar
            // conditionalBuildBottomBar(),
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

  // Widget conditionalBuildBottomBar() {
  //   // print("lokasi tujuan : ${focusNodeLokasiTujuan.hasPrimaryFocus}");
  //   // print("lokasi jemput : ${focusNodeTitikJemput.hasPrimaryFocus}");
  //   return !focusNodeLokasiTujuan.hasFocus && !focusNodeTitikJemput.hasFocus
  //       ? Align(
  //           alignment: Alignment.bottomCenter,
  //           child: buildBottomBar(),
  //         )
  //       : const SizedBox();
  // }
}
