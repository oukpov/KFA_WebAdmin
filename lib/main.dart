import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:web_admin/Auth/login.dart';
<<<<<<< HEAD
import 'package:web_admin/page/verbal_report_page.dart';
=======
import 'package:web_admin/page/navigate_home/Approvel/classSubmit.dart';
<<<<<<< HEAD
import 'package:web_admin/page/navigate_home/Comparable/comparable_new/add_comparable_new_page.dart';
=======
>>>>>>> e9255aabe7ed6c6b621de32a016e4cad8f600d7a
>>>>>>> 9125dfbee864687366d89b9e442fae258a0c906d
import 'package:web_admin/screen/Property/Chat/provider/firebase_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:http/http.dart' as http;

import 'page/navigate_home/Comparable/newComparable/add_new_comparable.dart';

List list = [];
// String? district_id;
// String? cummune_id;
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
    // String? bankname;
    return ChangeNotifierProvider(
      create: (_) => FirebaseProvider(),
      child: GetMaterialApp(
        // initialRoute: '/Admin',
        debugShowCheckedModeBanner: false,
<<<<<<< HEAD
        //home: LoginPage(),
        home: VerbalReportPage(),
=======
        home: LoginPage(),
        // home: AddComparable(
        //     type: (value) {},
        //     addNew: (value) {},
        //     listlocalhosts: const [
        //       {
        //         "id": 52,
        //         "user_role_id": 53,
        //         "agency": 70,
        //         "username": "Test",
        //         "password": "333802e987dfce42e28b749a20dc257f",
        //         "user_status": 0
        //       }
        //     ]),
        // home: ClassSubmit(device: "d", listUser: [
        //   {
        //     "id": 52,
        //     "user_role_id": 53,
        //     "agency": 70,
        //     "username": "Test",
        //     "password": "333802e987dfce42e28b749a20dc257f",
        //     "user_status": 0
        //   }
        // ]),
>>>>>>> e9255aabe7ed6c6b621de32a016e4cad8f600d7a
        // routes: {
        //   "/Admin": (context) => const LoginPage()
        // "/Admin": (p0) => ClassTest(),

        // "/Admin": (p0) => VerbalAdmin(
        //         addNew: (value) {},
        //         type: (value) {},
        //         listUser: const [
        //           {
        //             "id": 65,
        //             "user_role_id": 53,
        //             "agency": 83,
        //             "username": "somnang.se",
        //             "password": "9e6981b5813c4da23404c2a3e0f95e81",
        //             "user_status": 0
        //           }
        //         ]),
        // '/Admin': (context) => const ResponsiveHomePage(
        //       listUser: [],
        //       url: '',
        //       id: '',
        //     ),
        // },
        // onGenerateRoute: (RouteSettings settings) {
        //   final args = settings.name;

        //   if (args != null) {
        //     var data = settings.name!.split('/');
        //     var value = data[1].toString();
        //     return MaterialPageRoute(
        //       builder: (context) {
        //         return koko(
        //           name: value.toString(),
        //         );
        //       },
        //     );
        //   }
        // },
      ),
    );
  }
}

// class Routes {
//   static const String home = "home";
//   static const String faverite = "style";
//   static const String post = "post";

//   static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
//       {int duration = 300}) {
//     return PageRouteBuilder<T>(
//       settings: settings,
//       transitionDuration: Duration(milliseconds: duration),
//       pageBuilder: (context, animation, secondaryAnimation) => page(context),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeScaleTransition(animation: animation, child: child);
//       },
//     );
//   }
// }

// class koko extends StatefulWidget {
//   const koko({super.key, required this.name});
//   final String name;

//   @override
//   State<koko> createState() => _kokoState();
// }

// class _kokoState extends State<koko> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//         // body: detail_verbal(set_data_verbal: widget.name.toString()),
//         // body: Home_Screen_property(),
//         body: Hometest());
//   }

//   void getallautoverbalbyid() async {
//     var rs = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=${widget.name.toString()}'));

//     if (rs.statusCode == 200) {
//       setState(() {
//         list = jsonDecode(rs.body);
//       });
//     }
//   }

