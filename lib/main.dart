import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:web_admin/page/navigate_home/Comparable/comparable_new/add_comparable_new_page.dart';

import 'package:web_admin/screen/Property/Chat/provider/firebase_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

import 'Auth/login.dart';

List list = [];
// String? district_id;
// String? cummune_id;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAEHE_tC8re0HgCUv5G-csJO6uX4z1jYB8',
          appId: '1:390050660817:web:eea1fd0da594d7661f20f0',
          messagingSenderId: '390050660817',
          projectId: 'verbalapprovel',
          databaseURL: "https://verbalapprovel.firebaseio.com",
        ),
      ).then((value) => print('OKOK'));
      // print("Firebase initialized successfully");
    }
  } catch (e) {
    // print("Firebase initialization failed: $e");
  }
  WebViewPlatform.instance = WebWebViewPlatform();
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // await OneSignal.shared.setAppId("d3025f03-32f5-444a-8100-7f7637a7f631");
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   print("Accepted permission: $accepted");
  // });

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get i => null;
  String idUser = '';
  String iD = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String? bankname;
    return ChangeNotifierProvider(
      create: (_) => FirebaseProvider(),
      child: GetMaterialApp(
        // initialRoute: '/Admin',
        debugShowCheckedModeBanner: false,
        // home: AddProperty(idUserController: "59"),
        // home: ZoneMap(),
<<<<<<< HEAD
        home: LoginPage(),
=======
        // home: LoginPage(),
>>>>>>> 3eb28eb703dca609e7065058f8810aba3c9d830b
        // home: BannerUpdateExample(bannerId: '31'),
        //home: GetOneDataPage(id: '31'),
        // home: UploadImagePage(),
        // home: AddComparable(
        //     type: (value) {},
        //     addNew: (value) {},
        //     listlocalhosts: const [
        //       {
        //         "id": 52,
        //         "user_role_id": 59,
        //         "agency": 70,
        //         "username": "Test",
        //         "password": "333802e987dfce42e28b749a20dc257f",
        //         "user_status": 0
        //       }
        //     ]),
      ),
    );
  }
}
