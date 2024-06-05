import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_admin/screen/Property/Chat/provider/firebase_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:http/http.dart' as http;
import 'Auth/login.dart';
import 'cliboard.dart';
import 'components/bankcolumn.dart';
import 'components/bankrow.dart';
import 'interface/navigate_home/Comparable/comparable_1/New_Comparable.dart';
import 'interface/navigate_home/Comparable/newComparable/Comparable_list_new.dart';
import 'interface/navigate_home/Comparable/newComparable/paginatednewcomparable.dart';
import 'interface/navigate_home/Comparable/newComparable/responsivenewcomparable.dart';
import 'interface/navigate_home/Comparable/newComparable/responsiveupdate.dart';
import 'interface/navigate_home/Comparable/newComparable/update_new_comparable copy.dart';

List list = [];
String? district_id;
String? cummune_id;
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
    String? bankname;
    return ChangeNotifierProvider(
      create: (_) => FirebaseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // routes: {
        //    //'/': (context) => Login(),
        //   '/': (BuildContext obj) => Homecomparable(),
        //   '/old': (BuildContext obj) =>  New_Comparable(),
        //   '/new': (BuildContext obj) => ResponsiveHomeP()
        // },
        // home: Map_verbal_address_sale_two(
        //   get_commune: (value) {},
        //   get_district: (value) {},
        //   get_lat: (value) {},
        //   get_log: (value) {},
        //   get_province: (value) {},
        // ),
        home: Login(),
        // home: PaginatedTest(
        //   name: '',
        // ),
        //home: HomePageClipboard(),
        // home: Update_NewComarable(
        //   device: ''.toString(),
        //   email: ''.toString(),
        //   idUsercontroller: ''.toString(),
        //   myIdcontroller: ''.toString(),
        //   list: [],
        // ),
        //home: ResponsiveHomePupdate(),
        // home: ComparableListnews(
        //   name: '',
        // ),
        // home: ComparableList(
        //   name: '',
        // ),
        // home: ResponsiveHomeP(),
        // home: ResponsiveCustomer(
        //   email: '',
        //   idController: '',
        //   myIdController: '',
        // ),
        //home: const New_Comparable(),
        //home: Hometest(),
        //home: Login(),
        // home: const detail_verbal(
        //   set_data_verbal: '54K182F54Aky5wp5e9d',
        // ),

        //  home: ResponsiveLayout(myIdController: '', email: '', idController: ''),
        // home: Chat_Message(uid: '191K877F994A', userId: '192K381F363A'),
        // home: const AddProperty(idUserController: '95K267F95A'),
        // home: MyFavories(
        //     email: 'mp@gmail.com',
        //     idUsercontroller: '192K381F363A',
        //     myIdController: '191K877F994A'),
        //  home: Map_verbal_address_Sale(get_commune: (value) {  },
        // get_district: (value) {  },
        // get_lat: (value) {  },
        // get_log: (value) {  },
        // get_province: (value) {  },),
        //home: new_customer_map(),
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

class Hometest extends StatefulWidget {
  const Hometest({super.key});

  @override
  State<Hometest> createState() => _HometestState();
}

class _HometestState extends State<Hometest> {
  String? provnce_id;
  String? songkat;
  String? provice_map;
  String? customerenddate;
  String? customerdatetotal;
  String? khan;
  String? log;
  String? lat;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TextEditingController end_date = TextEditingController();
  TextEditingController? _log;
  TextEditingController? _lat;
  TextEditingController todate = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    todate.text = "";
    today_formart();
    super.initState();
  }

  String? formattedDate;
  void today_formart() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //color: Colors.amber,
          height: 200,
          width: MediaQuery.of(context).size.width * 0.35,
          child: BankDropdowncolumn(
            bank: (value) {
              setState(() {
                compare_bank_id = value.toString();
              });
            },
            bankbranch: (value) {
              setState(() {
                //listbranch = value;
                // print(
                //     "\nkokoobject${listbranch}");
              });
            },
            validator: (val) {},
            filedName: 'Bank',
          ),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: PaginatedDataTable(
        //     dataRowHeight: 50, // Set the height of each row
        //     //dividerThickness: 2,
        //     // Set the thickness of the horizontal divider lines
        //     columns: [
        //       DataColumn(label: Text('Column 1')),
        //       DataColumn(label: Text('Column 2')),
        //       // Add more DataColumn widgets if needed
        //     ],
        //     rows: [
        //       DataRow(cells: [
        //         DataCell(Text('Row 1, Cell 1')),
        //         DataCell(Text('Row 1, Cell 2')),
        //         // Add more DataCell widgets if needed
        //       ]),
        //       // Add more DataRow widgets if needed
        //     ], source: null,
        //    // source: null,
        //     // Other properties...
        //   ),
        // ),
      ),
    );
  }
}
