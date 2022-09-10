import 'package:flutter/material.dart';
import 'package:cargo_app/ui/widgets/my_parcel_office.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/src/locations.dart' as locations;
import 'package:cargo_app/models/packageCentersModel.dart';
import 'package:cargo_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ParcelCenterScreen extends StatefulWidget {
  const ParcelCenterScreen({Key? key}) : super(key: key);

  @override
  _ParcelCenterScreenState createState() => _ParcelCenterScreenState();
}

class _ParcelCenterScreenState extends State<ParcelCenterScreen> {
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

  Future<PackageCenters> getPackageCenters() async {
    var _url = Uri.parse(constants[0].url + 'packageCenters');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    print(responseData);
    return packageCentersFromJson(responseData);
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();

    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(24, 24),
        ),
        'assets/images/icon_marker.png');

    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          icon: customIcon,
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverPadding(
            padding: EdgeInsets.only(
              top: 132,
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
                      'Parcels Centers',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              )
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              GestureDetector(
                  child: FutureBuilder<PackageCenters>(
                future: getPackageCenters(),
                builder: (context, snapshot) {
                  final _data = snapshot.data?.data;
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: _data?.length,
                          itemBuilder: (context, index) {
                            final packageData = _data![index];
                            return MyParcelOffice(
                              parcelOfficeCode: packageData.centerCode,
                              parcelOfficeName: packageData.centerName,
                              parcelOfficeAddress: packageData.address,
                              parcelOfficeHours: 'Available 24/7',
                              parcelOfficeStats: 'Lots of empty space',
                              parcelOfficeStatsNumber: '0.3',
                            );
                          }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
            ]),
          ),
        ],
      ),
    );
  }
}
