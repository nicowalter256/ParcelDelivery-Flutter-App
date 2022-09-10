import 'package:flutter/material.dart';
import 'package:cargo_app/ui/widgets/my_parcel_delivery_method.dart';

class SendParcelDetailScreen extends StatefulWidget {
  const SendParcelDetailScreen({Key? key}) : super(key: key);

  @override
  _SendParcelDetailScreenState createState() => _SendParcelDetailScreenState();
}

class _SendParcelDetailScreenState extends State<SendParcelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Parcel'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: ListView(
            children: [
              Text(
                'Send parcel',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 17,
              ),
              const MyParcelDeliveryMethod(
                parcelDeliveryMethod: 'From door to parcel center',
                parcelDeliveryDuration: '1 - 2 days',
                parcelDeliveryImage: 'assets/images/img_door_to_parcel.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
