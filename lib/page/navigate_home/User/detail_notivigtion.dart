// ignore_for_file: body_might_complete_normally_nullable, must_be_immutable, unnecessary_question_mark

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../Profile/components/TwinBox_Notivigation.dart';

class Detail_Notivigation2 extends StatefulWidget {
  Detail_Notivigation2(
      {super.key, required this.list_widget, required this.id});
  dynamic? list_widget;
  String? id;

  @override
  State<Detail_Notivigation2> createState() => _Detail_NotivigationState();
}

// Text('UseID = ${widget.list_widget['id'].toString()}'),

class _Detail_NotivigationState extends State<Detail_Notivigation2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 63, 82, 224),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('${widget.list_widget['url']}'),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text('ID User :'),
              //         Text('Username :'),
              //         Text('Phone Number :'),
              //         Text('Email :'),
              //         Text('Gender :'),
              //       ],
              //     ),
              //     // Column(
              //     //   crossAxisAlignment: CrossAxisAlignment.start,
              //     //   children: [
              //     //     Padding(
              //     //       padding: const EdgeInsets.only(),
              //     //       child: Container(
              //     //         height: MediaQuery.of(context).size.height * 0.05,
              //     //         width: double.infinity,
              //     //       ),
              //     //     ),
              //     //     // Text('${widget.list_widget['id'].toString()}'),
              //     //     // Text('${widget.list_widget['username'].toString()}'),
              //     //     // Text('${widget.list_widget['tel_num'].toString()}'),
              //     //     // Text('${widget.list_widget['email'].toString()}'),
              //     //     // Text('${widget.list_widget['gender'].toString()}'),
              //     //   ],
              //     // ),
              //   ],
              // ),
              SizedBox(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Personal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.83,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (widget.list_widget['url'] != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              child: CachedNetworkImage(
                                                imageUrl: widget
                                                    .list_widget['url']
                                                    .toString(),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color: Colors.red,
                                        border: Border.all(width: 2),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${widget.list_widget['url'].toString()}')),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: Colors.red,
                                      border: Border.all(width: 2),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/noimage.png')),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                ),
                          SizedBox(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Name  :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'UserID :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' ${widget.list_widget['username'].toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' ${widget.list_widget['id'].toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      Column(
                        children: [
                          TwinBox_read(
                            labelText1: 'Firstname',
                            labelText2: 'Lastname',
                            fname: widget.list_widget['first_name'].toString(),
                            lname: widget.list_widget['last_name'].toString(),
                            get_fname: (value) {},
                            get_lname: (value) {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TwinBox_read(
                            labelText1: 'Gender',
                            labelText2: 'Know From',
                            fname: widget.list_widget['gender'].toString(),
                            lname: (widget.list_widget['known_from'] != null)
                                ? widget.list_widget['known_from'].toString()
                                : 'N/A',
                            get_fname: (value) {},
                            get_lname: (value) {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: TextFormField(
                                initialValue:
                                    widget.list_widget['tel_num'].toString(),
                                readOnly: true,
                                decoration: InputDecoration(
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  labelText: 'Phone number',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: TextFormField(
                                initialValue:
                                    widget.list_widget['email'].toString(),
                                readOnly: true,
                                decoration: InputDecoration(
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20),
                      //   child: Container(
                      //     height: MediaQuery.of(context).size.height * 0.26,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //         color: Color.fromARGB(255, 165, 200, 229),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 10, bottom: 10),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 'ID User :',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 'Email :',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 'UseName:',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 'Phone :',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 'Gender :',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ],
                      //           ),
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 '${widget.list_widget['id']}',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 '${widget.list_widget['email']}',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 '${widget.list_widget['username']}',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 '${widget.list_widget['tel_num']}',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               Text(
                      //                 '${widget.list_widget['gender']}',
                      //                 style: TextStyle(
                      //                     fontSize: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.022,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
