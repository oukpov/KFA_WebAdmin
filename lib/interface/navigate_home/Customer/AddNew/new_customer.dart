// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:web_admin/interface/navigate_home/Customer/component/Web/simple/inputdateRow.dart';
import 'package:web_admin/interface/navigate_home/Customer/component/Web/simple/inputdateRowNow%20.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import '../../../../Profile/contants.dart';
import '../../../../components/colors/colors.dart';
import '../Api/dropdownAPI.dart';
import '../Api/province.dart';
import '../List/customer_list.dart';
import '../component/Web/simple/dropdown.dart';
import '../component/Web/simple/dropdownRow.dart';
import '../component/Web/simple/inputdate.dart';
import '../component/Web/simple/inputdateRowNow.dart';
import '../component/Web/simple/inputfiled.dart';
import '../component/Web/simple/inputfiledRow.dart';
import '../component/title/title.dart';

class new_customer extends StatefulWidget {
  const new_customer(
      {super.key,
      required this.device,
      required this.email,
      required this.idUsercontroller,
      required this.myIdcontroller});
  final String device;
  final String email;
  final String idUsercontroller;
  final String myIdcontroller;
  @override
  State<new_customer> createState() => _new_customerState();
}

class _new_customerState extends State<new_customer> {
  TextEditingController assigndate = TextEditingController();
  TextEditingController todate = TextEditingController();
  TextEditingController ycontrollerD = TextEditingController();
  ProvinceAPI controller = ProvinceAPI();
  DropdownAPI controllerdown = DropdownAPI();
  @override
  void initState() {
    main();

    customerdate = getCurrentDate();
    customerinspectingdate = getCurrentDate();
    todate.text = "";
    aRFlastID();
    todayFormart();
    valutionTypeModel();

    super.initState();
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now);
  }

  void main() {
    setState(() {
      provinceModel();
      valutionTypeModel();
      appraiserModel();
      accompanyModel();
      inspectorModel();
      inspectorsModel();
      assiignedModel();
      bankModel();
      homeModel();
      genderModel();
    });
  }

  var random = Random();

  String? formattedDate;
  int randomNumber = 0;
  void todayFormart() {
    randomNumber = random.nextInt(999);
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
    yyy = DateFormat('yy').format(now);
    customercode = 'ARF$yyy-${widget.idUsercontroller}$randomNumber';
  }

  String? yyy;
  String? customergender;
  String? customercode;
  String? customerengname;
  String? customerkhmname;
  String? customerContactBys;
  String? customervat;
  int? customerbanknameid;
  int? customerbankbranchid;
  String? customerphones;
  String? paidbys;
  String? paidby;
  String? customercontactname;
  int? customerproperty;
  String? customersize;
  String? customerpropertyaddress;
  int? customerpropertyprovince;
  int? customerpropertydistrict;
  int? customerpropertycommune;
  int? customerregistered;
  String? customerdate;
  String? customerservicecharge;
  String? customerservicechargePaid;
  String? customerservicechargeunpaid;
  String? customerInvoice;
  String? customerBuildSize;
  String? customerstartdate;
  String? customerenddate;
  int? customerinspector;
  int? customerinspectors;
  String? customerinspectingdate;
  int? customerassigned;
  String? customerassigneddate;
  String? officername;
  String? officetell;
  String? customerreferred;
  String? customerremark;
  int? customercasefrom;
  String? customerorn;
  String? datedayment;
  String? customerorns;
  String? seconddatepayment;
  String? customerinstructorname;
  String? customerinstructortel;
  String? appraiser;
  int? accompany;
  String? secondpayment;
  String? customerInvoices;
  Future<void> newCustomer() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IkpZakp2cTc3bTZHU05kTXNGSjF0a1E9PSIsInZhbHVlIjoidHo4ejJnZEpYWlo3QitOTmptRDBjVG9EQ1YyVERveFlJT2lpVHY4c2h4U1IyNk9sbzRhQng2Ny9TcnY5TmZVekl0eHlRai9tb3FOck5YVFpSVERiUjQrb0VVRHU2bWIxNnFPcTFTK2wwdHJxSWZQbkVvZTcrUmJjLzY2RE5ORXMiLCJtYWMiOiJlY2QyNzMxMjBiMGMwODIyZWM0Mzc3NGNkMGRjMDFiYjI3NDgxZjI3YTM0MzM4MTYyNDMzN2QxMTIyNWI3ZDZhIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6InNBQ2dJZUEza0xMc05WbmJ0bEFFS0E9PSIsInZhbHVlIjoiS0dkTTNtVG5NUG9sWTNpV0IxU0ptMi9USEgyY1NPWDFhVnJ5d2VtZXU3MUkwMFFoeWd0c1pOdTBBdUhyVW80Q3hzQzRrdm9vSFQyTXNEa1NUNnBTbjJRSXlyOE9xa0lERXRmUmp4bWp3T3BBK0dNVk1jRG8ySk9OSTJKSDQ4S2YiLCJtYWMiOiI3YjJiNTU1ZWYwZjhkZGJkOTViYjJmNzZiMWUzZWNmZTU3ZjY2Yzc5OTRlMDAzNWM4ZmY1ZGIxY2UxYTVlZWE4IiwidGFnIjoiIn0%3D'
    };

    var data = json.encode({
      //Validator 13
      "customergender": customergender!,
      "customerengname": customerengname!,
      "customerproperty": customerproperty!,
      "customersize": customersize,
      "customerBuildSize": customerBuildSize,
      "customerpropertyaddress": customerpropertyaddress!,
      "customerbankname_id": customerbanknameid!,
      "customerservicecharge": customerservicecharge!,
      "customerstartdate": customerstartdate!,
      "customerenddate": customerenddate!,
      "customerinspector": customerinspector!,
      "customerregistered": customerregistered!,
      "customerassigned": customerassigned!,

      ///////////////
      "customercode": customercode!,
      "customerkhmname": customerkhmname,
      "customerContactBys": customerContactBys,
      "customervat": customervat,
      "customercontactname": customercontactname,
      "customerphones": customerphones,
      "customerpropertyprovince": customerpropertyprovince,
      "customerpropertydistrict": customerpropertydistrict,
      "customerpropertycommune": customerpropertycommune,
      "customerdate": customerdate,
      "customercasefrom": customercasefrom,
      "officer_name": officername,
      "office_tell": officetell,
      "customerbankbranch_id": customerbankbranchid,
      "customerservicechargePaid": customerservicechargePaid,
      "customerservicechargeunpaid": customerservicechargeunpaid,
      "customerorn": customerorn,
      "date_dayment": datedayment,
      "CustomerInvoice": customerInvoice,
      "paid_by": paidby,
      "customerorns": customerorns,
      "second_payment": secondpayment,
      "second_date_payment": seconddatepayment,
      "CustomerInvoices": customerInvoices,
      "paid_bys": paidbys,
      "customerinstructorname": customerinstructorname,
      "customerinstructortel": customerinstructortel,
      "appraiser": appraiser,
      "accompany": accompany,
      "customerinspectors": customerinspectors,
      "customerassigneddate": customerassigneddate,
      "customerremark": customerremark
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new/customer',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      if (typeoption == true) {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: false,
            title: 'Save Successfuly',
            autoHide: const Duration(seconds: 2),
            onDismissCallback: (type) {
              Navigator.pop(context);
            }).show();
      }
    } else {
      print('No No');
    }
  }

  int coderadom = 0;
  int coderadompost = 0;
  int radom() {
    String coderadoms =
        '${int.parse(widget.idUsercontroller)}${Random().nextInt(9999)}${Random().nextInt(999)}';
    coderadom = int.parse(coderadoms);

    return coderadom;
  }

  int i = 0;
  Future<void> mainmutiple() async {
    for (i; i < selectedImages.length; i++) {
      coderadompost = radom();
      await imagemutiple(i, coderadompost.toString(), customercode!);
    }

    if (i == selectedImages.length) {
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Save Successfuly',
          autoHide: const Duration(seconds: 2),
          onDismissCallback: (type) {
            Navigator.pop(context);
          }).show();
    }
  }

  Future<void> imagemutiple(int index, String code, customerID) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer/image/$customerID'),
    );

    request.fields['customerradom'] = code;
    request.files.add(http.MultipartFile.fromBytes(
        'image', selectedImages[index],
        filename: '${Random().nextInt(99)}.jpg'));
    var res = await request.send();
    if (res.statusCode == 200) {
      print('Image uploaded!');
    } else {
      print('Error uploading image: ${res.reasonPhrase}');
    }
  }

  List listAppraiser = [];
  List<File> images = [];
  Future<void> pickImages() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
      );
    } on Exception catch (e) {
      // Handle exception
    }
    // setState(() {
    //   images;
    // });

    List<File> files = [];
    for (var asset in resultList) {
      ByteData byteData = await asset.getByteData();
      final tempDir = await getTemporaryDirectory();

      final file = File('${tempDir.path}/${asset.name}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      files.add(file);
    }

    setState(() {
      images = files;
    });
  }

  double sizefont = 12;
  bool waitPosts = false;
  Future<void> postvalueImage() async {
    waitPosts = true;
    await Future.wait([
      newCustomer(),
      mainmutiple(),
    ]);
    setState(() {
      waitPosts = false;
    });
  }

  Future<void> posts() async {
    waitPosts = true;
    await Future.wait([
      newCustomer(),
    ]);
    setState(() {
      waitPosts = false;
    });
  }

  bool branchtbool = false;
  Future<void> branchlist(value) async {
    branchtbool = true;
    await Future.wait([controllerdown.branchModel(value)]);
    setState(() {
      branchtbool = false;
    });
  }

  bool districtbool = false;
  Future<void> districtlist(value) async {
    districtbool = true;
    await Future.wait([controller.districtModel(value)]);
    setState(() {
      districtbool = false;
    });
  }

  bool communetbool = false;
  Future<void> communelist(value) async {
    communetbool = true;
    await Future.wait([controller.communModel(value)]);
    setState(() {
      communetbool = false;
    });
  }

  bool typeoption = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var sizebox40h = const SizedBox(height: 40);
  var sizebox10h = const SizedBox(height: 10);
  var sizebox = const SizedBox(width: 10);
  var sizeboxw40 = const SizedBox(width: 40);

  var w;
  TextEditingController customerengnametxt = TextEditingController();
  TextEditingController recievable = TextEditingController();
  @override
  void dispose() {
    customerengnametxt.dispose();
    recievable.dispose();
    super.dispose();
  }

  double customerservicecharges = 0;
  double customerservicechargePaids = 0;
  double secondpayments = 0;
  void receivable() {
    if (customerservicecharge != null) {
      customerservicechargeunpaid = recievable.text =
          (customerservicecharges - customerservicechargePaids - secondpayments)
              .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width * 0.35;
    return Scaffold(
      body: (waitPosts)
          ? LiquidLinearProgressIndicator(
              value: 0.25,
              valueColor: const AlwaysStoppedAnimation(
                  Color.fromARGB(255, 53, 33, 207)),
              backgroundColor: Colors.white,
              borderColor: Colors.white,
              borderWidth: 5.0,
              borderRadius: 12.0,
              direction: Axis.vertical,
              center: Text(
                "Please waiting...!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 15),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 0, left: 10),
                child: (widget.device == 'm')
                    ? Form(
                        key: formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Customer_List(),
                                            ));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 32, 107, 7)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit,
                                                color: whileColors),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: whileColors,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    sizebox,
                                    InkWell(
                                      onTap: () async {
                                        // setState(() {
                                        //   customerimages(compressedImage);
                                        // });

                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            if (selectedImages.isNotEmpty) {
                                              postvalueImage();
                                            } else {
                                              posts();
                                            }
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 2, 66, 118)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.save_alt_outlined,
                                                color: whileColors),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: whileColors,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizebox10h,
                                titletexts('Customer Registration', context),
                                sizebox40h,
                                filedtexts('Customer Name', ' *', context),
                                sizebox10h,
                                DropDownRow(
                                    validator: true,
                                    flex: 2,
                                    value: (value) {
                                      setState(() {
                                        customergender = value;
                                      });
                                    },
                                    list: genderList,
                                    valuedropdown: 'gender_id',
                                    valuetxt: 'gendername',
                                    filedName: 'Gender*'),
                                sizebox10h,
                                InputfiedRow(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerengname = value;
                                      });
                                    },
                                    filedName: 'CustomerName *',
                                    flex: 4),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerkhmname = value;
                                      });
                                    },
                                    filedName: 'Name in Khmer',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: true,
                                    value: (value) {},
                                    filedName: customercode!,
                                    flex: 3),
                                sizebox10h,
                                filedtexts('Contact By', '', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerContactBys = value;
                                      });
                                    },
                                    filedName: 'Contact By',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customervat = value;
                                      });
                                    },
                                    filedName: 'VAT TIN',
                                    flex: 3),
                                sizebox10h,
                                filedtexts('Property Guide Name', '', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customercontactname = value;
                                      });
                                    },
                                    filedName: 'Property Guide Name',
                                    flex: 6),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerphones = value;
                                      });
                                    },
                                    filedName: 'Tel',
                                    flex: 6),
                                sizebox10h,
                                filedtexts('Property Type', ' *', context),
                                sizebox10h,
                                DropDownRow(
                                    validator: true,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerproperty = int.parse(value);
                                      });
                                    },
                                    list: hometypeList,
                                    valuedropdown: 'property_type_id',
                                    valuetxt: 'property_type_name',
                                    filedName: 'Property Type *'),
                                sizebox10h,
                                InputfiedRow(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customersize = value;
                                      });
                                    },
                                    filedName: 'Size *',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerBuildSize = value;
                                      });
                                    },
                                    filedName: 'Building Size *',
                                    flex: 3),
                                sizebox10h,
                                filedtexts('Property Location', ' *', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerpropertyaddress = value;
                                      });
                                    },
                                    filedName: 'Property Location *',
                                    flex: 4),
                                sizebox10h,
                                DropDownRow(
                                    validator: false,
                                    flex: 3,
                                    value: (value) {
                                      setState(() {
                                        customerpropertyprovince =
                                            int.parse(value);

                                        districtlist(value);
                                      });
                                    },
                                    list: provinceList,
                                    valuedropdown: 'provinces_id',
                                    valuetxt: 'provinces_name',
                                    filedName: 'Province'),
                                sizebox10h,
                                (districtbool)
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : DropDownRow(
                                        validator: false,
                                        flex: 3,
                                        value: (value) {
                                          setState(() {
                                            customerpropertydistrict =
                                                int.parse(value);
                                            communelist(value);
                                          });
                                        },
                                        list: controller.districtList,
                                        valuedropdown: 'district_id',
                                        valuetxt: 'district_name',
                                        filedName: 'District'),
                                sizebox10h,
                                (communetbool)
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : DropDownRow(
                                        validator: false,
                                        flex: 3,
                                        value: (value) {
                                          setState(() {
                                            customerpropertycommune =
                                                int.parse(value);
                                          });
                                        },
                                        list: controller.communeList,
                                        valuedropdown: 'commune_id',
                                        valuetxt: 'commune_name',
                                        filedName: 'Commune'),
                                sizebox10h,
                                filedtexts('Registered By', ' *', context),
                                sizebox10h,
                                DropDownRow(
                                    validator: true,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerregistered = int.parse(value);
                                      });
                                    },
                                    list: assiignedList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'assiigned_name',
                                    filedName: 'Register By *'),
                                sizebox10h,
                                InputDateRow(
                                  validator: false,
                                  filedName: 'Date',
                                  flex: 3,
                                  value: (value) {
                                    setState(() {
                                      customerdate = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                DropDownRow(
                                    validator: true,
                                    flex: 3,
                                    value: (value) {
                                      setState(() {
                                        customercasefrom = int.parse(value);
                                      });
                                    },
                                    list: valutionList,
                                    valuedropdown: 'valuationtype_id',
                                    valuetxt: 'valuationtype_name',
                                    filedName: 'Case'),
                                sizebox10h,
                                filedtexts('Bank', ' *', context),
                                sizebox10h,
                                DropDownRow(
                                    validator: true,
                                    flex: 3,
                                    value: (value) {
                                      setState(() {
                                        customerbanknameid = int.parse(value);
                                        branchlist(value);
                                      });
                                    },
                                    list: bankList,
                                    valuedropdown: 'bank_id',
                                    valuetxt: 'bank_name',
                                    filedName: 'Select bank *'),
                                sizebox10h,
                                (branchtbool)
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : DropDownRow(
                                        validator: false,
                                        flex: 3,
                                        value: (value) {
                                          setState(() {
                                            customerbankbranchid =
                                                int.parse(value);
                                          });
                                        },
                                        list: controllerdown.branchList,
                                        valuedropdown: 'bank_branch_id',
                                        valuetxt: 'bank_branch_name',
                                        filedName: 'Select Branch'),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: true,
                                    value: (value) {
                                      setState(() {
                                        officername = value;
                                      });
                                    },
                                    filedName: 'Bank Officer Name',
                                    flex: 6),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: true,
                                    value: (value) {
                                      setState(() {
                                        officetell = value;
                                      });
                                    },
                                    filedName: 'Bank Officer Tell',
                                    flex: 6),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: true,
                                    value: (value) {
                                      setState(() {
                                        officername = value;
                                      });
                                    },
                                    filedName: 'Bank Officer Name',
                                    flex: 6),
                                sizebox10h,
                                filedtexts('Total Fee Charge', ' *', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerservicecharge = value;
                                        customerservicecharges =
                                            double.parse(value);
                                        receivable();
                                      });
                                    },
                                    filedName: 'Total Fee Charge *',
                                    flex: 6),
                                sizebox10h,
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: SizedBox(
                                        height: 35,
                                        child: TextFormField(
                                          controller: recievable,
                                          readOnly: true,
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQuery.textScaleFactorOf(
                                                          context) *
                                                      12,
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8),
                                            prefixIcon:
                                                const SizedBox(width: 7),
                                            hintText:
                                                'Account ReceiVable (A/R)',
                                            fillColor: kwhite,
                                            labelText:
                                                'Account ReceiVable (A/R)',
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: bordertxt,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizebox10h,
                                filedtexts('First Pay', '', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerservicechargePaid = value;
                                        customerservicechargePaids =
                                            double.parse(value);
                                        receivable();
                                      });
                                    },
                                    filedName: 'First Pay',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerorn = value;
                                      });
                                    },
                                    filedName: 'OR N',
                                    flex: 1),
                                sizebox10h,
                                InputDateRow(
                                  validator: false,
                                  filedName: 'Date Pay',
                                  flex: 3,
                                  value: (value) {
                                    setState(() {
                                      datedayment = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerInvoice = value;
                                      });
                                    },
                                    filedName: 'Invoice',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        paidby = value;
                                      });
                                    },
                                    filedName: 'Paid by',
                                    flex: 3),
                                sizebox10h,
                                filedtexts('Final Pay', '', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        secondpayment = value;
                                        secondpayments = double.parse(value);
                                        receivable();
                                      });
                                    },
                                    filedName: 'Final Pay',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerorns = value;
                                      });
                                    },
                                    filedName: 'OR N',
                                    flex: 1),
                                sizebox10h,
                                InputDateRow(
                                  validator: false,
                                  filedName: 'Date Pay',
                                  flex: 3,
                                  value: (value) {
                                    setState(() {
                                      seconddatepayment = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerInvoices = value;
                                      });
                                    },
                                    filedName: 'Invoice',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        paidbys = value;
                                      });
                                    },
                                    filedName: 'Paid by',
                                    flex: 3),
                                sizebox10h,
                                filedtexts('Inspector Name', '', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerinstructorname = value;
                                      });
                                    },
                                    filedName: 'Inspector Name',
                                    flex: 3),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerinstructortel = value;
                                      });
                                    },
                                    filedName: 'Instructor Tell',
                                    flex: 3),
                                sizebox10h,
                                DropDownRow(
                                    validator: false,
                                    flex: 3,
                                    value: (value) {
                                      setState(() {
                                        appraiser = value;
                                      });
                                    },
                                    list: appraiserList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Appraiser_name',
                                    filedName: 'Appraiser'),
                                sizebox10h,
                                DropDownRow(
                                    validator: false,
                                    flex: 3,
                                    value: (value) {
                                      setState(() {
                                        accompany = int.parse(value);
                                      });
                                    },
                                    list: accompanyList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Accompany_by_name',
                                    filedName: 'Accompany by'),
                                sizebox10h,
                                filedtexts('Start Date', ' *', context),
                                sizebox10h,
                                InputDateRow(
                                  validator: true,
                                  filedName: 'Start Date *',
                                  flex: 6,
                                  value: (value) {
                                    setState(() {
                                      customerstartdate = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                InputDateRow(
                                  validator: true,
                                  filedName: 'End Date *',
                                  flex: 6,
                                  value: (value) {
                                    setState(() {
                                      customerenddate = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                filedtexts('Inspector Name', ' *', context),
                                sizebox10h,
                                DropDownRow(
                                    validator: true,
                                    flex: 3,
                                    value: (value) {
                                      setState(() {
                                        customerinspector = int.parse(value);
                                      });
                                    },
                                    list: inspectorList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Inspector_name',
                                    filedName: 'Inspector Name *'),
                                sizebox10h,
                                DropDownRow(
                                    validator: false,
                                    flex: 3,
                                    value: (value) {
                                      setState(() {
                                        customerinspectors = int.parse(value);
                                      });
                                    },
                                    list: inspectorsList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Inspectors_name',
                                    filedName: ''),
                                sizebox10h,
                                InputDateRow(
                                  validator: true,
                                  filedName: 'Inspecting Date *',
                                  flex: 6,
                                  value: (value) {
                                    setState(() {
                                      customerinspectingdate = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                filedtexts('Assigned By', ' *', context),
                                sizebox10h,
                                DropDownRow(
                                    validator: true,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerassigned = int.parse(value);
                                      });
                                    },
                                    list: assiignedList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'assiigned_name',
                                    filedName: 'Assigned By *'),
                                sizebox10h,
                                InputDateRowNow(
                                  validator: false,
                                  filedName: 'Assigned Date',
                                  flex: 6,
                                  value: (value) {
                                    setState(() {
                                      customerassigneddate = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                filedtexts('Remark', '', context),
                                sizebox10h,
                                InputfiedRow(
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerremark = value;
                                      });
                                    },
                                    filedName: 'Remark',
                                    flex: 3),
                                sizebox40h,
                                //Image Customer
                                if (_byesData != null)
                                  Wrap(
                                    children: [
                                      for (int i = 0;
                                          i < selectedImages.length;
                                          i++)
                                        SizedBox(
                                          height: 80,
                                          width: 100,
                                          child: Text(i.toString()),
                                        )
                                    ],
                                  ),
                                sizebox10h,
                                if (selectedImages.isNotEmpty)
                                  SizedBox(
                                    height: 100,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            for (int i = 0;
                                                i < selectedImages.length;
                                                i++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: SizedBox(
                                                  height: 100,
                                                  width: 200,
                                                  child: Stack(children: [
                                                    Image.memory(
                                                      selectedImages[i],
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedImages
                                                                  .removeAt(i);
                                                            });
                                                          },
                                                          child: const CircleAvatar(
                                                              radius: 15,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              child: Icon(Icons
                                                                  .remove_outlined)),
                                                        ),
                                                        const SizedBox(
                                                            width: 20)
                                                      ],
                                                    ),
                                                  ]),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                sizebox10h,

                                filedtexts('Images', ' *', context),
                                sizebox10h,
                                Row(
                                  children: [
                                    sizebox,
                                    InkWell(
                                        onTap: () {
                                          openImage();
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1, color: greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Text(
                                                'Choose File Images')))
                                  ],
                                ),
                                sizebox40h,
                              ],
                            ),
                          ),
                        ),
                      )
                    //Dektop
                    : Form(
                        key: formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Customer_List();
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 32, 107, 7)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit,
                                                color: whileColors),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: whileColors,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    sizebox,
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (selectedImages.isNotEmpty) {
                                              postvalueImage();
                                              typeoption = false;
                                            } else {
                                              typeoption = false;
                                              posts();
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 2, 66, 118)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.save_alt_outlined,
                                                color: whileColors),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: whileColors,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizebox10h,
                                titletext('Customer Registration', context),
                                sizebox40h,
                                // Customer Name *
                                Row(
                                  children: [
                                    filedtext('Customer Name', ' *', context),
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          DropDown(
                                              validator: true,
                                              flex: 2,
                                              value: (value) {
                                                setState(() {
                                                  customergender = value;
                                                });
                                              },
                                              list: genderList,
                                              valuedropdown: 'gender_id',
                                              valuetxt: 'gendername',
                                              filedName: 'Gender*'),
                                          sizebox,
                                          Inputfied(
                                              validator: true,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerengname = value;
                                                });
                                              },
                                              filedName: 'CustomerName *',
                                              flex: 4),
                                        ],
                                      ),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerkhmname = value;
                                                });
                                              },
                                              filedName: 'Name in Khmer',
                                              flex: 3),
                                          sizebox,
                                          Inputfied(
                                              validator: false,
                                              readOnly: true,
                                              value: (value) {},
                                              filedName: customercode!,
                                              flex: 3),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Contact by
                                Row(
                                  children: [
                                    filedtext('Contact By', '', context),
                                    SizedBox(
                                      width: w,
                                      child: InputfiedRow(
                                          validator: false,
                                          readOnly: false,
                                          value: (value) {
                                            setState(() {
                                              customerContactBys = value;
                                            });
                                          },
                                          filedName: 'Contact By',
                                          flex: 3),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: InputfiedRow(
                                          validator: false,
                                          readOnly: false,
                                          value: (value) {
                                            setState(() {
                                              customervat = value;
                                            });
                                          },
                                          filedName: 'VAT TIN',
                                          flex: 3),
                                    ),
                                  ],
                                ),
                                sizebox10h,
                                //Property Guider Name
                                Row(
                                  children: [
                                    filedtext(
                                        'Property Guide Name', '', context),
                                    SizedBox(
                                      width: w,
                                      child: InputfiedRow(
                                          validator: false,
                                          readOnly: false,
                                          value: (value) {
                                            setState(() {
                                              customercontactname = value;
                                            });
                                          },
                                          filedName: 'Property Guide Name',
                                          flex: 6),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: InputfiedRow(
                                          validator: false,
                                          readOnly: false,
                                          value: (value) {
                                            setState(() {
                                              customerphones = value;
                                            });
                                          },
                                          filedName: 'Tel',
                                          flex: 6),
                                    ),
                                  ],
                                ),
                                sizebox10h,
                                //Property Type
                                Row(
                                  children: [
                                    filedtext('Property Type', ' *', context),
                                    SizedBox(
                                      width: w,
                                      child: DropDownRow(
                                          validator: true,
                                          flex: 6,
                                          value: (value) {
                                            setState(() {
                                              customerproperty =
                                                  int.parse(value);
                                            });
                                          },
                                          list: hometypeList,
                                          valuedropdown: 'property_type_id',
                                          valuetxt: 'property_type_name',
                                          filedName: 'Property Type *'),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Inputfied(
                                                validator: true,
                                                readOnly: false,
                                                value: (value) {
                                                  setState(() {
                                                    customersize = value;
                                                  });
                                                },
                                                filedName: 'Size *',
                                                flex: 3),
                                            sizebox,
                                            Inputfied(
                                                validator: true,
                                                readOnly: false,
                                                value: (value) {
                                                  setState(() {
                                                    customerBuildSize = value;
                                                  });
                                                },
                                                filedName: 'Building Size *',
                                                flex: 3),
                                          ],
                                        )),
                                  ],
                                ),
                                sizebox10h,
                                //Property Location
                                Row(
                                  children: [
                                    filedtext(
                                        'Property Location', ' *', context),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              Inputfied(
                                                  validator: true,
                                                  readOnly: false,
                                                  value: (value) {
                                                    setState(() {
                                                      customerpropertyaddress =
                                                          value;
                                                    });
                                                  },
                                                  filedName:
                                                      'Property Location *',
                                                  flex: 4),
                                              sizebox,
                                              DropDown(
                                                  validator: false,
                                                  flex: 3,
                                                  value: (value) {
                                                    setState(() {
                                                      customerpropertyprovince =
                                                          int.parse(value);

                                                      districtlist(value);
                                                    });
                                                  },
                                                  list: provinceList,
                                                  valuedropdown: 'provinces_id',
                                                  valuetxt: 'provinces_name',
                                                  filedName: 'Province'),
                                            ],
                                          ),
                                        ),
                                        sizeboxw40,
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              (districtbool)
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : DropDown(
                                                      validator: false,
                                                      flex: 3,
                                                      value: (value) {
                                                        setState(() {
                                                          customerpropertydistrict =
                                                              int.parse(value);
                                                          communelist(value);
                                                        });
                                                      },
                                                      list: controller
                                                          .districtList,
                                                      valuedropdown:
                                                          'district_id',
                                                      valuetxt: 'district_name',
                                                      filedName: 'District'),
                                              sizebox,
                                              (communetbool)
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : DropDown(
                                                      validator: false,
                                                      flex: 3,
                                                      value: (value) {
                                                        setState(() {
                                                          customerpropertycommune =
                                                              int.parse(value);
                                                        });
                                                      },
                                                      list: controller
                                                          .communeList,
                                                      valuedropdown:
                                                          'commune_id',
                                                      valuetxt: 'commune_name',
                                                      filedName: 'Commune'),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Registered By
                                Row(
                                  children: [
                                    filedtext('Registered By', ' *', context),
                                    SizedBox(
                                      width: w,
                                      child: DropDownRow(
                                          validator: true,
                                          flex: 6,
                                          value: (value) {
                                            setState(() {
                                              customerregistered =
                                                  int.parse(value);
                                            });
                                          },
                                          list: assiignedList,
                                          valuedropdown: 'person_id',
                                          valuetxt: 'assiigned_name',
                                          filedName: 'Register By *'),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          InputDateNow(
                                            filedName: 'Date',
                                            flex: 3,
                                            value: (value) {
                                              setState(() {
                                                customerdate = value;
                                              });
                                            },
                                          ),
                                          sizebox,
                                          DropDown(
                                              validator: false,
                                              flex: 3,
                                              value: (value) {
                                                setState(() {
                                                  customercasefrom =
                                                      int.parse(value);
                                                });
                                              },
                                              list: valutionList,
                                              valuedropdown: 'valuationtype_id',
                                              valuetxt: 'valuationtype_name',
                                              filedName: 'Case'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Bank
                                Row(
                                  children: [
                                    filedtext('Bank', ' *', context),
                                    SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            DropDown(
                                                validator: true,
                                                flex: 3,
                                                value: (value) {
                                                  setState(() {
                                                    customerbanknameid =
                                                        int.parse(value);
                                                    branchlist(value);
                                                  });
                                                },
                                                list: bankList,
                                                valuedropdown: 'bank_id',
                                                valuetxt: 'bank_name',
                                                filedName: 'Select bank *'),
                                            sizebox,
                                            (branchtbool)
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : DropDown(
                                                    validator: false,
                                                    flex: 3,
                                                    value: (value) {
                                                      setState(() {
                                                        customerbankbranchid =
                                                            int.parse(value);
                                                      });
                                                    },
                                                    list: controllerdown
                                                        .branchList,
                                                    valuedropdown:
                                                        'bank_branch_id',
                                                    valuetxt:
                                                        'bank_branch_name',
                                                    filedName: 'Select Branch'),
                                          ],
                                        )),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Inputfied(
                                              validator: false,
                                              readOnly: true,
                                              value: (value) {
                                                setState(() {
                                                  officername = value;
                                                });
                                              },
                                              filedName: 'Bank Officer Name',
                                              flex: 6),
                                          sizebox,
                                          Inputfied(
                                              validator: false,
                                              readOnly: true,
                                              value: (value) {
                                                setState(() {
                                                  officetell = value;
                                                });
                                              },
                                              filedName: 'Bank Officer Tell',
                                              flex: 6),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Total Fee Charge
                                Row(
                                  children: [
                                    filedtext(
                                        'Total Fee Charge', ' *', context),
                                    SizedBox(
                                        width: w,
                                        child: InputfiedRow(
                                            validator: true,
                                            readOnly: false,
                                            value: (value) {
                                              setState(() {
                                                customerservicecharge = value;
                                                customerservicecharges =
                                                    double.parse(value);
                                                receivable();
                                              });
                                            },
                                            filedName: 'Total Fee Charge *',
                                            flex: 6)),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: SizedBox(
                                              height: 35,
                                              child: TextFormField(
                                                controller: recievable,
                                                readOnly: true,
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8),
                                                  prefixIcon:
                                                      const SizedBox(width: 7),
                                                  hintText:
                                                      'Account ReceiVable (A/R)',
                                                  fillColor: kwhite,
                                                  labelText:
                                                      'Account ReceiVable (A/R)',
                                                  filled: true,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: bordertxt,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //First Pay
                                Row(
                                  children: [
                                    filedtext('First Pay', '', context),
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerservicechargePaid =
                                                      value;
                                                  customerservicechargePaids =
                                                      double.parse(value);
                                                  receivable();
                                                });
                                              },
                                              filedName: 'First Pay',
                                              flex: 3),
                                          sizebox,
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerorn = value;
                                                });
                                              },
                                              filedName: 'OR N',
                                              flex: 1),
                                          sizebox,
                                          InputDate(
                                            filedName: 'Date Pay',
                                            flex: 3,
                                            value: (value) {
                                              setState(() {
                                                datedayment = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerInvoice = value;
                                                });
                                              },
                                              filedName: 'Invoice',
                                              flex: 3),
                                          sizebox,
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  paidby = value;
                                                });
                                              },
                                              filedName: 'Paid by',
                                              flex: 3),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Final Pay
                                Row(
                                  children: [
                                    filedtext('Final Pay', '', context),
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  secondpayment = value;
                                                  secondpayments =
                                                      double.parse(value);
                                                  receivable();
                                                });
                                              },
                                              filedName: 'Final Pay',
                                              flex: 3),
                                          sizebox,
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerorns = value;
                                                });
                                              },
                                              filedName: 'OR N',
                                              flex: 1),
                                          sizebox,
                                          InputDate(
                                            filedName: 'Date Pay',
                                            flex: 3,
                                            value: (value) {
                                              setState(() {
                                                seconddatepayment = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerInvoices = value;
                                                });
                                              },
                                              filedName: 'Invoice',
                                              flex: 3),
                                          sizebox,
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  paidbys = value;
                                                });
                                              },
                                              filedName: 'Paid by',
                                              flex: 3),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Instructor Name
                                Row(
                                  children: [
                                    filedtext('Inspector Name', '', context),
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerinstructorname =
                                                      value;
                                                });
                                              },
                                              filedName: 'Inspector Name',
                                              flex: 3),
                                          sizebox,
                                          Inputfied(
                                              validator: false,
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  customerinstructortel = value;
                                                });
                                              },
                                              filedName: 'Instructor Tell',
                                              flex: 3),
                                        ],
                                      ),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          DropDown(
                                              validator: false,
                                              flex: 3,
                                              value: (value) {
                                                setState(() {
                                                  appraiser = value;
                                                });
                                              },
                                              list: appraiserList,
                                              valuedropdown: 'person_id',
                                              valuetxt: 'Appraiser_name',
                                              filedName: 'Appraiser'),
                                          sizebox,
                                          DropDown(
                                              validator: false,
                                              flex: 3,
                                              value: (value) {
                                                setState(() {
                                                  accompany = int.parse(value);
                                                });
                                              },
                                              list: accompanyList,
                                              valuedropdown: 'person_id',
                                              valuetxt: 'Accompany_by_name',
                                              filedName: 'Accompany by'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Start date and EndStart
                                Row(
                                  children: [
                                    filedtext('Start Date', ' *', context),
                                    SizedBox(
                                      width: w,
                                      child: InputDateRow(
                                        validator: true,
                                        filedName: 'Start Date *',
                                        flex: 6,
                                        value: (value) {
                                          setState(() {
                                            customerstartdate = value;
                                          });
                                        },
                                      ),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: InputDateRow(
                                        validator: true,
                                        filedName: 'End Date *',
                                        flex: 6,
                                        value: (value) {
                                          setState(() {
                                            customerenddate = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Inspector Name
                                Row(
                                  children: [
                                    filedtext('Inspector Name', ' *', context),
                                    SizedBox(
                                      width: w,
                                      child: Row(
                                        children: [
                                          DropDown(
                                              validator: true,
                                              flex: 3,
                                              value: (value) {
                                                setState(() {
                                                  customerinspector =
                                                      int.parse(value);
                                                });
                                              },
                                              list: inspectorList,
                                              valuedropdown: 'person_id',
                                              valuetxt: 'Inspector_name',
                                              filedName: 'Inspector Name *'),
                                          sizebox,
                                          DropDown(
                                              validator: false,
                                              flex: 3,
                                              value: (value) {
                                                setState(() {
                                                  customerinspectors =
                                                      int.parse(value);
                                                });
                                              },
                                              list: inspectorsList,
                                              valuedropdown: 'person_id',
                                              valuetxt: 'Inspectors_name',
                                              filedName: ''),
                                        ],
                                      ),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: InputDateRow(
                                        validator: false,
                                        filedName: 'Inspecting Date',
                                        flex: 6,
                                        value: (value) {
                                          setState(() {
                                            customerinspectingdate = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Assigned By
                                Row(
                                  children: [
                                    filedtext('Assigned By', ' *', context),
                                    SizedBox(
                                      width: w,
                                      child: DropDownRow(
                                          validator: true,
                                          flex: 6,
                                          value: (value) {
                                            setState(() {
                                              customerassigned =
                                                  int.parse(value);
                                            });
                                          },
                                          list: assiignedList,
                                          valuedropdown: 'person_id',
                                          valuetxt: 'assiigned_name',
                                          filedName: 'Assigned By *'),
                                    ),
                                    sizeboxw40,
                                    SizedBox(
                                      width: w,
                                      child: InputDateRowNow(
                                        validator: false,
                                        filedName: 'Assigned Date',
                                        flex: 6,
                                        value: (value) {
                                          setState(() {
                                            customerassigneddate = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                sizebox10h,
                                //Remark
                                Row(
                                  children: [
                                    filedtext('Remark', '', context),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: InputfiedRow(
                                          validator: false,
                                          readOnly: false,
                                          value: (value) {
                                            setState(() {
                                              customerremark = value;
                                            });
                                          },
                                          filedName: 'Remark',
                                          flex: 3),
                                    ),
                                  ],
                                ),
                                sizebox40h,
                                //Image Customer
                                if (_byesData != null)
                                  Wrap(
                                    children: [
                                      for (int i = 0;
                                          i < selectedImages.length;
                                          i++)
                                        SizedBox(
                                          height: 80,
                                          width: 100,
                                          child: Text(i.toString()),
                                        )
                                    ],
                                  ),

                                if (selectedImages.isNotEmpty)
                                  SizedBox(
                                    height: 100,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            for (int i = 0;
                                                i < selectedImages.length;
                                                i++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: SizedBox(
                                                  height: 100,
                                                  width: 200,
                                                  child: Stack(children: [
                                                    Image.memory(
                                                      selectedImages[i],
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedImages
                                                                  .removeAt(i);
                                                            });
                                                          },
                                                          child: const CircleAvatar(
                                                              radius: 15,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              child: Icon(Icons
                                                                  .remove_outlined)),
                                                        ),
                                                        const SizedBox(
                                                            width: 20)
                                                      ],
                                                    ),
                                                  ]),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                sizebox10h,
                                sizebox10h,
                                Row(
                                  children: [
                                    filedtext('Images', ' *', context),
                                    sizebox,
                                    InkWell(
                                        onTap: () {
                                          openImage();
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1, color: greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Text(
                                                'Choose File Images')))
                                  ],
                                ),
                                sizebox40h,
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
    );
  }

  String? customerimage1;
  String? customerimage2;
  String? customerimage3;
  String? customerimage4;
  String? customerimage5;
  String? customerimage6;
  String? customerimage7;

  List<Uint8List> compressedImage = [];
  Future<List<Uint8List>> compressImages(List<Uint8List> imageList) async {
    List<Uint8List> compressedImages = [];
    for (var image in imageList) {
      Uint8List compressedImage = await testCompressList(image);
      compressedImages.add(compressedImage);
    }
    return compressedImages;
  }

  Future<Uint8List> testCompressList(Uint8List image) async {
    var result = await FlutterImageCompress.compressWithList(
      image,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    print('Original size: ${image.length}');
    print('Compressed size: ${result.length}');
    return result;
  }

  List valutionList = [];
  Future<void> valutionTypeModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_valutiontype'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body);
          valutionList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List appraiserList = [];
  Future<void> appraiserModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/appraiser/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          appraiserList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List accompanyList = [];
  Future<void> accompanyModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Accompany_by/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          accompanyList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List inspectorList = [];
  Future<void> inspectorModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspector/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          inspectorList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List inspectorsList = [];
  Future<void> inspectorsModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspectors/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          inspectorsList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List bankList = [];
  Future<void> bankModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/banks'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        bankList = jsonBody;
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List branchList = [];
  Future<void> branchModel(value) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_details_id=$value'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['bank_branches'];
          branchList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List hometypeList = [];
  Future<void> homeModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body);
          hometypeList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List genderList = [];
  Future<void> genderModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Gender_model'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          genderList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List assiignedList = [];
  Future<void> assiignedModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Registered_By/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          assiignedList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List provinceList = [];
  Future<void> provinceModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/province_bank'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          provinceList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  // Widget titletext(title) {
  //   return SizedBox(
  //       width: MediaQuery.of(context).size.width * 0.22,
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 20),
  //         child: Text(title,
  //             style: TextStyle(
  //                 fontSize: MediaQuery.textScaleFactorOf(context) * 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: const Color.fromARGB(255, 4, 33, 84))),
  //       ));
  // }

  // Widget filedtext(title, star) {
  //   return SizedBox(
  //       width: MediaQuery.of(context).size.width * 0.2,
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 20),
  //         child: Row(
  //           children: [
  //             Text(title,
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: MediaQuery.textScaleFactorOf(context) * 14,
  //                     color: greyColor)),
  //             Text(star,
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: MediaQuery.textScaleFactorOf(context) * 14,
  //                     color: Colors.red)),
  //           ],
  //         ),
  //       ));
  // }

  // Widget titletexts(title) {
  //   return SizedBox(
  //       width: MediaQuery.of(context).size.width,
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 0),
  //         child: Text(title,
  //             style: TextStyle(
  //                 fontSize: MediaQuery.textScaleFactorOf(context) * 16,
  //                 fontWeight: FontWeight.bold,
  //                 color: const Color.fromARGB(255, 4, 33, 84))),
  //       ));
  // }

  // Widget filedtexts(title, star) {
  //   return SizedBox(
  //       width: MediaQuery.of(context).size.width,
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 0),
  //         child: Row(
  //           children: [
  //             Text(title,
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: MediaQuery.textScaleFactorOf(context) * 13,
  //                     color: greyColor)),
  //             Text(star,
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: MediaQuery.textScaleFactorOf(context) * 13,
  //                     color: Colors.red)),
  //           ],
  //         ),
  //       ));
  // }

  // Image select file
  File? imageFile;
  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print(imageFile);
      });
    }
  }

  String aRFIDGETs = '';
  List aRFList = [];

  void aRFlastID() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/AFR_ID_Get'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        aRFList = jsonData;
        var aRFIDGET = int.parse(aRFList[0]['aRFID'].toString()) + 1;
        aRFIDGETs = aRFIDGET.toString();
      });
    }
  }

  void aRFID() async {
    Map<String, dynamic> payload = {
      'aRFID': aRFIDGETs,
      'customer_status': 1,
    };

    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/AFR_ID');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success ARF ID POST');
    } else {
      print('Error Latlog: ${response.reasonPhrase}');
    }
  }

  XFile? file;
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  Uint8List? selectedFile;
  Uint8List? _byesData;

  String imageUrl = '';
  Uint8List? get_bytes;
  List<Uint8List> selectedImages = [];

  late File croppedFile;
  void openImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null) {
        for (var file in files) {
          final reader = html.FileReader();
          reader.onLoadEnd.listen((event) {
            setState(() {
              selectedImages
                  .add(Uint8List.fromList(reader.result as List<int>));
            });
          });
          reader.readAsArrayBuffer(file);
        }
      }
    });
  }

  final completer = Completer<Uint8List>();
  html.File? cropimagefile;
  String? uploadedBlobUrl;
  String? _croppedBlobUrl;
  Future<void> cropImage() async {
    WebUiSettings settings;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    settings = WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: CroppieBoundary(
        width: (screenWidth * 0.4).round(),
        height: (screenHeight * 0.4).round(),
      ),
      viewPort: const CroppieViewPort(
        width: 300,
        height: 300,
      ),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    );
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageUrl,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [settings],
    );
    if (croppedFile != null) {
      final bytes = await croppedFile.readAsBytes();
      final blob = html.Blob([bytes]);
      cropimagefile = html.File([blob], 'cropped-image.png');
      get_bytes = Uint8List.fromList(bytes);
      // await
      setState(() {
        _croppedBlobUrl = croppedFile.path;
        saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
      });

      if (cropimagefile != null) {}
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
  }
}
