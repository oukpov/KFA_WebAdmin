import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import '../../../components/colors.dart';
import '../../../models/Verbal_limited.dart';
import '../../../server/api_service.dart';

class CTL_User extends StatefulWidget {
  const CTL_User({super.key});

  @override
  State<CTL_User> createState() => _CTL_UserState();
}

class _CTL_UserState extends State<CTL_User>
    with SingleTickerProviderStateMixin {
  late String username = "";
  late String first_name = "";
  late String last_name = "";
  late String email = "";
  late String gender = "";
  late String from = "";
  late String tel = "";
  var get_user = [];
  List data = [];
  var groupValue = 0;
  List Title = [
    'Female',
    'Male',
  ];
  static TabController? controller;
  static int index = 0;
  void fetchData(gender, form) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/userAll?gender=${gender}&known_from=${form}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        data = jsonData;
      });
    }
  }

  @override
  void initState() {
    cell_user(
      known_from: 0,
      check: '',
    );
    controller = TabController(
        initialIndex: _CTL_UserState.index, length: Title.length, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  var dropdown;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Control Verbal"),
      ),
      body: Column(
        children: [
          GFCard(
              margin: EdgeInsets.all(5),
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GFRadio(
                        size: 20,
                        value: 0,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = int.parse(value.toString());
                          });
                        },
                        inactiveIcon: null,
                        activeBorderColor: GFColors.SUCCESS,
                        radioColor: GFColors.SUCCESS,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            value: dropdown,
                            onChanged: (newValue) {
                              setState(() {
                                dropdown = newValue;
                                controller;
                              });
                            },
                            hint: Text(
                              'Property',
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: [
                              'Other',
                              'Banks',
                              'Private',
                              'Admin',
                            ]
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      GFRadio(
                        size: 20,
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = int.parse(value.toString());
                          });
                        },
                        inactiveIcon: null,
                        activeBorderColor: GFColors.PRIMARY,
                        radioColor: GFColors.PRIMARY,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('Male'), Text("Female")],
                  ),
                ],
              )),
          InkWell(
            onTap: () {
              fetchData(Title.elementAt(groupValue), dropdown);
              print(data.length);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                "Show Number",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 18),
              ),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          if (data.isNotEmpty)
            for (int i = 0; i < data.length; i++)
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                child: Text(data[i]['username']),
              )
        ],
      ),
    );
  }
}

class cell_user extends StatefulWidget {
  const cell_user({super.key, required this.known_from, required this.check});
  final int known_from;
  final String check;
  @override
  State<cell_user> createState() => _cell_userState();
}

class _cell_userState extends State<cell_user> {
  var User = [
    'Female',
    'Male',
  ];

  var number_verbal = [];
  List data = [];
  void fetchData(gender, form) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/userAll?gender=${gender}&known_from=${form}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        data = jsonData;
      });
    }
  }

  void fetchData_known_from(known_from) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/userAll?known_from=${known_from}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        data = jsonData;
      });
    }
  }

  var get_user = [];

  @override
  void initState() {
    User;
    fetchData(User.elementAt(widget.known_from), widget.check);

    // TODO: implement initState
    super.initState();
  }

  TextStyle st = TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 18,
      fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 72, 191, 238),
        body: SingleChildScrollView(
      child: Column(
        children: [
          for (int index = 0; index < data.length; index++)
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => setting_user(
                            id_user: data[index]['id'],
                            first_name: data[index]['first_name'],
                            email: data[index]['email'],
                            from: data[index]['known_from'],
                            gender: data[index]['gender'],
                            last_name: data[index]['last_name'],
                            tel: data[index]['tel_num'],
                            username: data[index]['username'],
                          )));
                });
              },
              child: Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 152, 209, 255),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        width: 60,
                        height: 50,
                        // color: Colors.green[400],
                        child: Image.asset('assets/check_user.png'),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(20)),
                        color: Colors.amberAccent,
                      ),
                      child: Row(
                        children: [
                          // Text(
                          //   'User\'s ID = ',
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          Text('${index + 1}'),
                          // Text('${data[index]['id'].toString()}'),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 70,
                      top: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          color: Color.fromARGB(255, 240, 255, 107),
                        ),
                        width: 250,
                        height: 50,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text("ID ${data[index]['id'].toString()}",
                                style: TextStyle(fontStyle: FontStyle.italic)),
                            Text(
                              '${data[index]['username'].toString()}',
                              style: st,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ));
  }
}

