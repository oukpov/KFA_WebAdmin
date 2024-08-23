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
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import '../../../../Profile/contants.dart';
import '../../../../components/colors/colors.dart';
import '../Api/dropdownAPI.dart';
import '../Api/province.dart';
import '../component/Web/editText/dropdownRowtxt.dart';
import '../component/Web/editText/dropdowntxt.dart';
import '../component/Web/editText/inputdateRowtxt.dart';
import '../component/Web/editText/inputdatetxt.dart';
import '../component/Web/editText/inputdateRowNowetxt.dart';
import '../component/Web/editText/inputfiledRowtxt.dart';
import '../component/Web/editText/inputfiledtxt.dart';
import '../component/dropdownRowtxt.dart';
import '../component/Web/simple/inputdateRow.dart';
import '../component/inputdateRowtxt.dart';
import '../component/Web/simple/inputfiled.dart';
import '../component/inputfiledRowtxt .dart';
import '../component/lording.dart';
import '../component/title/title.dart';

class editCustomer extends StatefulWidget {
  const editCustomer(
      {super.key,
      required this.device,
      required this.email,
      required this.idUsercontroller,
      required this.myIdcontroller,
      required this.index,
      required this.list});
  final String device;
  final String email;
  final String idUsercontroller;
  final String myIdcontroller;
  final String index;
  final List list;
  @override
  State<editCustomer> createState() => _editCustomerState();
}

class _editCustomerState extends State<editCustomer> {
  TextEditingController todate = TextEditingController();
  TextEditingController customerengnametxt = TextEditingController();
  TextEditingController recievable = TextEditingController();
  ProvinceAPI controller = ProvinceAPI();
  DropdownAPI controllerdown = DropdownAPI();
  @override
  void dispose() {
    customerengnametxt.dispose();
    recievable.dispose();
    todate.dispose();
    super.dispose();
  }

  int index = 0;

