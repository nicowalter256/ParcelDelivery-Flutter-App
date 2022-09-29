import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vertical_stepper/vertical_stepper.dart';
import 'package:vertical_stepper/vertical_stepper.dart' as step;
import 'package:cargo_app/models/SingleModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cargo_app/constants/constants.dart';
import 'dart:convert';

class TrackScreen extends StatefulWidget {
  const TrackScreen({Key? key}) : super(key: key);

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen>
    with TickerProviderStateMixin {
  final TextEditingController trackFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool result = false;

  String tokens = "";

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token")!;
    });
  }

  var trackDetails = "";

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      };

  Future getPackage(String package) async {
    var _url = Uri.parse(constants[0].url + 'package/' + package);
    final response = await http.get(_url, headers: headers);
    setState(() {
      trackDetails = json.decode(response.body);
      result = true;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<step.Step> steps = [
    const step.Step(
        shimmer: false,
        title: "Package Added",
        iconStyle: Colors.blue,
        content: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('2022/09/56 11:15 am Package Created')),
        )),
    const step.Step(
        shimmer: false,
        title: "Package Rejected",
        iconStyle: Colors.red,
        content: Align(
            alignment: Alignment.centerLeft,
            child: Text('2022/09/56 11:15 am  In Transit'))),
    const step.Step(
        shimmer: false,
        title: "Package In transit",
        iconStyle: Colors.yellow,
        content: Align(
            alignment: Alignment.centerLeft,
            child: Text('2022/09/56 11:15 am  In Transit'))),
    const step.Step(
        shimmer: false,
        title: "Package Delivered",
        iconStyle: Colors.green,
        content: Align(
            alignment: Alignment.centerLeft,
            child: Text('2022/09/56 11:15 am  Package Delivered')))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: content()));
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
      Form(
        key: _formKey,
        child: Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
            child: Row(children: [
              Container(
                height: 60,
                width: 310,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: TextFormField(
                  controller: trackFieldController,
                  onSaved: (value) {
                    trackFieldController.text = value!;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Parcel No is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      getPackage("32831662784176");
                    }
                  },
                  child: const Icon(Icons.search, size: 35))
            ])),
      ),
      const SizedBox(
        height: 20,
      ),
      result
          ? Padding(
              padding: const EdgeInsets.fromLTRB(35, 2, 31, 0),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("Result :", style: TextStyle(fontSize: 25)),
                  const Spacer(),
                  const Icon(Icons.close, size: 25)
                ],
              ),
            )
          : const SizedBox(),
      const SizedBox(height: 5),
      result
          ? Padding(
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
              child: VerticalStepper(
                steps: steps,
                dashLength: 2,
              ),
            )
          : Lottie.network(
              "https://assets2.lottiefiles.com/packages/lf20_t24tpvcu.json"),
    ]);
  }
}