class setting_user extends StatefulWidget {
  const setting_user(
      {super.key,
      required this.id_user,
      required this.username,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.gender,
      required this.from,
      required this.tel});
  final int id_user;
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  @override
  State<setting_user> createState() => _setting_userState();
}

class _setting_userState extends State<setting_user> {
  var num;
  List list = [];
  Future<void> show_number_verbal(id) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=${id}'));

    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
        num = list.length;
        // number_verbal.add(list.length.toString());
      });
    }
  }

  bool? ch_in, ch_bl;
  List list_limted = [];
  int limited = 0;
  Future<void> show_limited(id) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/limited_verbal?id_verbal=${id}'));

    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list_limted = jsonData;
        if (list_limted.isNotEmpty) {
          limited = int.parse(list_limted[0]['number_limited']);
          if (list_limted[0]['block'] == '1') {
            setState(() {
              ch_bl = true;
            });
          } else if (list_limted[0]['block'] == '0') {
            setState(() {
              ch_bl = false;
            });
          } else {
            ch_bl = false;
          }
        } else {
          setState(() {
            ch_bl = false;
          });
        }
      });
    }
  }

  TextStyle st = const TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 18,
      fontWeight: FontWeight.bold);
  late Verbal_limited V_limited;
  @override
  void initState() {
    show_limited(widget.id_user);
    show_number_verbal(widget.id_user);
    V_limited = Verbal_limited(
        idVerbal: widget.id_user.toString(),
        idLimitedVerbal: widget.id_user.toString(),
        numberLimited: limited.toString(),
        block: '0');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: (ch_bl != null)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    color: Colors.blueAccent,
                    child: Row(
                      children: [
                        GFAvatar(
                          radius: 70,
                          child: Text(widget.username,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 18)),
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.tel,
                              style: st,
                            ),
                            Align(
                              child: Text('Verbal Number : ${num}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Insert ", style: st),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text("Block ", style: st),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GFToggle(
                                        onChanged: (val) {},
                                        value: true,
                                        type: GFToggleType.android,
                                      ),
                                      const SizedBox(height: 20),
                                      GFToggle(
                                        onChanged: (val) {
                                          setState(() {
                                            print(val);
                                            if (val == true) {
                                              V_limited.block = '1';
                                            } else {
                                              V_limited.block = '0';
                                            }
                                          });
                                        },
                                        value: ch_bl!,
                                        type: GFToggleType.android,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Verbal limited ", style: st),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      limited = int.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: '${limited}',
                                    fillColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.numbers_outlined,
                                      color: kImageColor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 126, 250, 1),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(0, 126, 250, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 249, 0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 249, 0, 0),
                                      ),
                                      //  borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return 'require *';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              // IconButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         limited = limited + 1;
                              //       });
                              //     },
                              //     icon: Icon(Icons.add)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GFButton(
                    onPressed: () {
                      setState(() {
                        V_limited.numberLimited = limited.toString();
                      });
                      V_limited.idLimitedVerbal = widget.id_user.toString();

                      APIservice apIservice = APIservice();
                      apIservice.Verballimited(V_limited).then((value) async {
                        print('Error');
                        print(json.encode(V_limited.toJson()));
                        if (value.message == "Save Successfully") {
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              headerAnimationLoop: false,
                              dialogType: DialogType.success,
                              showCloseIcon: false,
                              title: value.message,
                              autoHide: Duration(seconds: 3),
                              onDismissCallback: (type) {
                                Navigator.pop(context);
                              }).show();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Error',
                            desc: value.message,
                            btnOkOnPress: () {},
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red,
                          ).show();
                          print(value.message);
                        }
                      });
                    },
                    text: "Save",
                    fullWidthButton: true,
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
