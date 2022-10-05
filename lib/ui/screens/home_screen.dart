import 'package:flutter/material.dart';
import 'package:cargo_app/ui/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cargo_app/ui/screens/screens.dart';
import 'package:cargo_app/ui/screens/track_parcel_screen.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cargo_app/models/packagesModel.dart';
import 'package:cargo_app/constants/constants.dart';
import 'package:cargo_app/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String tokens = "";

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token")!;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      };

  Future<Packages> getPackages() async {
    var _url = Uri.parse(constants[0].url + 'packages');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    return packagesFromJson(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              child: Text(
                'parcels',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            centerTitle: false,
            floating: true,
            snap: false,
            pinned: true,
            titleSpacing: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(ProfilePage());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(''),
                    ),
                  ),
                ),
              ),
            ],
            shadowColor: Colors.transparent,
            expandedHeight: 426,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 64,
                      ),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 48,
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(
                                    const TrackScreen(),
                                  );
                                },
                                child: Text(
                                  'Track parcel',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                style: Theme.of(context).textButtonTheme.style,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(
              top: 32,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My parcels',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              )
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              FutureBuilder<Packages>(
                future: getPackages(),
                builder: (context, snapshot) {
                  final _data = snapshot.data?.data;
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: _data?.length,
                          itemBuilder: (context, index) {
                            final packageData = _data![index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(const SendParcelCheckoutScreen(),
                                    arguments: [
                                      packageData.packageName,
                                      packageData.receiverContact,
                                      packageData.receiverEmail,
                                      packageData.deliveryLocation,
                                      packageData.amountToPay,
                                      packageData.receiverName,
                                      packageData.description,
                                    ]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                child: Container(
                                  height: 174,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context).backgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            packageData.id.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          Container(
                                            height: 31,
                                            width: 78,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbJCkPE9sdc24J-hB1suNnK1ImSmfrE8BBRA&usqp=CAU'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            packageData.packageStatus,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            timeago
                                                .format(packageData.updatedAt),
                                            // 'Last update: 3 hours ago',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SizedBox(
                                            height: 5,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: LinearProgressIndicator(
                                                value: 0.7,
                                                color: Theme.of(context)
                                                    .appBarTheme
                                                    .backgroundColor,
                                                backgroundColor:
                                                    const Color(0xFFF8F8F8),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Details',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                ),
                                                SvgPicture.asset(
                                                    'assets/images/icon_details.svg')
                                              ],
                                            ),
                                            Container(
                                              height: 1,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
