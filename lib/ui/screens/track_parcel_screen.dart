import 'package:flutter/material.dart';
import 'package:cargo_app/ui/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cargo_app/ui/screens/screens.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cargo_app/models/packagesModel.dart';
import 'package:cargo_app/constants/constants.dart';
import 'package:cargo_app/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({Key? key}) : super(key: key);

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: content());
  }

  Widget content() {
    return Column(
      children: [
        Container(
            height: 300,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(children: [
                      Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT6Yc_N3xC9akfMD4yRs9kwCBKoaRrie9z-Rg&usqp=CAU",
                          height: 200),
                      const Text("Parcel Tracker",
                          style: TextStyle(fontSize: 30))
                    ])))),
        body()
      ],
    );
  }

  Widget body() {
    // ignore: prefer_const_literals_to_create_immutables
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 50),
      const Padding(
          padding: EdgeInsets.only(left: 35.0),
          child: Text("Tracking Number", style: TextStyle(fontSize: 16))),
      const SizedBox(height: 10),
      Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
          child: Row(children: [
            Container(
                height: 60,
                width: 310,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "eg 127266262255"),
                )),
            const SizedBox(
              width: 30,
            ),
            const Icon(Icons.search, size: 35)
          ])),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(35, 2, 31, 0),
        child: Row(
          children: [
            const Text("Result :", style: TextStyle(fontSize: 25)),
            Spacer(),
            const Icon(Icons.close, size: 25)
          ],
        ),
      ),
      const SizedBox(height: 5)
    ]);
  }
}
