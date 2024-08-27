import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_admin/screen/Property/Chat/provider/firebase_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:http/http.dart' as http;
import 'Auth/login.dart';
import 'interface/homescreen/responsive_layout.dart';
import 'interface/navigate_home/Add/googlemap_verbal.dart';

List list = [];
void main() async {
  WebViewPlatform.instance = WebWebViewPlatform();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBYr3tPsGjHtaDSSrAV5zH0HN0tMHqxRho',
        appId: '1:840429343818:web:63757f2574274bf9c3c2b3',
        messagingSenderId: '840429343818',
        projectId: 'chatappflutter-41d6b',
      ),
    );
  }
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
    return ChangeNotifierProvider(
      create: (_) => FirebaseProvider(),
      child: GetMaterialApp(
        initialRoute: '/Admin',
        debugShowCheckedModeBanner: false,
        routes: {
          // "/Admin": (context) => const LoginPage()
          "/Admin": (p0) => VerbalAdmin(
                  addNew: (value) {},
                  type: (value) {},
                  listUser: const [
                    {
                      "id": 65,
                      "user_role_id": 53,
                      "agency": 83,
                      "username": "somnang.se",
                      "password": "9e6981b5813c4da23404c2a3e0f95e81",
                      "user_status": 0
                    }
                  ]),
          // '/Admin': (context) => const ResponsiveHomePage(
          //       listUser: [],
          //       url: '',
          //       password: '',
          //       controllerUser: '',
          //       setEmail: '',
          //       setPassword: '',
          //       user: '',
          //       email: '',
          //       firstName: '',
          //       lastName: '',
          //       gender: '',
          //       from: '',
          //       tel: '',
          //       id: '',
          //     ),
        },
        onGenerateRoute: (RouteSettings settings) {
          final args = settings.name;

          if (args != null) {
            var data = settings.name!.split('/');
            var value = data[1].toString();
            return MaterialPageRoute(
              builder: (context) {
                return koko(
                  name: value.toString(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Routes {
  static const String home = "home";
  static const String faverite = "style";
  static const String post = "post";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}

class koko extends StatefulWidget {
  const koko({super.key, required this.name});
  final String name;

  @override
  State<koko> createState() => _kokoState();
}

class _kokoState extends State<koko> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // body: detail_verbal(set_data_verbal: widget.name.toString()),
        // body: Home_Screen_property(),
        );
  }

  void getallautoverbalbyid() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=${widget.name.toString()}'));

    if (rs.statusCode == 200) {
      setState(() {
        list = jsonDecode(rs.body);
      });
    }
  }

  @override
  void initState() {
    getallautoverbalbyid();
    list;
    super.initState();
    // fillInEmail();
    // fillInPassword();
  }
}