//   @override
//   void initState() {
//     getallautoverbalbyid();
//     list;
//     super.initState();
//     // fillInEmail();
//     // fillInPassword();
//   }
// }

// class Hometest extends StatefulWidget {
//   const Hometest({super.key});

//   @override
//   State<Hometest> createState() => _HometestState();
// }

// class _HometestState extends State<Hometest> {
//   String? provnce_id;
//   String? songkat;
//   String? provice_map;
//   String? customerenddate;
//   String? customerdatetotal;
//   String? khan;
//   String? log;
//   String? lat;
//   DateTime? selectedStartDate;
//   DateTime? selectedEndDate;
//   TextEditingController end_date = TextEditingController();
//   TextEditingController? _log;
//   TextEditingController? _lat;
//   TextEditingController todate = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   @override
//   void initState() {
//     todate.text = "";
//     today_formart();
//     super.initState();
//   }

//   String? formattedDate;
//   void today_formart() {
//     DateTime now = DateTime.now();
//     formattedDate = DateFormat('yyyy-MM-dd').format(now);
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool validateAndSave() {
//     final form = _formKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Chart(
  //         transforms: const [],
  //         changeData: false,
  //         data: const [
  //           {'genre': 'Sports', 'value': 275},
  //           {'genre': 'Strategy', 'value': 115},
  //         ],
  //         variables: {
  //           'genre': Variable(
  //             accessor: (Map map) => map['genre'] as String,
  //           ),
  //           'sold': Variable(
  //             accessor: (Map map) => map['value'] as num,
  //           ),
  //         },
  //         marks: [IntervalMark()],
  //         axes: [
  //           Defaults.horizontalAxis,
  //           Defaults.verticalAxis,
  //         ],
  //       ),
  //       // child: Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: PaginatedDataTable(
  //       //     dataRowHeight: 50, // Set the height of each row
  //       //     //dividerThickness: 2,
  //       //     // Set the thickness of the horizontal divider lines
  //       //     columns: [
  //       //       DataColumn(label: Text('Column 1')),
  //       //       DataColumn(label: Text('Column 2')),
  //       //       // Add more DataColumn widgets if needed
  //       //     ],
  //       //     rows: [
  //       //       DataRow(cells: [
  //       //         DataCell(Text('Row 1, Cell 1')),
  //       //         DataCell(Text('Row 1, Cell 2')),
  //       //         // Add more DataCell widgets if needed
  //       //       ]),
  //       //       // Add more DataRow widgets if needed
  //       //     ], source: null,
  //       //    // source: null,
  //       //     // Other properties...
  //       //   ),
  //       // ),
  //     ),
  //   );
  // }
//}
// import 'package:flutter/material.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// void main() {
//   setUrlStrategy(PathUrlStrategy());
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Web Routing Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       initialRoute: '/',
//       onGenerateRoute: (settings) {
//         var uri = Uri.parse(settings.name!);
//         if (uri.pathSegments.length == 2 &&
//             uri.pathSegments.first == 'ClassSubmit') {
//           return MaterialPageRoute(
//             settings: settings,
//             builder: (context) =>
//                 ClassSubmitPage(classId: uri.pathSegments.last),
//           );
//         }
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(builder: (context) => HomePage());
//           case '/about':
//             return MaterialPageRoute(builder: (context) => AboutPage());
//           default:
//             return MaterialPageRoute(builder: (context) => NotFoundPage());
//         }
//       },
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text('Go to Class Submit'),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/ClassSubmit/20331816');
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Go to About'),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/about');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ClassSubmitPage extends StatelessWidget {
//   final String classId;

//   const ClassSubmitPage({Key? key, required this.classId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Class Submit')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Class Submit Page for ID: $classId',
//                 style: TextStyle(fontSize: 20)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Go Back'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AboutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('About')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('This is the About page', style: TextStyle(fontSize: 20)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Go Back'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NotFoundPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Not Found')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('404 - Page not found', style: TextStyle(fontSize: 20)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Go Home'),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
