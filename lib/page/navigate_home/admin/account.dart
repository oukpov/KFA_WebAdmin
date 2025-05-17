// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/colors.dart';
import '../../../components/dropdownRow.dart';
import '../../../components/inputfiled.dart';
import '../../../getx/account/account.dart';
import '../../../getx/component/getx._snack.dart';

class Account extends StatefulWidget {
  Account({
    Key? key,
    required this.listUsers,
  }) : super(key: key);
  var listUsers;
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List bank = [
    {'title': 'Bank'},
    {'title': 'Private'},
    {'title': 'Other'},
  ];
  List gender = [
    {'title': 'Male'},
    {'title': 'Female'},
    {'title': 'Other'},
  ];
  String usersname = '';
  String firstname = '';
  String lastname = '';
  String telNum = '';
  String genders = '';
  String knowform = '';
  String password = '';
  String comfirmpassword = '';
  Component component = Component();
  @override
  void initState() {
    firstname = "${widget.listUsers['first_name'] ?? ""}";
    lastname = "${widget.listUsers['last_name'] ?? ""}";
    telNum = "${widget.listUsers['tel_num'] ?? ""}";
    genders = "${widget.listUsers['gender'] ?? ""}";
    usersname = widget.listUsers['username'].toString();
    // knowform = widget.listUsers['gender'].toString();
    // password = widget.listUsers['gender'].toString();
    // comfirmpassword = widget.listUsers['gender'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditController());
    // return Obx(
    //   () {
    //     if (controller.isAccount.value) {
    //       return const WaitingFunction();
    //     } else if (controller.listAccount.isEmpty) {
    //       return const SizedBox();
    //     } else {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.remove_circle_outline_outlined,
                    size: 35,
                    color: greyColorNolots,
                  ))
            ],
          ),
          const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         setState(() {
          //           if (_byesData == null) {
          //             openImgae();
          //           } else {
          //             _cropImage();
          //           }
          //         });
          //       },
          //       child: Stack(
          //         alignment: AlignmentDirectional.bottomCenter,
          //         children: [
          //           if (_byesData != null && cropORopen == false)
          //             GFAvatar(
          //               size: 80,
          //               backgroundImage: MemoryImage(_byesData!),
          //             )
          //           else if (getbytes != null && cropORopen == true)
          //             GFAvatar(
          //               size: 80,
          //               backgroundImage: MemoryImage(getbytes!),
          //             )
          //           else
          //             GFAvatar(
          //               size: 80,
          //               backgroundImage: NetworkImage(
          //                   widget.listUsers['url'] !=
          //                           null
          //                       ? widget.listUsers['url']
          //                           .toString()
          //                       : url),
          //             ),
          //           Container(
          //             height: 10,
          //             width: 30,
          //             alignment: Alignment.bottomCenter,
          //             decoration: BoxDecoration(
          //                 color: const Color.fromARGB(95, 67, 67, 67),
          //                 borderRadius: BorderRadius.circular(5)),
          //             child: Icon(
          //               (_byesData == null) ? Icons.edit : Icons.crop,
          //               color: Colors.white,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          // const SizedBox(height: 30),
          // Text(widget.listUsers.toString()),
          Column(
            children: [
              Row(
                children: [
                  InputfiedWidget(
                    lable: 'First Name',
                    readOnly: false,
                    filedName: firstname,
                    flex: 2,
                    value: (value) {
                      setState(() {
                        firstname = value;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  InputfiedWidget(
                    lable: 'Last Name',
                    readOnly: false,
                    filedName: lastname,
                    flex: 2,
                    value: (value) {
                      setState(() {
                        lastname = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text('Gender',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: blackColor,
                              fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      child: Text('Know From',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: blackColor,
                              fontSize: 14)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDownRowWidget(
                      list: gender,
                      valuedropdown: 'title',
                      valuetxt: 'title',
                      filedName: genders,
                      value: (value) {
                        setState(() {
                          genders = value;
                        });
                      },
                      flex: 2),
                  const SizedBox(width: 10),
                  DropDownRowWidget(
                      list: bank,
                      valuedropdown: 'title',
                      valuetxt: 'title',
                      filedName: knowform,
                      value: (value) {
                        setState(() {
                          knowform = value;
                        });
                      },
                      flex: 2),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Save Change'),
                onPressed: () async {
                  // setState(() {
                  //   registerController.isphoneRe.value = true;
                  // });

                  await controller.updateAuth(
                      firstname,
                      lastname,
                      genders,
                      knowform,
                      widget.listUsers['control_user'] ?? "",
                      telNum,
                      context);

                  // setState(() {
                  //   registerController.isphoneRe.value = false;
                  // });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Change Password',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                      fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              InputfiedWidget(
                lable: 'UsersName',
                readOnly: true,
                filedName: usersname,
                flex: 2,
                value: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              InputfiedWidget(
                lable: 'New Password',
                readOnly: false,
                filedName: '',
                flex: 2,
                value: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              InputfiedWidget(
                lable: 'Comfirm Password',
                readOnly: false,
                filedName: '',
                flex: 2,
                value: (value) {
                  setState(() {
                    comfirmpassword = value;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Change Password'),
                onPressed: () async {
                  // setState(() {
                  //   registerController.isphoneRe.value = true;
                  // });
                  if (comfirmpassword == password) {
                    await controller.editPassword(
                        widget.listUsers['control_user'],
                        // passwordOld,
                        password,
                        comfirmpassword,
                        context);
                  } else {
                    // print("OKOK2");
                    component.handleTap("Please Check Password again", "", 1);
                  }
                },
              ),
            ],
          ),
        ],
        //     );
        //   }
        // },
      ),
    );
  }
}
