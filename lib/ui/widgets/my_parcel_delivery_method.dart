import 'package:flutter/material.dart';
import 'package:cargo_app/common/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'package:cargo_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:cargo_app/ui/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyParcelDeliveryMethod extends StatefulWidget {
  const MyParcelDeliveryMethod(
      {Key? key,
      required this.parcelDeliveryMethod,
      required this.parcelDeliveryDuration,
      required this.parcelDeliveryImage})
      : super(key: key);

  final String parcelDeliveryMethod,
      parcelDeliveryDuration,
      parcelDeliveryImage;

  @override
  _MyParcelDeliveryMethodState createState() => _MyParcelDeliveryMethodState();
}

class _MyParcelDeliveryMethodState extends State<MyParcelDeliveryMethod> {
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

  bool _isLoading = false;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController packagenameController = TextEditingController();

  Map<String, String> get headers => {
        "Authorization": "Bearer $tokens",
      };

  Future addParcel() async {
    setState(() {
      _isLoading = true;
    });
    var _url = Uri.parse(constants[0].url + 'packages');
    final response = await http.post(_url,
        body: {
          'package_name': packagenameController.text,
          'receiver_name': userNameController.text,
          'receiver_email': emailController.text,
          'receiver_contact': contactController.text,
          'delivery_location': deliveryController.text,
          'pick_up_location': pickupController.text,
        },
        headers: headers);
    final String responseData = response.body;
    if (response.statusCode == 200) {
      Get.to(() => const HomeScreen(),
          fullscreenDialog: true,
          transition: Transition.zoom,
          duration: const Duration(microseconds: 500000));
      Get.snackbar('success', 'Parcel Added');
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      Get.snackbar('Error  ', 'Network Error');
    }

    return responseData;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              'Recipient Info',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: packagenameController,
              onSaved: (value) {
                packagenameController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Package Name is required';
                }
                return null;
              },
              decoration: ThemeHelper().textInputDecoration(
                  'Package Name', 'Enter your package name'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: userNameController,
              onSaved: (value) {
                userNameController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Recipient Name is required';
                }
                return null;
              },
              decoration: ThemeHelper().textInputDecoration(
                  'Recipient Name', 'Enter your recipient name'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: emailController,
              onSaved: (value) {
                emailController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Recipient Email is required';
                }
                return null;
              },
              decoration: ThemeHelper().textInputDecoration(
                  'Recipient Email', 'Enter your recipient email'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: contactController,
              onSaved: (value) {
                contactController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Recipient Contact is required';
                }
                return null;
              },
              decoration: ThemeHelper().textInputDecoration(
                  'Recipient Contact', 'Enter your recipient contact'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: pickupController,
              onSaved: (value) {
                pickupController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Pick Up Address is required';
                }
                return null;
              },
              decoration: ThemeHelper().textInputDecoration(
                  'Pick Up Address', 'Enter pick up address'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: deliveryController,
              onSaved: (value) {
                deliveryController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Delivery Address is required';
                }
                return null;
              },
              decoration: ThemeHelper().textInputDecoration(
                  'Delivery Address', 'Enter delivery address'),
            ),
            const SizedBox(
              height: 16,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addParcel();
                        }
                      },
                      child: Text(
                        'Add Parcel',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      style: Theme.of(context).textButtonTheme.style,
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionChildren(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            'Recipient Info',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Name',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextField(
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Email',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextField(
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Phone number',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextField(
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Address',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextField(
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
