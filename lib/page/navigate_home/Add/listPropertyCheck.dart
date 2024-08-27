import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/page/navigate_home/Add/save_image_for_Autoverbal.dart';
import 'Detail_Autoverbal.dart';
import 'RPSCustomPainter.dart';
import 'companen/_await.dart';

class List_Auto extends StatefulWidget {
  const List_Auto(
      {super.key, required this.verbal_id, required this.id_control_user});
  final String verbal_id;
  final String id_control_user;
  @override
  State<List_Auto> createState() => _List_AutoState();
}

class _List_AutoState extends State<List_Auto> {
  List list1 = [];
  bool check_data1 = false, check_data2 = false;
  void get_by_user_autoverbal() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_user=${widget.id_control_user}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list1 = jsonData;
        check_data1 = true;
      });
    }
  }

  List list = [];
  bool b1 = false;
  bool b2 = false;
  @override
  void initState() {
    allUser();
    get_by_user_autoverbal();

    super.initState();
  }

  bool awaitAuto = false;
  Future<void> allUser() async {
    awaitAuto = true;
    await Future.wait([
      autoVerbalAll(),
    ]);
    setState(() {
      awaitAuto = false;
    });
  }

  List list2 = [];
  Future<void> autoVerbalAll() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final listV = jsonDecode(json.encode(response.data));
      list2 = listV;
      list = listV;
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width * 0.9;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: const Text(
            "Auto Verbal List",
            style: TextStyle(fontSize: 22),
          ),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  b1 = !b1;
                  if (b1 == true) {
                    //Your verbal
                    list = list1;
                  } else {
                    //AllVerbal
                    list = list2;
                  }
                });
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 20, 20, 163),
                    border: Border.all(width: 3, color: Colors.white)),
                width: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.menu_open_outlined,
                      color: Colors.white,
                    ),
                    (b1 == true)
                        ? const Text('Your Verbal')
                        : const Text('All Verbal'),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 64, 120, 216),
        body: SingleChildScrollView(
          child: body(),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: kwhite_new,
        //   // currentIndex: _currentIndex,
        //   type: BottomNavigationBarType.fixed,
        //   iconSize: 25,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.home,
        //       ),
        //       label: "Home",
        //       // backgroundColor: kwhite_new,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.question_answer),
        //       label: "FAQ",
        //       backgroundColor: kwhite_new,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.contact_phone),
        //       label: "Contact",
        //       backgroundColor: kwhite_new,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.people),
        //       label: "About",
        //       backgroundColor: kwhite_new,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.feedback),
        //       label: "Feedback",
        //       backgroundColor: kwhite_new,
        //     ),
        //   ],
        //   onTap: (index) {
        //     if (index == 0) {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => const HomePage1()),
        //       );
        //     }
        //     if (index == 1) {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => const Fapsbuttom()),
        //       );
        //     }
        //     if (index == 2) {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => const ContactsButtom()),
        //       );
        //     }
        //     if (index == 3) {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => const AboutsButtom()),
        //       );
        //     }
        //     if (index == 4) {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const Feed_back_buttom()),
        //       );
        //     }
        //     // setState(() {
        //     //   _currentIndex = index;
        //     // });
        //   },
        // ),
      ),
    );
  }

  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
      ),
      child: CustomPaint(
        size: Size(
            5,
            (5 * 0.5833333333333334)
                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: RPSCustomPainter(),
        child: Visibility(
            visible: check_data1,
            replacement: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            child: awaitAuto ? Await_Verbal() : listview()),
      ),
    );
  }

  Widget listview() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return Container(
          height: 290,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(217, 255, 255, 255),
              // border: Border.all(
              //     width: 1,
              //     color: Color.fromRGBO(67, 160, 71, 1)),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Verbal ID\t\t:\t\t',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 14,
                          ),
                        ),
                        Text(
                          "${list[i]['verbal_id']}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Bank\t\t\t:\t\t',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 14,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            "${list[i]['bank_name']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Branch\t\t\t:\t\t',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 13,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "${list[i]['bank_branch_name'] ?? ""}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Property Type\t\t\t:\t\t',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 13,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "${list[i]['property_type_name']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Date :\t\t\t:\t\t',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 13,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "${list[i]['verbal_date']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 140,
                      width: 140,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.contain,
                        placeholder: 'assets/earth.gif',
                        image:
                            "https://maps.googleapis.com/maps/api/staticmap?center=${list[i]["latlong_log"]},${list[i]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[i]["latlong_log"]},${list[i]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI",
                      ),
                    ),
                    SizedBox(width: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GFButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    save_image_after_add_verbal(
                                      list: list,
                                      i: i.toString(),
                                      verbalId: list[i]["verbal_id"].toString(),
                                      set_data_verbal: '',
                                    )));
                          },
                          text: "Get Image",
                          color: Colors.green,
                          icon: const Icon(Icons.photo_library_outlined,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 5,
                                    offset: Offset(1, 0.5))
                              ],
                              size: 20),
                        ),
                        const SizedBox(width: 10),
                        GFButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => detail_verbal(
                                      set_data_verbal: list[i]["verbal_id"],
                                    )));
                          },
                          text: "Get PDF",
                          color: const Color.fromRGBO(229, 57, 53, 1),
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            size: 20,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                  offset: Offset(1, 0.5))
                            ],
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
