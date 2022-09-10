import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cargo_app/pages/login_page.dart';
import 'package:cargo_app/pages/agentLogin.dart';

class ChooseUser extends StatefulWidget {
  const ChooseUser({Key? key}) : super(key: key);

  @override
  State<ChooseUser> createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5ca6c3), Color(0xFFBD3C9B)],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => const AgentLoginPage(),
                    fullscreenDialog: true,
                    transition: Transition.zoom,
                    duration: const Duration(microseconds: 500000));
              },
              child: Container(
                  margin: EdgeInsets.all(30),
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text("Agent",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                  ) // This trailing comma makes auto-formatting nicer for build methods.
                  ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const LoginPage(),
                    fullscreenDialog: true,
                    transition: Transition.zoom,
                    duration: const Duration(microseconds: 500000));
              },
              child: Container(
                  margin: EdgeInsets.all(30),
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text("Sender",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                  ) // This trailing comma makes auto-formatting nicer for build methods.
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
