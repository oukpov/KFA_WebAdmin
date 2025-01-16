import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:web_admin/page/homescreen/newhomepage.dart';
import 'package:web_admin/page/homescreen/responsive_layout.dart';
import 'package:web_admin/page/navigate_home/UI_APP/app_UI.dart';
=======
import 'package:web_admin/page/homescreen/UI_APP/app_UI.dart';
>>>>>>> 1b6784fff1289e9abe5e4f08e1ed87abcbd0ab32
import 'package:web_admin/page/navigate_home/AutoVerbal/Zone/add_zone.dart';
import 'package:web_admin/page/navigate_home/AutoVerbal/input_road/InputRoad.dart';
import 'package:web_admin/page/navigate_setting/auto/auto_list.dart';
import 'package:web_admin/page/navigate_home/Report/page/history_v_point_page.dart';
import 'package:web_admin/page/navigate_home/Report/page/userlist_page.dart';
import 'package:web_admin/page/navigate_home/Report/page/v_point_list_page.dart';
import 'package:web_admin/screen/Property/Chat/provider/firebase_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

import 'Auth/login.dart';
import 'Widgets/date_range.dart';
// import 'Auth/login.dart';

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
        // home: ZoneMap(listLocalHost: [
        //   {
        //     "id": 328,
        //     "control_user": "202492386253",
        //     "OTP_Code": null,
        //     "first_name": null,
        //     "last_name": null,
        //     "username": null,
        //     "gender": null,
        //     "tel_num": "010406807",
        //     "known_from": null,
        //     "email": null,
        //     "email_verified_at": null,
        //     "password": null,
        //     "remember_token": null,
        //     "deleted": 0,
        //     "created_at": null,
        //     "updated_at": null,
        //     "update_new": 0,
        //     "Image": null
        //   },
        // ]),
<<<<<<< HEAD

        // home: ResponsiveHomePage(
        //     // device: "d",
        //     id: "52",
        //     listUser: [
        //       {
        //         "id": 52,
        //         "user_role_id": 59,
        //         "agency": 70,
        //         "username": "Test",
        //         "password": "333802e987dfce42e28b749a20dc257f",
        //         "user_status": 0
        //       }
        //     ],
        //     url: ""),
        home: LoginPage(),
=======
>>>>>>> 1b6784fff1289e9abe5e4f08e1ed87abcbd0ab32
        // home: InputRoad(
        //   listUsers: [
        //     {
        //       "id": 52,
        //       "user_role_id": 59,
        //       "agency": 70,
        //       "username": "Test",
        //       "password": "333802e987dfce42e28b749a20dc257f",
        //       "user_status": 0
        //     }
        //   ],
        // ),
<<<<<<< HEAD

        // home: LoginPage(),
        // home: UIAPP(device: "m"),

=======
        home: LoginPage(),
>>>>>>> 1b6784fff1289e9abe5e4f08e1ed87abcbd0ab32
        // home: InputRoad(
        //   listUsers: [
        //     {
        //       "id": 52,
        //       "user_role_id": 59,
        //       "agency": 70,
        //       "username": "Test",
        //       "password": "333802e987dfce42e28b749a20dc257f",
        //       "user_status": 0
        //     }
        //   ],
        // ),

        // home: AutoList()
        //home: HistoryVPointPage(),
        // home: MapScreen(),
        //home: TestPage(),
        //home: UserListPage(id: '61'),
        // home: ZoneMap(listLocalHost: [
        //   {
        //     "id": 52,
        //     "user_role_id": 59,
        //     "agency": 70,
        //     "username": "Test",
        //     "password": "333802e987dfce42e28b749a20dc257f",
        //     "user_status": 0
        //   }
        // ]),

        //home: AboutUsImageEditPage(),
        // home: MyFormTTTT(),
        // home: SaveImageVerbalAgent(
        //   check: false,
        //   listUser: const [
        //     {
        //       "id": 52,
        //       "user_role_id": 59,
        //       "agency": 70,
        //       "username": "Test",
        //       "password": "333802e987dfce42e28b749a20dc257f",
        //       "user_status": 0
        //     }
        //   ],
        //   type: (value) {
        //     setState(() {
        //       // widget.type(value);
        //     });
        //   },
        //   list: const [
        //     {
        //       "verbal_id": "20328575",
        //       "verbal_code": "708291",
        //       "title_deedN": "1801030101-1460",
        //       "under_property_right": null,
        //       "referrenceN": "ARF24 - 123123",
        //       "land_size": "1123132",
        //       "building_size": "100",
        //       "issued_date": "2024-1-1",
        //       "verbal_property_id": "15",
        //       "verbal_owner": null,
        //       "verbal_contact": null,
        //       "verbal_date": null,
        //       "receivedate": null,
        //       "verbal_address":
        //           "Phnom Penh, Khan Chamkar Mon, Sangkat Tonle Basak",
        //       "verbal_comment": null,
        //       "latlong_log": "104.9348164",
        //       "latlong_la": "11.5433880",
        //       "verbal_user": "70",
        //       "verbal_created_date": "2024-11-07 00:38:45"
        //     },
        //   ],
        //   i: 0,
        //   verbalId: "1111",
        // ),
        // home: VerbalList(
        //   listUser: [
        //     {
        //       "id": 52,
        //       "user_role_id": 59,
        //       "agency": 70,
        //       "username": "Test",
        //       "password": "333802e987dfce42e28b749a20dc257f",
        //       "user_status": 0
        //     }
        //   ],
        // ),
        // home: VerbalAgent(
        //   type: (value) {},
        //   listUser: const [
        //     {
        //       "id": 52,
        //       "user_role_id": 59,
        //       "agency": 70,
        //       "username": "Test",
        //       "password": "333802e987dfce42e28b749a20dc257f",
        //       "user_status": 0
        //     }
        //   ],
        //   addNew: (value) {},
        // ),
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

        // ),
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 600,
        height: 200,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 600,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                child: SimpleDateRangePicker(
                  onDateRangeSelected:
                      (DateTime? startDate, DateTime? endDate) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
