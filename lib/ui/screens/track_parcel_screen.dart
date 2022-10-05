import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:vertical_stepper/vertical_stepper.dart';
// import 'package:vertical_stepper/vertical_stepper.dart' as step;
import 'package:cargo_app/models/SingleModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cargo_app/constants/constants.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;

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
  int _currentStep = 0;
  bool _isVerticalStepper = true;

  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  _stepContinue() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  String packageName = "";
  String pickUpLocation = "";
  String dropOfocation = "";
  String receiverName = "";
  String receiverEmail = "";
  String addedAt = "";
  String status = "";
  String lastUpdate = "";

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

  Future getPackage() async {
    var _url =
        Uri.parse(constants[0].url + 'package/' + trackFieldController.text);
    final response = await http.get(_url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        packageName = data['package_name'];
        pickUpLocation = data['pick_up_location'];
        dropOfocation = data['delivery_location'];
        addedAt = data['created_at'];
        receiverName = data['receiver_name'];
        receiverEmail = data['receiver_email'];
        status = data['package_status'];
        lastUpdate = data['${data['package_status']}'];
        result = true;
      });
    } else {
      Get.snackbar('Error  ', 'Package Not Found');
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String transits = '';
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
                    padding: EdgeInsets.only(top: 30.0),
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
            padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
            child: Row(children: [
              Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.height / 3,
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
                      getPackage();
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
                // ignore: prefer_literals_to_create_immutables
                children: const [
                  Text("Result :", style: TextStyle(fontSize: 25)),
                  Spacer(),
                  Icon(Icons.close, size: 25)
                ],
              ),
            )
          : const SizedBox(),
      const SizedBox(height: 5),
      result
          ? Column(
              children: [
                Stepper(
                  // vertical or horizontial
                  type: _isVerticalStepper
                      ? StepperType.vertical
                      : StepperType.horizontal,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => _stepTapped(step),
                  onStepContinue: _stepContinue,
                  onStepCancel: _stepCancel,
                  steps: [
                    // The first step: Name
                    Step(
                      title: const Text('Details'),
                      content: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'PackageName:',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                packageName,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Pick Up:',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                pickUpLocation,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Drop Off:',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                dropOfocation,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'Receiver Email:',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                receiverEmail,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Receiver Name:',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                receiverName,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Added:',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                timeago.format(DateTime.parse(addedAt)),
                                // 'Last update: 3 hours ago',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    // The second step: Phone number
                    Step(
                      title: const Text('Status'),
                      content: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('Your Package status is:'),
                              Text('${status}'),
                            ],
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ],
            )
          : Lottie.network(
              "https://assets2.lottiefiles.com/packages/lf20_t24tpvcu.json"),
    ]);
  }
}
