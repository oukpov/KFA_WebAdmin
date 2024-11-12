// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, deprecated_member_use, camel_case_types, prefer_typing_uninitialized_variables, await_only_futures

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:web_admin/page/navigate_home/Report/page/social_media_edition_page.dart';
import '../../../../components/colors.dart';
import '../../../../controller/contact_us_controller.dart';
import '../../../../controller/social_media_controller.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final ContactUsController _contactUsController =
      Get.put(ContactUsController());
  final SocialMediaController _socialMediaController =
      Get.put(SocialMediaController());
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _mapUrlController = TextEditingController();
  final TextEditingController _hotlinePrimaryController =
      TextEditingController();
  final TextEditingController _hotlineSecondaryController =
      TextEditingController();
  final TextEditingController _hotlineThirdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }

  void _showUpdateDialog() {
    if (_contactUsController.contactUsData.value.data != null &&
        _contactUsController.contactUsData.value.data!.isNotEmpty) {
      var contactData = _contactUsController.contactUsData.value.data![0];

      // Pre-fill controllers with existing data
      _addressLine1Controller.text = contactData.addressLine1 ?? '';
      _addressLine2Controller.text = contactData.addressLine2 ?? '';
      _cityController.text = contactData.city ?? '';
      _stateController.text = contactData.state ?? '';
      _postalCodeController.text = contactData.postalCode ?? '';
      _countryController.text = contactData.country ?? '';
      _latitudeController.text = contactData.latitude ?? '';
      _longitudeController.text = contactData.longitude ?? '';
      _mapUrlController.text = contactData.mapUrl ?? '';
      _hotlinePrimaryController.text = contactData.hotlinePrimary ?? '';
      _hotlineSecondaryController.text = contactData.hotlineSecondary ?? '';
      _hotlineThirdController.text = contactData.hotlineThird ?? '';
      _emailController.text = contactData.email ?? '';

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Update Contact Information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _addressLine1Controller,
                  decoration: InputDecoration(labelText: 'Address Line 1'),
                ),
                TextField(
                  controller: _addressLine2Controller,
                  decoration: InputDecoration(labelText: 'Address Line 2'),
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: _stateController,
                  decoration: InputDecoration(labelText: 'State'),
                ),
                TextField(
                  controller: _postalCodeController,
                  decoration: InputDecoration(labelText: 'Postal Code'),
                ),
                TextField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                ),
                TextField(
                  controller: _latitudeController,
                  decoration: InputDecoration(labelText: 'Latitude'),
                ),
                TextField(
                  controller: _longitudeController,
                  decoration: InputDecoration(labelText: 'Longitude'),
                ),
                TextField(
                  controller: _mapUrlController,
                  decoration:
                      InputDecoration(labelText: 'Get Direction in Map'),
                ),
                TextField(
                  controller: _hotlinePrimaryController,
                  decoration: InputDecoration(labelText: 'Primary Hotline'),
                ),
                TextField(
                  controller: _hotlineSecondaryController,
                  decoration: InputDecoration(labelText: 'Secondary Hotline'),
                ),
                TextField(
                  controller: _hotlineThirdController,
                  decoration: InputDecoration(labelText: 'Third Hotline'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _contactUsController.updateContactUs(
                    addressLine1: _addressLine1Controller.text,
                    addressLine2: _addressLine2Controller.text,
                    city: _cityController.text,
                    state: _stateController.text,
                    postalCode: _postalCodeController.text,
                    country: _countryController.text,
                    latitude: _latitudeController.text,
                    longitude: _longitudeController.text,
                    mapUrl: _mapUrlController.text,
                    hotlinePrimary: _hotlinePrimaryController.text,
                    hotlineSecondary: _hotlineSecondaryController.text,
                    hotlineThird: _hotlineThirdController.text,
                    email: _emailController.text,
                  );
                  Navigator.pop(context);

                  // Refresh the page with new data
                  await _contactUsController.getContactUs();
                  setState(() {
                    // Clear markers and recreate with new data
                    _markers.clear();
                    if (_contactUsController.contactUsData.value.data != null &&
                        _contactUsController
                            .contactUsData.value.data!.isNotEmpty) {
                      var contactData =
                          _contactUsController.contactUsData.value.data![0];
                      _markers.add(
                        Marker(
                          markerId: MarkerId('id-1'),
                          position: LatLng(
                              double.parse(contactData.latitude ?? "11.518936"),
                              double.parse(
                                  contactData.longitude ?? "104.934026")),
                          icon: mapMarker,
                          infoWindow: InfoWindow(
                            title: "Khmer Foundation Appraisal Co., Ltd",
                            snippet: "Real estate agent",
                          ),
                        ),
                      );
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Contact information updated successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Failed to update contact information')),
                  );
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      );
    }
  }

  final Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.defaultMarker;
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      if (_contactUsController.contactUsData.value.data != null &&
          _contactUsController.contactUsData.value.data!.isNotEmpty) {
        var contactData = _contactUsController.contactUsData.value.data![0];
        _markers.add(
          Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(double.parse(contactData.latitude ?? "11.518936"),
                double.parse(contactData.longitude ?? "104.934026")),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: "Khmer Foundation Appraisal Co., Ltd",
              snippet: "Real estate agent",
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(235, 7, 9, 145),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(235, 7, 9, 145),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _showUpdateDialog,
          ),
        ],
        toolbarHeight: 70,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
          ),
        ),
        child: Obx(() {
          if (_contactUsController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final contactData =
              _contactUsController.contactUsData.value.data != null &&
                      _contactUsController.contactUsData.value.data!.isNotEmpty
                  ? _contactUsController.contactUsData.value.data![0]
                  : null;
          if (contactData == null) {
            return Center(child: Text('No contact information available'));
          }

          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: double.infinity,
              ),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kBackgroundColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "KFA Head Office",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop_sharp,
                              color: kImageColor,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Location:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${contactData.addressLine1 ?? ''} ${contactData.addressLine2 ?? ''}, ${contactData.city ?? ''}, ${contactData.state ?? ''}, ${contactData.country ?? ''}',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 200,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: Colors.lightBlue),
                          ),
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            markers: _markers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  double.parse(
                                      contactData.latitude ?? "11.518936"),
                                  double.parse(
                                      contactData.longitude ?? "104.934026")),
                              zoom: 18,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            top: 10,
                            right: 40,
                            left: 40,
                            bottom: 10,
                          ),
                          child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.directions, color: Colors.white),
                                SizedBox(width: 10),
                                Text('Get Direction in Map'),
                              ],
                            ),
                            onPressed: () async {
                              final mapUrl = contactData.mapUrl ?? '';
                              if (await canLaunch(mapUrl)) {
                                await launch(
                                  mapUrl,
                                  forceSafariVC: false,
                                  forceWebView: false,
                                );
                              }
                            },
                          ),
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 0.5,
                        ),
                        Text(
                          "Hotlines:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (contactData.hotlinePrimary != null)
                          Hotline(
                            onPress: () => _makePhoneCall(
                                'tel:${contactData.hotlinePrimary}'),
                            icon: Icons.phone,
                            phone: '${contactData.hotlinePrimary}',
                          ),
                        if (contactData.hotlineSecondary != null)
                          Hotline(
                            onPress: () => _makePhoneCall(
                                'tel:${contactData.hotlineSecondary}'),
                            icon: Icons.phone,
                            phone: '${contactData.hotlineSecondary}',
                          ),
                        if (contactData.hotlineThird != null)
                          Hotline(
                            onPress: () => _makePhoneCall(
                                'tel:${contactData.hotlineThird}'),
                            icon: Icons.phone,
                            phone: '${contactData.hotlineThird}',
                          ),
                        if (contactData.email != null)
                          Hotline(
                            onPress: () =>
                                launch('mailto:${contactData.email}'),
                            icon: Icons.email,
                            phone: contactData.email!,
                          ),
                        SizedBox(height: 15),
                        Divider(
                          color: Colors.black12,
                          thickness: 0.5,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Find out more about KFA:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Obx(() {
                          if (_socialMediaController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          }

                          final socialMediaData =
                              _socialMediaController.socialMediaData.value;
                          if (socialMediaData.data == null ||
                              socialMediaData.data!.isEmpty) {
                            return Center(
                                child: Text('No social media links available'));
                          }

                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...socialMediaData.data!.map((media) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (media.platform != null &&
                                          media.platform!.isNotEmpty) {
                                        if (await canLaunch(media.platform!)) {
                                          await launch(media.platform!);
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black12,
                                      ),
                                      padding: EdgeInsets.all(2),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      child: ClipOval(
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            imageUrl: media.url ?? '',
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                IconButton(
                                  onPressed: () {
                                    Get.to(() => SocialMediaEditionPage());
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class appIcons extends StatelessWidget {
  final String img;
  final press;
  const appIcons({
    Key? key,
    required this.img,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: press,
          icon: Image.network(img),
          iconSize: 40,
        )
      ],
    );
  }
}

class Hotline extends StatelessWidget {
  final String phone;
  final icon;
  final onPress;
  const Hotline({
    Key? key,
    required this.phone,
    this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
          side: BorderSide(color: Colors.black12, width: 0.5),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 10),
            Text(phone),
          ],
        ),
      ),
    );
  }
}
