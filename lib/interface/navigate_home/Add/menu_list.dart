import 'package:flutter/material.dart';
import '../Customer/map_in_list_search _autoverbal.dart';
import 'Add.dart';
import 'listPropertyCheck.dart';

class MenuVerbal extends StatelessWidget {
  const MenuVerbal(
      {super.key, required this.id, required this.id_control_user});
  final String id;
  final String id_control_user;
  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.yellow,
      Colors.lightGreen,
      Color.fromRGBO(169, 255, 194, 1),
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Horizon',
      shadows: [Shadow(blurRadius: 2, color: Colors.deepPurpleAccent)],
    );
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
      ),
      child: Scaffold(
        backgroundColor: Colors.indigo[900],
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.yellowAccent,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(220),
                    bottomRight: Radius.circular(220),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (context) => Add(
                    //           id: id,
                    //           id_control_user: id_control_user,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: double.infinity,
                    //     alignment: Alignment.center,
                    //     margin: const EdgeInsets.only(left: 50, bottom: 50),
                    //     decoration: BoxDecoration(
                    //       color: Colors.indigo[900],
                    //       borderRadius: const BorderRadius.only(
                    //           topLeft: Radius.circular(90)),
                    //       boxShadow: const [
                    //         BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                    //       ],
                    //     ),
                    //     child: Text(
                    //       'Add Auto Verbal',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize:
                    //               MediaQuery.textScaleFactorOf(context) * 17),
                    //     ),

                    //     // child: AnimatedTextKit(
                    //     //   animatedTexts: [
                    //     //     ColorizeAnimatedText('Add Auto Verbal',
                    //     //         textStyle: colorizeTextStyle,
                    //     //         colors: colorizeColors,
                    //     //         speed: const Duration(milliseconds: 70)),
                    //     //   ],
                    //     //   isRepeatingAnimation: true,
                    //     //   repeatForever: true,
                    //     //   onTap: () {
                    //     //     Navigator.of(context).push(
                    //     //       MaterialPageRoute(
                    //     //         builder: (context) => Add(
                    //     //           id: id,
                    //     //         ),
                    //     //       ),
                    //     //     );
                    //     //   },
                    //     // ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Add(
                              id_control_user: id_control_user,
                              id: id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 50, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(90)),
                          boxShadow: const [
                            BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                          ],
                        ),
                        child: Text(
                          'Cross check price',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 17),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => List_Auto(
                              id_control_user: id_control_user,
                              verbal_id: id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 50, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(90)),
                          boxShadow: const [
                            BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                          ],
                        ),
                        child: Text(
                          'List Auto Verbal',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 17),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Map_List_search_auto_verbal(
                                  get_commune: (value) {},
                                  get_district: (value) {},
                                  get_lat: (value) {},
                                  get_log: (value) {},
                                  get_max1: (value) {},
                                  get_max2: (value) {},
                                  get_min1: (value) {},
                                  get_min2: (value) {},
                                  get_province: (value) {},
                                )));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 50, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(90)),
                          boxShadow: const [
                            BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                          ],
                        ),
                        child: Text(
                          'Search Map',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 17),
                        ),
                      ),
                    ),

                    // SizedBox(
                    //   height: 50,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (context) => List_Auto(
                    //           verbal_id: id,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     margin: EdgeInsets.only(left: 50),
                    //     width: double.infinity,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       color: Colors.indigo[900],
                    //       borderRadius: BorderRadius.only(
                    //           bottomLeft: Radius.circular(10),
                    //           topLeft: Radius.circular(10)),
                    //       boxShadow: [
                    //         BoxShadow(blurRadius: 5, color: Colors.yellowAccent)
                    //       ],
                    //     ),
                    //     child: AnimatedTextKit(
                    //       animatedTexts: [
                    //         ColorizeAnimatedText(
                    //           'List Auto Verbal',
                    //           textStyle: colorizeTextStyle,
                    //           colors: colorizeColors,
                    //           speed: const Duration(milliseconds: 70),
                    //         ),
                    //       ],
                    //       isRepeatingAnimation: true,
                    //       repeatForever: true,
                    //       onTap: () {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (context) => List_Auto(
                    //               verbal_id: id,
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => Map_List_search_auto_verbal(
                    //               get_commune: (value) {},
                    //               get_district: (value) {},
                    //               get_lat: (value) {},
                    //               get_log: (value) {},
                    //               get_max1: (value) {},
                    //               get_max2: (value) {},
                    //               get_min1: (value) {},
                    //               get_min2: (value) {},
                    //               get_province: (value) {},
                    //             )));
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     margin: EdgeInsets.only(left: 50),
                    //     width: double.infinity,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         color: Colors.indigo[900],
                    //         borderRadius: BorderRadius.only(
                    //           bottomLeft: Radius.circular(90),
                    //         ),
                    //         boxShadow: [
                    //           BoxShadow(
                    //               blurRadius: 5, color: Colors.yellowAccent)
                    //         ]),
                    //     child: AnimatedTextKit(
                    //       animatedTexts: [
                    //         ColorizeAnimatedText(
                    //           'Search Map',
                    //           textStyle: colorizeTextStyle,
                    //           colors: colorizeColors,
                    //           speed: Duration(milliseconds: 70),
                    //         )
                    //       ],
                    //       //child: Text("Search Map")
                    //       isRepeatingAnimation: true,
                    //       repeatForever: true,
                    //       onTap: () {
                    //         Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (context) =>
                    //                 Map_List_search_auto_verbal(
                    //                   get_commune: (value) {},
                    //                   get_district: (value) {},
                    //                   get_lat: (value) {},
                    //                   get_log: (value) {},
                    //                   get_max1: (value) {},
                    //                   get_max2: (value) {},
                    //                   get_min1: (value) {},
                    //                   get_min2: (value) {},
                    //                   get_province: (value) {},
                    //                 )));
                    //       },
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Positioned(
                  top: 1,
                  left: 1,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.chevron_left_outlined,
                        size: 35,
                        color: Colors.white,
                      ))),
              // Positioned(
              //   top: 20,
              //   child: SizedBox(
              //     height: 210,
              //     width: 280,
              //     child: Image.asset(
              //       'assets/images/New_KFA_Logo.png',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
            ],
          ),
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
}