  @override
  void initState() {
    main();
    index = int.parse(widget.index);
    customerdate = getCurrentDate();
    customerinspectingdate = getCurrentDate();
    todate.text = "";
    addmores();
    valueget();
    // aRFlastID();
    imageGet();
    todayFormart();
    valutionTypeModel();

    super.initState();
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now);
  }

  void valueget() {
    customergender = widget.list[index]['customergender'];
    customerengname = widget.list[index]['customerengname'];
    customerproperty = (widget.list[index]['customerproperty'] == null)
        ? null
        : int.parse(widget.list[index]['customerproperty'].toString());
    customersize = widget.list[index]['customersize'];
    customerBuildSize = widget.list[index]['customerBuildSize'];
    customerpropertyaddress = widget.list[index]['customerpropertyaddress'];
    customerbanknameid = (widget.list[index]['customerbankname_id'] == null)
        ? null
        : int.parse(widget.list[index]['customerbankname_id'].toString());
    customerservicecharge = widget.list[index]['customerservicecharge'];
    customerstartdate = widget.list[index]['customerstartdate'];
    customerenddate = widget.list[index]['customerenddate'];
    customerinspector = (widget.list[index]['customerinspector'] == null)
        ? null
        : int.parse(widget.list[index]['customerinspector'].toString());

    customerregistered = (widget.list[index]['customerregistered'] == null)
        ? null
        : int.parse(widget.list[index]['customerregistered'].toString());
    customerassigned = (widget.list[index]['customerassigned'] == null)
        ? null
        : int.parse(widget.list[index]['customerassigned'].toString());
    customercode = widget.list[index]['customercode'];
    customerkhmname = widget.list[index]['customerkhmname'];
    customerContactBys = widget.list[index]['customerContactBys'];
    customervat = widget.list[index]['customervat'];
    customercontactname = widget.list[index]['customercontactname'];
    customerphones = widget.list[index]['customerphones'];
    customerpropertyprovince = (widget.list[index]
                ['customerpropertyprovince'] ==
            null)
        ? null
        : int.parse(widget.list[index]['customerpropertyprovince'].toString());
    customerpropertydistrict = (widget.list[index]
                ['customerpropertydistrict'] ==
            null)
        ? null
        : int.parse(widget.list[index]['customerpropertydistrict'].toString());
    customerpropertycommune = (widget.list[index]['customerpropertycommune'] ==
            null)
        ? null
        : int.parse(widget.list[index]['customerpropertycommune'].toString());
    customerdate = widget.list[index]['customerdate'];
    customercasefrom = (widget.list[index]['customercasefrom'] == null)
        ? null
        : int.parse(widget.list[index]['customercasefrom'].toString());
    officername = widget.list[index]['officer_name'];
    officetell = widget.list[index]['office_tell'];
    // customerbankbranchid = widget.list[index]['customerbankbranch_id'];
    customerservicechargePaid = widget.list[index]['customerservicechargePaid'];
    customerservicechargeunpaid =
        widget.list[index]['customerservicechargeunpaid'];
    customerorn = widget.list[index]['customerorn'];
    datedayment = widget.list[index]['date_dayment'];
    customerInvoice = widget.list[index]['CustomerInvoice'];
    paidby = widget.list[index]['paid_by'];
    customerorns = widget.list[index]['customerorns'];
    secondpayment = widget.list[index]['second_payment'];
    seconddatepayment = widget.list[index]['second_date_payment'];
    customerInvoices = widget.list[index]['CustomerInvoices'];
    paidbys = widget.list[index]['paid_bys'];
    customerinstructorname = widget.list[index]['customerinstructorname'];
    customerinstructortel = widget.list[index]['customerinstructortel'];
    appraiser = widget.list[index]['appraiser'];
    accompany = (widget.list[index]['accompany'] == null)
        ? null
        : int.parse(widget.list[index]['accompany'].toString());
    customerinspectors = (widget.list[index]['customerinspectors'] == null)
        ? null
        : int.parse(widget.list[index]['customerinspectors'].toString());
    // customerassigneddate = widget.list[index]['customerassigneddate'];
    // customerremark = widget.list[index]['customerremark'];
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
  Future<void> editCustomer(customerID) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IkpZakp2cTc3bTZHU05kTXNGSjF0a1E9PSIsInZhbHVlIjoidHo4ejJnZEpYWlo3QitOTmptRDBjVG9EQ1YyVERveFlJT2lpVHY4c2h4U1IyNk9sbzRhQng2Ny9TcnY5TmZVekl0eHlRai9tb3FOck5YVFpSVERiUjQrb0VVRHU2bWIxNnFPcTFTK2wwdHJxSWZQbkVvZTcrUmJjLzY2RE5ORXMiLCJtYWMiOiJlY2QyNzMxMjBiMGMwODIyZWM0Mzc3NGNkMGRjMDFiYjI3NDgxZjI3YTM0MzM4MTYyNDMzN2QxMTIyNWI3ZDZhIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6InNBQ2dJZUEza0xMc05WbmJ0bEFFS0E9PSIsInZhbHVlIjoiS0dkTTNtVG5NUG9sWTNpV0IxU0ptMi9USEgyY1NPWDFhVnJ5d2VtZXU3MUkwMFFoeWd0c1pOdTBBdUhyVW80Q3hzQzRrdm9vSFQyTXNEa1NUNnBTbjJRSXlyOE9xa0lERXRmUmp4bWp3T3BBK0dNVk1jRG8ySk9OSTJKSDQ4S2YiLCJtYWMiOiI3YjJiNTU1ZWYwZjhkZGJkOTViYjJmNzZiMWUzZWNmZTU3ZjY2Yzc5OTRlMDAzNWM4ZmY1ZGIxY2UxYTVlZWE4IiwidGFnIjoiIn0%3D'
    };

    var data = json.encode({
      //Validator 13
      "customergender": customergender,
      "customerengname": customerengname,
      "customerproperty": customerproperty,
      "customersize": customersize,
      "customerBuildSize": customerBuildSize,
      "customerpropertyaddress": customerpropertyaddress,
      "customerbankname_id": customerbanknameid,
      "customerservicecharge": customerservicecharge,
      "customerstartdate": customerstartdate,
      "customerenddate": customerenddate,
      "customerinspector": customerinspector,
      "customerregistered": customerregistered,
      "customerassigned": customerassigned,

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
      // "customerassigneddate": '2020-1-1',
      // "customerremark": 'Pov'
      "customerassigneddate": customerassigneddate,
      "customerremark": customerremark
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/edit_customer/$customerID',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      if (typeoption == true) {
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

  bool addmore = false;
  Future<void> addmores() async {
    addmore = true;
    await Future.wait([morecustomer()]);
    setState(() {
      addmore = false;
    });
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

  List listmorecustomer = [];
  Future<void> morecustomer() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/more/customer?customerID=${widget.list[index]['customer_id']}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listmorecustomer = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  bool waitPosts = false;
  Future<void> postvalueImage(customerID) async {
    waitPosts = true;
    await Future.wait([
      editCustomer(customerID),
      mainmutiple(customerID),
    ]);
    setState(() {
      waitPosts = false;
    });
  }

  Future<void> posts(customerID) async {
    waitPosts = true;
    await Future.wait([
      editCustomer(customerID),
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

  bool waitImage = false;
  Future<void> imageGet() async {
    waitImage = true;
    await Future.wait([getImages()]);
    setState(() {
      waitImage = false;
    });
  }

  bool typeoption = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var sizebox40h = const SizedBox(height: 40);
  var sizebox10h = const SizedBox(height: 10);
  var sizebox = const SizedBox(width: 10);
  var sizeboxw20 = const SizedBox(width: 20);

  var w;

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

  int coderadom = 0;
  int coderadompost = 0;
  int radom() {
    String coderadoms =
        '${int.parse(widget.idUsercontroller)}${Random().nextInt(9999)}${Random().nextInt(999)}';
    coderadom = int.parse(coderadoms);

    return coderadom;
  }

  int i = 0;
  Future<void> mainmutiple(customerID) async {
    for (i; i < selectedImages.length; i++) {
      coderadompost = radom();
      await imagemutiple(i, coderadompost.toString(), customerID);
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

  List listdeleted = [];

  void maindelete() {
    for (int i = 0; i < listdeleted.length; i++) {
      deleted(i);
    }
  }

  Future<void> deleted(int index) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer/deleted/${listdeleted[index].toString()}',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  List imageList = [];
  Future<void> getImages() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer/images_gets/${widget.list[index]['customer_id']}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        imageList = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
        body: (waitPosts)
            ? lording(context)
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, left: 5),
                  child: (widget.device == 'm')
                      ? Form(
                          key: formKey,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      sizebox,
                                      InkWell(
                                        onTap: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (selectedImages.isNotEmpty) {
                                              await postvalueImage(widget
                                                  .list[index]['customer_id']
                                                  .toString());
                                            } else {
                                              setState(() {
                                                typeoption = true;
                                              });
                                              await posts(widget.list[index]
                                                      ['customer_id']
                                                  .toString());
                                            }
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
                                  titletexts('Customer Information', context),
                                  sizebox40h,
                                  // filedtexts('Customer Name', ' *'),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '*',
                                    lable: 'Gender',
                                    txtvalue:
                                        '${widget.list[index]['gendername'] ?? ""}',
                                    validator: true,
                                    value: (value) {
                                      setState(() {
                                        customergender = value;
                                      });
                                    },
                                    list: genderList,
                                    valuedropdown: 'gender_id',
                                    valuetxt: 'gendername',
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '*',
                                    lable: 'CustomerName',
                                    txtvalue:
                                        '${widget.list[index]['customerengname'] ?? ""}',
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerengname = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Name in Khmer',
                                    txtvalue:
                                        '${widget.list[index]['customerkhmname'] ?? ""}',
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerkhmname = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Code',
                                    txtvalue: customercode!,
                                    validator: false,
                                    readOnly: true,
                                    value: (value) {},
                                  ),

                                  sizebox10h,
                                  // filedtexts('Contact By', ''),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Contact By',
                                    txtvalue:
                                        '${widget.list[index]['customerContactBys'] ?? ""}',
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerContactBys = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'VAT TIN',
                                    txtvalue:
                                        '${widget.list[index]['customervat'] ?? ""}',
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customervat = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Property Guide Name', ''),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Property Guide Name',
                                    txtvalue:
                                        '${widget.list[index]['customercontactname'] ?? ""}',
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customercontactname = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Tel',
                                    txtvalue:
                                        '${widget.list[index]['customerphones'] ?? ""}',
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerphones = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Property Type', ' *'),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '*',
                                    lable: 'Property Type',
                                    txtvalue:
                                        '${widget.list[index]['property_type_name'] ?? ""}',
                                    validator: true,
                                    value: (value) {
                                      setState(() {
                                        customerproperty = int.parse(value);
                                      });
                                    },
                                    list: hometypeList,
                                    valuedropdown: 'property_type_id',
                                    valuetxt: 'property_type_name',
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '*',
                                    lable: 'Size',
                                    txtvalue:
                                        '${widget.list[index]['customersize'] ?? ""}',
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customersize = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '*',
                                    lable: 'Building Size',
                                    txtvalue:
                                        '${widget.list[index]['customerBuildSize'] ?? ""}',
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerBuildSize = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Property Location', ' *'),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '*',
                                    lable: 'Property Location',
                                    txtvalue:
                                        '${widget.list[index]['customerpropertyaddress'] ?? ""}',
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerpropertyaddress = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '',
                                    lable: 'Province',
                                    txtvalue:
                                        '${widget.list[index]['provinces_name'] ?? ""}',
                                    validator: false,
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
                                  ),
                                  sizebox10h,
                                  (addmore)
                                      ? const SizedBox()
                                      : DropDownRowtxt(
                                          star: '',
                                          lable: 'District',
                                          txtvalue:
                                              '${widget.list[index]['district_name'] ?? ""}',
                                          validator: false,
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
                                        ),
                                  sizebox10h,
                                  (addmore)
                                      ? const SizedBox()
                                      : DropDownRowtxt(
                                          star: '',
                                          lable: 'Commune',
                                          txtvalue:
                                              '${widget.list[index]['commune_name'] ?? ""}',
                                          validator: false,
                                          value: (value) {
                                            setState(() {
                                              customerpropertycommune =
                                                  int.parse(value);
                                            });
                                          },
                                          list: controller.communeList,
                                          valuedropdown: 'commune_id',
                                          valuetxt: 'commune_name',
                                        ),
                                  sizebox10h,
                                  // filedtexts('Registered By', ' *'),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '*',
                                    lable: 'Register By',
                                    txtvalue:
                                        '${widget.list[index]['assiigned_name'] ?? ""}',
                                    validator: true,
                                    value: (value) {
                                      setState(() {
                                        customerregistered = int.parse(value);
                                      });
                                    },
                                    list: assiignedList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'assiigned_name',
                                  ),
                                  sizebox10h,
                                  InputDateRowtxt(
                                    star: '',
                                    lable: 'Date',
                                    txtvalue:
                                        '${widget.list[index]['customerdate'] ?? ""}',
                                    validator: false,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerdate = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '',
                                    lable: 'Case',
                                    txtvalue:
                                        '${widget.list[index]['valuationtype_name'] ?? ""}',
                                    validator: true,
                                    value: (value) {
                                      setState(() {
                                        customercasefrom = int.parse(value);
                                      });
                                    },
                                    list: valutionList,
                                    valuedropdown: 'valuationtype_id',
                                    valuetxt: 'valuationtype_name',
                                  ),
                                  sizebox10h,
                                  // filedtexts('Bank', ' *'),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '*',
                                    lable: 'Select bank',
                                    txtvalue:
                                        '${widget.list[index]['bank_name'] ?? ""}',
                                    validator: true,
                                    value: (value) {
                                      setState(() {
                                        customerbanknameid = int.parse(value);
                                        branchlist(value);
                                      });
                                    },
                                    list: bankList,
                                    valuedropdown: 'bank_id',
                                    valuetxt: 'bank_name',
                                  ),
                                  sizebox10h,
                                  (addmore)
                                      ? const SizedBox()
                                      : DropDownRowtxt(
                                          star: '',
                                          lable: 'Select Branch',
                                          txtvalue:
                                              '${widget.list[index]['bank_name'] ?? ""}',
                                          validator: false,
                                          value: (value) {
                                            setState(() {
                                              customerbankbranchid =
                                                  int.parse(value);
                                            });
                                          },
                                          list: controllerdown.branchList,
                                          valuedropdown: 'bank_branch_id',
                                          valuetxt: 'bank_branch_name',
                                        ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Bank Officer Name',
                                    txtvalue:
                                        '${widget.list[index]['bank_branch_name'] ?? ""}',
                                    validator: false,
                                    readOnly: true,
                                    value: (value) {
                                      setState(() {
                                        officername = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Bank Officer Tell',
                                    txtvalue:
                                        "${widget.list[index]['office_tell'] ?? ""}",
                                    validator: false,
                                    readOnly: true,
                                    value: (value) {
                                      setState(() {
                                        officetell = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,

                                  sizebox10h,
                                  // filedtexts('Total Fee Charge', ' *'),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '*',
                                    lable: 'Total Fee Charge',
                                    txtvalue:
                                        "${widget.list[index]['customerservicecharge'] ?? ""}",
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
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 3,
                                        child: SizedBox(),
                                      ),
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
                                  // filedtexts('First Pay', ''),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'First Pay',
                                    txtvalue:
                                        "${widget.list[index]['customerservicechargePaid'] ?? ""}",
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
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'OR N',
                                    txtvalue:
                                        "${widget.list[index]['customerorn'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerorn = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputDateRowtxt(
                                    star: '',
                                    lable: 'Date Pay',
                                    txtvalue:
                                        "${widget.list[index]['date_dayment'] ?? ""}",
                                    validator: false,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        datedayment = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Invoice',
                                    txtvalue:
                                        "${widget.list[index]['customerInvoice'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerInvoice = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Paid by',
                                    txtvalue:
                                        "${widget.list[index]['paid_by'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        paidby = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Final Pay', ''),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Final Pay',
                                    txtvalue:
                                        "${widget.list[index]['second_payment'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        secondpayment = value;
                                        secondpayments = double.parse(value);
                                        receivable();
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'OR N',
                                    txtvalue:
                                        "${widget.list[index]['customerorns'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerorns = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputDateRowtxt(
                                    lable: 'Date Pay',
                                    star: '',
                                    txtvalue:
                                        "${widget.list[index]['second_date_payment'] ?? ""}",
                                    validator: false,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        seconddatepayment = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Invoice',
                                    txtvalue:
                                        "${widget.list[index]['customerInvoices'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerInvoices = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Paid by',
                                    txtvalue:
                                        "${widget.list[index]['paid_bys'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        paidbys = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Inspector Name', ''),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Inspector Name',
                                    txtvalue:
                                        "${widget.list[index]['customerinstructorname'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerinstructorname = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Instructor Tell',
                                    txtvalue:
                                        "${widget.list[index]['customerinstructortel'] ?? ""}",
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerinstructortel = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '',
                                    lable: 'Appraiser',
                                    txtvalue:
                                        '${widget.list[index]['Appraiser_name'] ?? ""}',
                                    validator: false,
                                    value: (value) {
                                      setState(() {
                                        appraiser = value;
                                      });
                                    },
                                    list: appraiserList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Appraiser_name',
                                  ),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '',
                                    lable: 'Accompany by',
                                    txtvalue:
                                        '${widget.list[index]['Accompany_by_name'] ?? ""}',
                                    validator: false,
                                    value: (value) {
                                      setState(() {
                                        accompany = int.parse(value);
                                      });
                                    },
                                    list: accompanyList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Accompany_by_name',
                                  ),
                                  sizebox10h,
                                  // filedtexts('Start Date', ' *'),
                                  sizebox10h,
                                  InputDateRowtxt(
                                    lable: 'Start Date',
                                    star: '*',
                                    txtvalue:
                                        '${widget.list[index]['customerstartdate'] ?? ""}',
                                    validator: true,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerstartdate = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  InputDateRowtxt(
                                    lable: 'End Date',
                                    star: '*',
                                    txtvalue:
                                        '${widget.list[index]['customerenddate'] ?? ""}',
                                    validator: true,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerenddate = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Inspector Name', ' *'),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '*',
                                    lable: 'Inspector Name',
                                    txtvalue:
                                        '${widget.list[index]['Inspector_name'] ?? ""}',
                                    validator: true,
                                    value: (value) {
                                      setState(() {
                                        customerinspector = int.parse(value);
                                      });
                                    },
                                    list: inspectorList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Inspector_name',
                                  ),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '',
                                    lable: 'Inspectors Name',
                                    txtvalue:
                                        '${widget.list[index]['Inspectors_name'] ?? ""}',
                                    validator: false,
                                    value: (value) {
                                      setState(() {
                                        customerinspectors = int.parse(value);
                                      });
                                    },
                                    list: inspectorsList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'Inspectors_name',
                                  ),
                                  sizebox10h,
                                  InputDateRowtxt(
                                    lable: 'Inspecting Date',
                                    star: '*',
                                    txtvalue:
                                        '${widget.list[index]['customerinspectingdate'] ?? ""}',
                                    validator: true,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerinspectingdate = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Assigned By', ' *'),
                                  sizebox10h,
                                  DropDownRowtxt(
                                    star: '*',
                                    lable: 'Assigned By',
                                    txtvalue:
                                        '${widget.list[index]['assiigned_name'] ?? ""}',
                                    validator: true,
                                    value: (value) {
                                      setState(() {
                                        customerassigned = int.parse(value);
                                      });
                                    },
                                    list: assiignedList,
                                    valuedropdown: 'person_id',
                                    valuetxt: 'assiigned_name',
                                  ),
                                  sizebox10h,
                                  InputDateRowtxt(
                                    star: '',
                                    lable: 'Assigned Date',
                                    txtvalue:
                                        '${widget.list[index]['customerassigneddate'] ?? ""}',
                                    validator: false,
                                    flex: 6,
                                    value: (value) {
                                      setState(() {
                                        customerassigneddate = value;
                                      });
                                    },
                                  ),
                                  sizebox10h,
                                  // filedtexts('Remark', ''),
                                  sizebox10h,
                                  InputfiedRowtxt(
                                    star: '',
                                    lable: 'Remark',
                                    txtvalue:
                                        '${widget.list[index]['customerremark'] ?? ""}',
                                    validator: false,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        customerremark = value;
                                      });
                                    },
                                  ),
                                  sizebox40h,
                                  //Image Customer

                                  filedtexts('Your Image', '', context),
                                  sizebox10h,
                                  sizebox10h,
                                  waitImage
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : SizedBox(
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
                                                      i < imageList.length;
                                                      i++)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      child: SizedBox(
                                                        height: 100,
                                                        width: 200,
                                                        child: Stack(children: [
                                                          Image.network(
                                                            imageList[i]['url']
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    listdeleted.add(imageList[index]
                                                                            [
                                                                            'customerradom']
                                                                        .toString());

                                                                    imageList
                                                                        .removeAt(
                                                                            i);
                                                                  });
                                                                },
                                                                child: const CircleAvatar(
                                                                    radius: 15,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    child: Icon(
                                                                        Icons
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
                                  filedtexts('Images', '*', context),
                                  sizebox10h,
                                  sizebox10h,
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
                                                              // listdeleted.add(widget
                                                              //     .list[
                                                              //         index]
                                                              //         [
                                                              //         'customerradom']
                                                              //     .toString());

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
                                      Expanded(
                                          flex: 3,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Images',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        11),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                '*',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        11),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: InkWell(
                                            onTap: () {
                                              openImage();
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: const Text(
                                                    'Choose File Images')),
                                          ))
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
                                      sizebox,
                                      InkWell(
                                        onTap: () async {
                                          // if (listdeleted.isNotEmpty) {
                                          //   maindelete();
                                          // }
                                          // if (selectedImages.isNotEmpty) {
                                          //   // await mainmutiple(widget.list[index]
                                          //   //         ['customer_id']
                                          //   //     .toString());
                                          // }
                                          // await editCustomer(widget.list[index]
                                          //         ['customer_id']
                                          //     .toString());

                                          if (formKey.currentState!
                                              .validate()) {
                                            if (selectedImages.isNotEmpty) {
                                              await postvalueImage(widget
                                                  .list[index]['customer_id']
                                                  .toString());
                                            } else {
                                              setState(() {
                                                typeoption = true;
                                              });
                                              await posts(widget.list[index]
                                                      ['customer_id']
                                                  .toString());
                                            }
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
                                  titletext('Customer Information', context),
                                  sizebox40h,
                                  // Customer Name *
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Customer Name', ' *', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            addmore
                                                ? const SizedBox()
                                                : DropDowntxt(
                                                    txtvalue:
                                                        '${listmorecustomer[0]['gendername'] ?? ""}',
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
                                                  ),
                                            sizebox,
                                            Inputfiedtxt(
                                                txtvalue:
                                                    '${widget.list[index]['customerengname'] ?? ""}',
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
                                      sizeboxw20,
                                      filedtextRight('In Khmer', '', context),
                                      sizebox,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Contact By', '', context),
                                      SizedBox(
                                        width: w,
                                        child: InputfiedRowtxts(
                                            validator: false,
                                            readOnly: false,
                                            value: (value) {
                                              setState(() {
                                                customerContactBys = value;
                                              });
                                            },
                                            txtvalue:
                                                '${widget.list[index]['customerContactBys'] ?? ""}',
                                            filedName: 'Contact By',
                                            flex: 3),
                                      ),
                                      sizeboxw20,
                                      filedtextRight('VAT TIN', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: InputfiedRowtxts(
                                            txtvalue:
                                                '${widget.list[index]['customervat'] ?? ""}',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext(
                                          'Property Guide Name', '', context),
                                      SizedBox(
                                        width: w,
                                        child: InputfiedRowtxts(
                                            txtvalue:
                                                '${widget.list[index]['customercontactname'] ?? ""}',
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
                                      sizeboxw20,
                                      filedtextRight('Tel', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: InputfiedRowtxts(
                                            txtvalue:
                                                '${widget.list[index]['customerphones'] ?? ""}',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Property Type', ' *', context),
                                      SizedBox(
                                        width: w,
                                        child: DropDownRowtxts(
                                            txtvalue:
                                                '${widget.list[index]['property_type_name'] ?? ""}',
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
                                      sizeboxw20,
                                      filedtextRight('Size', ' *', context),
                                      sizebox,
                                      SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              Inputfiedtxt(
                                                  txtvalue:
                                                      '${widget.list[index]['customersize'] ?? ""}',
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
                                              Inputfiedtxt(
                                                  txtvalue:
                                                      '${widget.list[index]['customerBuildSize'] ?? ""}',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext(
                                          'Property Location', ' *', context),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: w,
                                            child: Row(
                                              children: [
                                                Inputfiedtxt(
                                                    txtvalue:
                                                        '${widget.list[index]['customerpropertyaddress'] ?? ""}',
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
                                                addmore
                                                    ? const SizedBox()
                                                    : DropDowntxt(
                                                        txtvalue:
                                                            '${listmorecustomer[0]['provinces_name'] ?? ""}',
                                                        validator: false,
                                                        flex: 3,
                                                        value: (value) {
                                                          setState(() {
                                                            customerpropertyprovince =
                                                                int.parse(
                                                                    value);

                                                            districtlist(value);
                                                          });
                                                        },
                                                        list: provinceList,
                                                        valuedropdown:
                                                            'provinces_id',
                                                        valuetxt:
                                                            'provinces_name',
                                                      ),
                                              ],
                                            ),
                                          ),
                                          sizeboxw20,
                                          filedtextRight('', '', context),
                                          sizebox,
                                          SizedBox(
                                            width: w,
                                            child: Row(
                                              children: [
                                                (addmore)
                                                    ? const SizedBox()
                                                    : DropDowntxt(
                                                        txtvalue:
                                                            '${listmorecustomer[0]['district_name'] ?? ""}',
                                                        validator: false,
                                                        flex: 3,
                                                        value: (value) {
                                                          setState(() {
                                                            customerpropertydistrict =
                                                                int.parse(
                                                                    value);
                                                            communelist(value);
                                                          });
                                                        },
                                                        list: controller
                                                            .districtList,
                                                        valuedropdown:
                                                            'district_id',
                                                        valuetxt:
                                                            'district_name',
                                                      ),
                                                sizebox,
                                                (addmore)
                                                    ? const SizedBox()
                                                    : DropDowntxt(
                                                        txtvalue:
                                                            '${widget.list[index]['commune_name'] ?? ""}',
                                                        validator: false,
                                                        flex: 3,
                                                        value: (value) {
                                                          setState(() {
                                                            customerpropertycommune =
                                                                int.parse(
                                                                    value);
                                                          });
                                                        },
                                                        list: controller
                                                            .communeList,
                                                        valuedropdown:
                                                            'commune_id',
                                                        valuetxt:
                                                            'commune_name',
                                                      ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Registered By', ' *', context),
                                      SizedBox(
                                        width: w,
                                        child: DropDownRowtxts(
                                            txtvalue:
                                                '${widget.list[index]['assiigned_name'] ?? ""}',
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
                                      sizeboxw20,
                                      filedtextRight('Date', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            InputDateNowtxt(
                                              txtvalue:
                                                  '${widget.list[index]['customerdate'] ?? ""}',
                                              flex: 3,
                                              value: (value) {
                                                setState(() {
                                                  customerdate = value;
                                                });
                                              },
                                            ),
                                            sizebox,
                                            DropDowntxt(
                                              txtvalue:
                                                  '${widget.list[index]['valuationtype_name'] ?? ""}',
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
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  sizebox10h,
                                  //Bank
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Bank', ' *', context),
                                      SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              (addmore)
                                                  ? const SizedBox()
                                                  : DropDowntxt(
                                                      txtvalue:
                                                          '${listmorecustomer[0]['bank_name'] ?? ""}',
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
                                                    ),
                                              sizebox,
                                              (addmore)
                                                  ? const Center(
                                                      child: SizedBox())
                                                  : DropDowntxt(
                                                      txtvalue:
                                                          "${listmorecustomer[0]['bank_branch_name'] ?? ""}",
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
                                                    ),
                                            ],
                                          )),
                                      sizeboxw20,
                                      filedtextRight('', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Inputfiedtxt(
                                                txtvalue:
                                                    '${widget.list[index]['officer_name'] ?? ""}',
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
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['office_tell'] ?? ""}",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext(
                                          'Total Fee Charge', ' *', context),
                                      SizedBox(
                                          width: w,
                                          child: InputfiedRowtxts(
                                              txtvalue:
                                                  "${widget.list[index]['customerservicecharge'] ?? ""}",
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
                                      sizeboxw20,
                                      filedtextRight('Account Receivable (A/R)',
                                          '', context),
                                      sizebox,
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
                                                    prefixIcon: const SizedBox(
                                                        width: 7),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('First Pay', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['customerservicechargePaid'] ?? ""}",
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
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['customerorn'] ?? ""}",
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
                                            InputDatetxt(
                                              txtvalue:
                                                  "${widget.list[index]['date_dayment'] ?? ""}",
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
                                      sizeboxw20,
                                      filedtextRight('Date pay', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['customerInvoice'] ?? ""}",
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
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['paid_by'] ?? ""}",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Final Pay', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['second_payment'] ?? ""}",
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
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['customerorns'] ?? ""}",
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
                                            InputDatetxt(
                                              txtvalue:
                                                  "${widget.list[index]['second_date_payment'] ?? ""}",
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
                                      sizeboxw20,
                                      filedtextRight('Date pay', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['customerInvoices'] ?? ""}",
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
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['paid_bys'] ?? ""}",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Inspector Name', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['customerinstructorname'] ?? ""}",
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
                                            Inputfiedtxt(
                                                txtvalue:
                                                    "${widget.list[index]['customerinstructortel'] ?? ""}",
                                                validator: false,
                                                readOnly: false,
                                                value: (value) {
                                                  setState(() {
                                                    customerinstructortel =
                                                        value;
                                                  });
                                                },
                                                filedName: 'Instructor Tell',
                                                flex: 3),
                                          ],
                                        ),
                                      ),
                                      sizeboxw20,
                                      filedtextRight('Appraiser', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            DropDowntxt(
                                              txtvalue:
                                                  '${widget.list[index]['Appraiser_name'] ?? ""}',
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
                                            ),
                                            sizebox,
                                            DropDowntxt(
                                              txtvalue:
                                                  '${widget.list[index]['Accompany_by_name'] ?? ""}',
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
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  sizebox10h,
                                  //Start date and EndStart
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Start Date', ' *', context),
                                      SizedBox(
                                        width: w,
                                        child: InputDateRowtxts(
                                          txtvalue:
                                              '${widget.list[index]['customerstartdate'] ?? ""}',
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
                                      sizeboxw20,
                                      filedtextRight('End Date', ' *', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: InputDateRowtxts(
                                          txtvalue:
                                              '${widget.list[index]['customerenddate'] ?? ""}',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext(
                                          'Inspector Name', ' *', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            DropDowntxt(
                                              txtvalue:
                                                  '${widget.list[index]['Inspector_name'] ?? ""}',
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
                                            ),
                                            sizebox,
                                            DropDowntxt(
                                              txtvalue:
                                                  '${widget.list[index]['Inspectors_name'] ?? ""}',
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      sizeboxw20,
                                      filedtextRight('Inspecting', '', context),
                                      sizebox,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Assigned By', ' *', context),
                                      SizedBox(
                                        width: w,
                                        child: DropDownRowtxts(
                                            txtvalue:
                                                '${widget.list[index]['assiigned_name'] ?? ""}',
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
                                      sizeboxw20,
                                      filedtextRight(
                                          'Assigned Date', '', context),
                                      sizebox,
                                      SizedBox(
                                        width: w,
                                        child: InputDateRowtxts(
                                          txtvalue:
                                              '${widget.list[index]['customerassigneddate'] ?? ""}',
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
                                  sizebox40h,
                                  //Remark
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Remark', '', context),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: InputfiedRowtxts(
                                            txtvalue:
                                                '${widget.list[index]['customerremark'] ?? ""}',
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
                                      sizeboxw20,
                                      filedtextRight('', '', context),
                                      sizebox,
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Your Image', '', context),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                      ),
                                      sizeboxw20,
                                      filedtextRight('', '', context),
                                      sizebox,
                                    ],
                                  ),

                                  sizebox40h,
                                  waitImage
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, left: 30),
                                          child: SizedBox(
                                            height: 100,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20, left: 20),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Wrap(
                                                  direction: Axis.vertical,
                                                  children: [
                                                    for (int i = 0;
                                                        i < imageList.length;
                                                        i++)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 20),
                                                        child: SizedBox(
                                                          height: 100,
                                                          width: 200,
                                                          child: Stack(
                                                              children: [
                                                                Image.network(
                                                                  imageList[i][
                                                                          'url']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Spacer(),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          listdeleted
                                                                              .add(imageList[index]['customerradom'].toString());
                                                                          print(
                                                                              listdeleted.toString());
                                                                          imageList
                                                                              .removeAt(i);
                                                                        });
                                                                      },
                                                                      child: const CircleAvatar(
                                                                          radius:
                                                                              15,
                                                                          backgroundColor: Colors
                                                                              .red,
                                                                          child:
                                                                              Icon(Icons.remove_outlined)),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            20)
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
                                        ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Image more', '', context),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                      ),
                                      sizeboxw20,
                                      filedtextRight('', '', context),
                                      sizebox,
                                    ],
                                  ),
                                  sizebox40h,
                                  if (selectedImages.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 30, left: 30),
                                      child: SizedBox(
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
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              child: const CircleAvatar(
                                                                  radius: 15,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
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
                                    ),
                                  sizebox10h,
                                  sizebox10h,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      filedtext('Images', ' *', context),
                                      InkWell(
                                          onTap: () {
                                            openImage();
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: 35,
                                              width: w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: greyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Text(
                                                  'Choose File Images'))),
                                      sizeboxw20,
                                      filedtextRight('', '', context),
                                      sizebox,
                                      SizedBox(width: w),
                                    ],
                                  ),
                                  sizebox40h,
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ));
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
      Uint8List compressedImage = await compressList(image);
      compressedImages.add(compressedImage);
    }
    return compressedImages;
  }

  Future<Uint8List> compressList(Uint8List image) async {
    var result = await FlutterImageCompress.compressWithList(
      image,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );

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

  String imageUrl = '';
  Uint8List? getbytes;
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
      getbytes = Uint8List.fromList(bytes);
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
