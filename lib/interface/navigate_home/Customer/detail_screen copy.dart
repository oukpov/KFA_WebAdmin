// ignore_for_file: unused_element, unused_local_variable, unused_field, equal_keys_in_map, unnecessary_null_comparison, must_be_immutable, body_might_complete_normally_nullable
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../api/contants.dart';
import '../../../components/date_customer.dart';
import '../../../components/first_pay.dart';
import '../../../components/property_type.dart';
import '../../../components/province.dart';
import '../../../screen/Profile/components/Drop.dart';
import '../../../screen/Property/Map/map_in_add_verbal.dart';

class Detail_Customer extends StatefulWidget {
  Detail_Customer({super.key, required this.index, required this.list});
  List list;
  String? index;

  @override
  State<Detail_Customer> createState() => _new_customerState();
}

class _new_customerState extends State<Detail_Customer> {
  int index_p = 0;
  TextEditingController start_date = TextEditingController();
  TextEditingController end_date = TextEditingController();
  TextEditingController assigndate = TextEditingController();
  TextEditingController todate = TextEditingController();
  TextEditingController Inspecting_date = TextEditingController();
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  TextEditingController _controllerC = TextEditingController();
  TextEditingController _controllerD = TextEditingController();

  @override
  void initState() {
    index_p = int.parse(widget.index.toString());
    Gender_dropdown();
    todate.text = "";
    _controllerA.dispose();
    _controllerB.dispose();
    _controllerC.dispose();
    // ARF_last_ID();
    Registered_By();
    today_formart();
    _name();
    ////Edit
    lat = widget.list[index_p]['lat'].toString();
    log = widget.list[index_p]['log'].toString();
    image_map = widget.list[index_p]['image_map'].toString();
    province_map = widget.list[index_p]['province_map'].toString();
    district_map = widget.list[index_p]['district_map'].toString();
    cummune_map = widget.list[index_p]['cummune_map'].toString();

    ///

    _controllerC = TextEditingController(
        text: '${widget.list[index_p]['second_payment']}');
    second_payment = widget.list[index_p]['second_payment'].toString();

    _controllerA = TextEditingController(
        text: '${widget.list[index_p]['customerservicecharge']}');
    customerservicecharge =
        widget.list[index_p]['customerservicecharge'].toString();

    customergender = widget.list[index_p]['customergender'].toString();
    _ARF_code =
        TextEditingController(text: '${widget.list[index_p]['customercode']}');
    ARF_code = _ARF_code!.text;
    customerprovince_id =
        widget.list[index_p]['customerpropertyprovince'].toString();
    customerdistrict_id =
        widget.list[index_p]['customerpropertydistrict'].toString();
    customercommune_id =
        widget.list[index_p]['customerpropertycommune'].toString();

    customerproperty = widget.list[index_p]['customerproperty'].toString();
    customerregistered = widget.list[index_p]['customerregistered'].toString();
    customerdatetotal = widget.list[index_p]['customerdatetotal'].toString();
    customerservicecharge =
        widget.list[index_p]['customerservicecharge'].toString();
    date_dayment = widget.list[index_p]['date_dayment'].toString();
    second_date_payment =
        widget.list[index_p]['second_date_payment'].toString();
    customerstartdate = widget.list[index_p]['customerstartdate'].toString();
    customerenddate = widget.list[index_p]['customerenddate'].toString();

    customerpropertybankname =
        widget.list[index_p]['customerpropertybankname'].toString();
    customerpropertybankbranch =
        widget.list[index_p]['customerpropertybankbranch'].toString();
    customerinspector = widget.list[index_p]['customerinspector'].toString();
    customerinspectors = widget.list[index_p]['customerinspectors'].toString();

    customerinspectingdate =
        widget.list[index_p]['customerinspectingdate'].toString();
    customerassigned = widget.list[index_p]['customerassigned'].toString();
    customerassigneddate =
        widget.list[index_p]['customerassigneddate'].toString();
    customercasefrom = widget.list[index_p]['customercasefrom'].toString();
    accompany = widget.list[index_p]['accompany'].toString();
    second_payment = widget.list[index_p]['second_payment'].toString();

    _customerengname = TextEditingController(
        text: '${widget.list[index_p]['customerengname']}');
    customerengname = _customerengname!.text;
    //////

    _customervat =
        TextEditingController(text: '${widget.list[index_p]['customervat']}');
    customervat = _customervat!.text;
    _customerphones = TextEditingController(
        text: '${widget.list[index_p]['customercontactbys']}');
    customerphones = _customerphones!.text;

    _customersizeother = TextEditingController(
        text: '${widget.list[index_p]['customersizeother']}');
    customersizeother = _customersizeother!.text;

    _customerpropertyaddress = TextEditingController(
        text: '${widget.list[index_p]['customerpropertyaddress']}');
    customerpropertyaddress = _customerpropertyaddress!.text;

    _paid_by =
        TextEditingController(text: '${widget.list[index_p]['paid_by']}');
    paid_by = _paid_by!.text;

    _first_paymen = TextEditingController(
        text: '${widget.list[index_p]['customerservicechargePaid']}');
    first_payment = _first_paymen!.text;

    _paid_bys =
        TextEditingController(text: '${widget.list[index_p]['paid_bys']}');
    paid_bys = _paid_bys!.text;

    _customerservicechargeunpaid = TextEditingController(
        text: '${widget.list[index_p]['customerservicechargeunpaid']}');
    customerservicechargeunpaid = _customerservicechargeunpaid!.text;

    _customerappraisalname = TextEditingController(
        text: '${widget.list[index_p]['customerappraisalname']}');
    customerappraisalname = _customerappraisalname!.text;
    _customerremark = TextEditingController(
        text: '${widget.list[index_p]['customerremark']}');
    customerremark = _customerremark!.text;

    _customerorn =
        TextEditingController(text: '${widget.list[index_p]['customerorn']}');
    customerorn = _customerorn!.text;

    _customerorns =
        TextEditingController(text: '${widget.list[index_p]['customerorns']}');
    customerorns = _customerorns!.text;

    _customerBuildSize = TextEditingController(
        text: '${widget.list[index_p]['customerBuildSize']}');
    customerBuildSize = _customerBuildSize!.text;

    _CustomerInvoice = TextEditingController(
        text: '${widget.list[index_p]['CustomerInvoice']}');
    CustomerInvoice = _CustomerInvoice!.text;

    _CustomerInvoices = TextEditingController(
        text: '${widget.list[index_p]['CustomerInvoices']}');
    CustomerInvoices = _CustomerInvoices!.text;

    _officer_name =
        TextEditingController(text: '${widget.list[index_p]['officer_name']}');
    officer_name = _officer_name!.text;

    _office_tell =
        TextEditingController(text: '${widget.list[index_p]['office_tell']}');
    office_tell = _office_tell!.text;

    _status = TextEditingController(
        text: '${widget.list[index_p]['customer_status']}');
    status = _status!.text;

    _customerinstructorname = TextEditingController(
        text: '${widget.list[index_p]['customerinstructorname']}');
    customerinstructorname = _customerinstructorname!.text;
    _customerinstructortel = TextEditingController(
        text: '${widget.list[index_p]['customerinstructortel']}');
    customerinstructortel = _customerinstructortel!.text;

    ///
    _customercontactname = TextEditingController(
        text: '${widget.list[index_p]['customercontactname']}');
    customercontactname = _customercontactname!.text;
    _customerphoness = TextEditingController(
        text: '${widget.list[index_p]['customerphones']}');
    customerphoness = _customerphoness!.text;

    super.initState();

    fetchImageUrls();
    // _imageUrlsFuture = fetchImageUrls(114);
  }

  String? null_image;
///////////////////Edt
  TextEditingController? _customerphoness;
  TextEditingController? _customercontactname;
  TextEditingController? _customerinstructorname;
  TextEditingController? _customerinstructortel;
  TextEditingController? _ARF_code;
  TextEditingController? _customerengname;
  TextEditingController? _customervat;
  TextEditingController? _customerphones;
  TextEditingController? _customersizeother;

  TextEditingController? _customerpropertyaddress;
  TextEditingController? _paid_by;
  TextEditingController? _first_paymen;
  TextEditingController? _second_payment;
  TextEditingController? _paid_bys;
  TextEditingController? _customerservicechargeunpaid;

  TextEditingController? _customerappraisalname;
  TextEditingController? _customerinspector;
  TextEditingController? _customerinspectors;
  TextEditingController? _customerremark;
  TextEditingController? _customerorn;
  TextEditingController? _customerorns;
  TextEditingController? _customerBuildSize;

  TextEditingController? _CustomerInvoice;
  TextEditingController? _CustomerInvoices;
  TextEditingController? _officer_name;
  TextEditingController? _office_tell;

  TextEditingController? _status;

  ///
  void _updateTotal() {
    int a = int.tryParse(_controllerA.text) ?? 0;
    int b = int.tryParse(_controllerB.text) ?? 0;
    int c = int.tryParse(_controllerC.text) ?? 0;
    setState(() {
      customerservicecharge = a.toString();
      var total = a - b - c;
      Total_Fee_dok = total.toString();
      first_payment = b.toString();
      second_payment = c.toString();
      customerservicechargeunpaid = Total_Fee_dok;
      _controllerD = TextEditingController(text: '$total');
    });
  }

  void delete_Comparable() async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete_image/${widget.list[index_p]['customer_code_num']}'));
    if (response.statusCode == 200) {
      setState(() {});
    } else {
      throw Exception('Delete error occured!');
    }
  }

  String? ARF_code;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TextEditingController? _Account_Receivable;
  List mr = [
    {
      'numer_id': 1,
      'type': 'Dr.',
    },
    {
      'numer_id': 2,
      'type': 'Miss.',
    },
    {
      'numer_id': 3,
      'type': 'Mr.',
    },
    {
      'numer_id': 4,
      'type': 'Mrs.',
    }
  ];

  List cases = [
    {
      'numer_id': '1',
      'type': '',
    },
    {
      'numer_id': '2',
      'type': 'private',
    },
    {
      'numer_id': '3',
      'type': 'Bank',
    },
  ];
  List option = const [
    "Contact By",
    "Property Guide Name",
  ];
  List bank = const [
    "Bank Officer Name",
    "Bank Officer Tell",
  ];

  String? formattedDate;
  void today_formart() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  // void yyy_formart() {
  //   DateTime now = DateTime.now();
  //   yyy = DateFormat('yy').format(now);

  //   ARF_code = 'ARF$yyy-$ARF_ID_GET';
  // }

  String? yyy;

  String? name_customer;
  String? property_type;
  List<Icon> optionIconList = const [
    Icon(
      Icons.contact_emergency,
      color: kImageColor,
    ),
    Icon(
      Icons.near_me,
      color: kImageColor,
    ),
  ];

  List<Icon> bank_branch = const [
    Icon(
      Icons.account_balance,
      color: kImageColor,
    ),
    Icon(
      Icons.near_me,
      color: kImageColor,
    ),
  ];
  String? status;
  String? lat;

  String? log;
  String? image_map;
  String? province_map;
  String? district_map;
  String? cummune_map;
  //SELECT * FROM `customer_models` WHERE `customercode`='ARF20-0167';
  String? customergender;
  String? customercode;
  String? customerengname;
  String? customerphones;
  String? customersizeother;
  String? customerBuildSize;
  String? customerprovince_id;
  String? customerdistrict_id;
  String? customercommune_id;
  String? customercontactbys;
  String? customerproperty;
  String? customerpropertyaddress;
  String? customerpropertybankname;
  String? customerpropertybankbranch;
  String? officer_name;
  String? office_tell;
  String? customerservicecharge;
  String? customerservicechargeunpaid;
  String? first_payment;
  String? second_payment;
  String? customerorn;
  String? customerorns;
  String? CustomerInvoice;
  String? CustomerInvoices;
  String? paid_by;
  String? paid_bys;
  String? customerstartdate;
  String? customerenddate;
  String? customerinspectingdate;
  String? customerremark;
  String? customercasefrom;
  String? customerdatetotal;
  String? customervat;
  String? customerassigneddate;
  String? second_date_payment;
  String? date_dayment;
  String? customerregistered;
  String? customerinspectors;
  String? customerinspector;
  String? customerassigned;
  String? customerappraisalname;
  String? accompany;
  String? customerinstructorname;
  String? customerinstructortel;
  String? customerphoness;
  String? customercontactname;
  void Edit_Customer() async {
    Map<String, dynamic> payload = await {
      'customergender': customergender.toString(),
      'customercode': widget.list[index_p]['customercode'].toString(),
      'customer_code_num': widget.list[index_p]['customer_code_num'].toString(),
      'customerengname': customerengname.toString(),
      'customerkhmname': '',
      'customerbirthdate': formattedDate.toString(),
      'customermarital_id': null,
      'customermarital': formattedDate.toString(),
      'customernationally_id': null,
      'customeroccupation_id': null,
      'customerinformationsource_id': null,
      'customerinformationsources': null,
      'customercontactby_id': null,
      'customercontactbys': (customerphones == '') ? '' : customerphones,
      'customervat': (customervat == '') ? '' : customervat.toString(),
      'customerbankname_id': null,
      'customerbankbranch_id': null,
      'customerbankaccount': null,
      'customerphone': null,
      'customerphones': (customerphones == '') ? '' : customerphones.toString(),
      'customeremail': null,
      'customeremails': null,
      'customeraddress': null,
      'customerprovince_id': null,
      'customerdistrict_id': null,
      '	customercommune_id': null,

      ///11111111///////////////////////////////////////////////////////////////////////////////////////
      'customercontactname':
          (customercontactname == '') ? '' : customercontactname.toString(),
      'customerproperty': 1111,
      'customersize':
          (customersizeother == 'null') ? null : customersizeother.toString(),
      'customersizeother': null,
      'customerpropertyaddress': (customerpropertyaddress == '')
          ? ''
          : customerpropertyaddress.toString(),
      'customerpropertyprovince': (customerprovince_id == 'null')
          ? null
          : int.parse(customerprovince_id.toString()),
      'customerpropertydistrict': (customerdistrict_id == 'null')
          ? null
          : int.parse(customerdistrict_id.toString()),
      'customerpropertycommune': (customercommune_id == 'null')
          ? null
          : int.parse(customercommune_id.toString()),
      'customerregistered': (customerregistered == 'null')
          ? null
          : int.parse(customerregistered.toString()),
      'customerdate': formattedDate.toString(),
      'customerservicecharge': (customerservicecharge == 'null')
          ? null
          : customerservicecharge.toString(),
      'date_dayment': (date_dayment == 'null') ? null : date_dayment.toString(),
      'first_payment': null,
      'paid_by': (paid_by == 'null') ? null : paid_by.toString(),
      'customerservicechargePaid':
          (first_payment == '') ? '' : first_payment.toString(),
      'second_date_payment': (second_date_payment == 'null')
          ? null
          : second_date_payment.toString(),
      'second_payment':
          (second_payment == '') ? '0' : second_payment.toString(),
      'paid_bys': (paid_bys == '') ? '0' : paid_bys.toString(),
      ///////////22222222222///////////////////////////////////////////////////////////////////////////////
      'customerservicechargeunpaid': (customerservicechargeunpaid == '0')
          ? '0'
          : customerservicechargeunpaid.toString(),
      'customerchargeFrom': null,
      'customerappraisalfor': null,
      'customerappraisalfrom': null,
      'customerappraisalname': (customerappraisalname == 'null')
          ? null
          : customerappraisalname.toString(),
      /////////////33333333333333/////////////////////////////////////////////////////////////////////////////
      'customerappraisaltel': null,
      'customerappraisallandguardname': null,
      'customerappraisallandguardtel': null,
      //date
      'customerstartdate':
          (customerstartdate == 'null') ? null : customerstartdate.toString(),
      'customerenddate':
          (customerenddate == 'null') ? null : customerenddate.toString(),
      'customerdatetotal': (customerdatetotal == 'null')
          ? null
          : double.parse(customerdatetotal.toString()),
      'customersendto': null,
/////////////////////**********//////////////////////// */
      'customerpropertyowner': null,
      'customerpropertybankname': (customerpropertybankname == 'null')
          ? null
          : int.parse(customerpropertybankname.toString()),
      'customerpropertybankbranch': (customerpropertybankbranch == 'null')
          ? null
          : int.parse(customerpropertybankbranch.toString()),
      'customerinspector': (customerinspector == 'null')
          ? null
          : int.parse(customerinspector.toString()),
      'customerinspectors': (customerinspectors == 'null')
          ? null
          : int.parse(customerinspectors.toString()),
      'customerinspectingdate': (customerinspectingdate == 'null')
          ? null
          : customerinspectingdate.toString(),
      'customerassigned': (customerassigned == 'null')
          ? null
          : int.parse(customerassigned.toString()),
      'customerassigneddate': (customerassigneddate == 'null')
          ? null
          : customerassigneddate.toString(),
      /////////////////////44444444444444444/////////////////////////////////////////////////////////////////////
      'customer_status': (status == 'null') ? 1 : int.parse(status.toString()),
      'customerreference': null,
      'customerreferencename': null,
      'customerreferencephone': null,
      'customerreferred': null,
      'customerremark': (customerremark == '') ? '' : customerremark.toString(),
      'customerorn': (customerorn == '') ? '' : customerorn.toString(),
      'customerorns': (customerorns == '') ? '' : customerorns.toString(),
      'customerBuildSize':
          (customerBuildSize == '') ? '' : customerBuildSize.toString(),
      'CustomerInvoice':
          (CustomerInvoice == '') ? '' : CustomerInvoice.toString(),
      'CustomerInvoices':
          (CustomerInvoices == '') ? '' : CustomerInvoices.toString(),
      'customerinstructorname': (customerinstructorname == '')
          ? ''
          : customerinstructorname.toString(),
      'customerinstructortel':
          (customerinstructortel == '') ? '' : customerinstructortel.toString(),
      'customercasefrom': (customercasefrom == 'null')
          ? null
          : int.parse(customercasefrom.toString()),
      'customervaluationbankmame': null,
      'customervaluationbranchname': null,
      //////////////////////555555555555555555555////////////////////////////////////////////////////////////////////
      'customerreferredtel': null,
      'officer_name': (officer_name == 'null') ? null : officer_name.toString(),
      'office_tell': (office_tell == 'null') ? null : office_tell.toString(),
      'appraiser': null,
      'Unpaid': null,
      'PaidBy': null,
      'accompany':
          (accompany == 'null') ? null : int.parse(accompany.toString()),
      'customer_published': 0,
      'customer_created_by': null,
      'customer_modify_by': null,
      'customer_modify_date': null,
      ///////////////////////
      'province_map': (province_map == '') ? 'null' : province_map.toString(),
      'district_map': (district_map == '') ? 'null' : district_map.toString(),
      'cummune_map': (cummune_map == '') ? 'null' : cummune_map.toString(),
      'lat': (lat == '0') ? 0 : double.parse(lat.toString()),
      'log': (log == '0') ? 0 : double.parse(log.toString()),
      'image_map': (lat == '0')
          ? 'null'
          : 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$log&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer_Edit/${widget.list[index_p]['customer_id'].toString()}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success Edit Customer');
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Save Successfully',
          autoHide: Duration(seconds: 3),
          onDismissCallback: (type) {
            setState(() {
              // ARF_ID();
              Navigator.pop(context);
            });
          }).show();
    } else {
      showConfirmationBottomSheet();
    }
  }

  List data = [];
  List<String> _imageUrls = [];
  bool _isLoading = true;
  Future<void> fetchImageUrls() async {
    final response = await http.get(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer_customer_search/${widget.list[index_p]['customer_code_num'].toString()}'),
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      final Map<String, dynamic> imageData = data.first;

      setState(() {
        _imageUrls = [
          imageData['url_1'],
          imageData['url_2'],
          imageData['url_3'],
          imageData['url_4'],
        ];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch image URLs');
    }
  }

  String? start_end;
  String? _case;

  TextEditingController? _log;
  TextEditingController? _lat;

  String? provice_map;

  String? Contact_By;
  String? Total_Fee_;
  String? Total_Fee_dok;
  String? payfirst;
  void delete_customer() async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete_customer/${widget.list[index_p]['customer_id'].toString()}'));
    if (response.statusCode == 200) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      throw Exception('Delete error occured!');
    }
  }

  List<File> _images = [];
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
    //   _images;
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
      _images = files;
    });
  }

  // Future<void> _update_Multiple() async {
  //   final url = Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer_update/${widget.list[index_p]['customer_code_num'].toString()}');

  //   final request = http.MultipartRequest('POST', url);
  //   request.fields['customer_code_num'] =
  //       widget.list[index_p]['customer_code_num'].toString();

  //   if (_images != null) {
  //     final tempDir = await getTemporaryDirectory();
  //     final path = tempDir.path;

  //     List<File> compressedImages = [];

  //     for (int i = 0; i < _images.length; i++) {
  //       var compressedImageFile = await FlutterImageCompress.compressAndGetFile(
  //         _images[i].absolute.path,
  //         '$path/${DateTime.now().millisecondsSinceEpoch}_$i.jpg',
  //         quality: 70,
  //       );

  //       if (compressedImageFile != null) {
  //         compressedImages.add(compressedImageFile);
  //       }
  //     }

  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'image1',
  //         compressedImages[0].path,
  //       ),
  //     );
  //     if (_images.length < 3) {
  //       print('null');
  //     } else {
  //       print('no null');
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'image3',
  //           compressedImages[2].path,
  //         ),
  //       );
  //     }

  //     if (_images.length < 4) {
  //       print('null');
  //     } else {
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'image4',
  //           compressedImages[3].path,
  //         ),
  //       );
  //     }
  //   }

  //   final response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Images uploaded successfully!');
  //   } else {
  //     print('Error uploading images: ${response.reasonPhrase}');
  //   }
  // }

  late Future<List<String>> _imageUrlsFuture;
  List _list_Appraiser = [];

  @override
  Widget build(BuildContext context) {
    var sizefont_map = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.011,
        fontWeight: FontWeight.bold);
    var sizefont = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.015,
        fontWeight: FontWeight.bold);
    var sizehintext = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.013,
        fontWeight: FontWeight.bold);
    var pading = const EdgeInsets.only(
      left: 30,
      right: 30,
      bottom: 10,
    );
    var pading_t = EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10);
    var pading_bt = EdgeInsets.only(left: 30, right: 30);
    var pading_b = EdgeInsets.only(left: 30, right: 30, top: 10);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: Text('${widget.list[index_p]['customer_code_num'].toString()}'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              // await _update_Multiple();
              if (_images.length >= 2) {
                // await _update_Multiple();
                Edit_Customer();
                print('Only Edit Image');
              } else {
                Edit_Customer();
                print('Only Edit');
              }

              // update_new();
            },
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 32, 167, 8)),
              child: const Text(
                'Edit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      // Name(customerengname + customergender = )
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GFButton(
                    elevation: 10,
                    color: const Color.fromARGB(255, 137, 10, 35),
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        title: 'Confirmation',
                        desc: 'Are you sure you want to delete this item?',
                        btnOkText: 'Yes',
                        btnOkColor: const Color.fromARGB(255, 72, 157, 11),
                        btnCancelText: 'No',
                        btnCancelColor: const Color.fromARGB(255, 133, 8, 8),
                        btnOkOnPress: () async {
                          if (widget.list[index_p]['image_map'] != null) {
                            delete_customer();
                          } else {
                            delete_customer();
                            delete_Comparable();
                          }
                        },
                        btnCancelOnPress: () {},
                      ).show();
                    },
                    text: "Delete",
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    shape: GFButtonShape.pills,
                  ),
                ),
              ],
            ),
            Padding(
              padding: pading_b,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      //value: genderValue,

                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          customergender = newValue.toString();
                        });
                      },
                      items: _list_getnder
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value["gender_id"].toString(),
                              child: Text(value["gendername"]),
                              onTap: () {
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                      // add extra sugar..
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: kImageColor,
                      ),
                      decoration: InputDecoration(
                        labelStyle: sizefont,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        fillColor: kwhite,
                        filled: true,
                        labelText: (widget.list[index_p]['gendername'] == null)
                            ? 'N/A'
                            : '${widget.list[index_p]['gendername'].toString()}',
                        hintText: (widget.list[index_p]['gendername'] == null)
                            ? 'N/A'
                            : '${widget.list[index_p]['gendername'].toString()}',
                        prefixIcon: const Icon(
                          Icons.discount_outlined,
                          color: kImageColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _customerengname,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          customerengname = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: kImageColor,
                        ),
                        hintText: 'Customer Name*',
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            payment_first(
              Code_AFR: widget.list[index_p]['customercode'].toString(),
              controller1: null,
              controller2: _ARF_code,
              OR_N: '${widget.list[index_p]['customercode'].toString()}',
              hintTexts: 'In Khmer',
              First_Pay: (value) {},
              hintText: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            ////////////tver dol ng tel
            payment_first(
              controller1: _customerphones,
              controller2: _customervat,
              OR_N: 'VAT TIN',
              hintTexts: 'Tel',
              First_Pay: (value) {
                setState(() {
                  customerphones = value.toString();
                });
              },
              hintText: (value) {
                setState(() {
                  customervat = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            payment_first(
              controller1: _customersizeother,
              controller2: _customerBuildSize,
              OR_N: 'Building Size *',
              hintTexts: 'Size *',
              First_Pay: (value) {
                setState(() {
                  customersizeother = value.toString();
                });
              },
              hintText: (value) {
                setState(() {
                  customerBuildSize = value.toString();
                });
              },
            ),

            (_images.length != 0)
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      height: MediaQuery.of(context).size.height * 0.43,
                      width: double.infinity,
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(_images.length, (index) {
                          return Image.file(
                            _images[index],
                            fit: BoxFit.cover,
                          );
                        }),
                      ),
                    ),
                  )
                : (data.length == 0 && _images.length == 0)
                    ? const SizedBox()
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.44,
                          width: double.infinity,
                          child: GridView.count(
                            crossAxisCount: 2, // Number of columns in the grid
                            crossAxisSpacing: 10.0, // Spacing between columns
                            mainAxisSpacing: 10.0, // Spacing between rows
                            children: _imageUrls.map((imageUrl) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Container(
                                          child: FadeInImage.assetNetwork(
                                            placeholderCacheHeight: 120,
                                            placeholderCacheWidth: 120,
                                            placeholderFit: BoxFit.contain,
                                            placeholder: 'assets/earth.gif',
                                            image: imageUrl,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: FadeInImage.assetNetwork(
                                  placeholderCacheHeight: 120,
                                  placeholderCacheWidth: 120,
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.contain,
                                  placeholder: 'assets/earth.gif',
                                  image: imageUrl,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: InkWell(
                onTap: pickImages,
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 47, 22, 157)),
                  child: const Text(
                    'Mutiple Image *',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),

            for (int i = 0; i < option.length; i++)
              Padding(
                padding: pading_b,
                child: Container(
                  child: TextFormField(
                    controller:
                        (i == 0) ? _customerphoness : _customercontactname,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        if (i == 0) {
                          customerphoness = value.toString();
                        } else if (i == 1) {
                          customercontactname = value;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: optionIconList.elementAt(i),
                      hintText: option.elementAt(i).toString(),
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

            const SizedBox(
              height: 10,
            ),
            property_hoemtype(
              hometype: (value) {
                setState(() {
                  customerproperty = value.toString();
                });
              },
              hometype_lable:
                  widget.list[index_p]['property_type_name'].toString(),
            ),
            Padding(
              padding: pading,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  controller: _customerpropertyaddress,
                  onChanged: (value) {
                    setState(() {
                      customerpropertyaddress = value.toString();
                    });
                  },
                  maxLines: 3,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Property Location *',
                  ),
                ),
              ),
            ),
            (widget.list[index_p]['provinces_name'] != null ||
                    widget.list[index_p]['district_name'] != null)
                ? Province_dropdown(
                    cummone_id0:
                        widget.list[index_p]['commune_name'].toString(),
                    district_id0:
                        widget.list[index_p]['district_name'].toString(),
                    province_id0:
                        widget.list[index_p]['provinces_name'].toString(),
                    provicne_id: (value) {
                      setState(() {
                        customerprovince_id = value.toString();
                      });
                    },
                    cummone_id: (value) {
                      setState(() {
                        customercommune_id = value.toString();
                      });
                    },
                    district_id: (value) {
                      setState(() {
                        customerdistrict_id = value.toString();
                      });
                    },
                  )
                : SizedBox(),

            (widget.list[index_p]['lat'] != 0)
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 30, left: 30, bottom: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      width: double.infinity,
                      child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$log&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                          )),
                    ),
                  )
                : SizedBox(),
            (province_map != '' && widget.list[index_p]['lat'] != 0)
                ? InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Map_verbal_address_Sale(
                            get_province: (value) {
                              setState(() {
                                province_map = value.toString();
                              });
                            },
                            get_district: (value) {
                              setState(() {
                                district_map = value.toString();
                              });
                            },
                            get_commune: (value) {
                              setState(() {
                                cummune_map = value.toString();
                              });
                            },
                            get_log: (value) {
                              setState(() {
                                log = value.toString();
                                _log = TextEditingController(text: '${log}');
                                log = _log!.text;
                              });
                            },
                            get_lat: (value) {
                              setState(() {
                                lat = value.toString();
                                _lat = TextEditingController(text: '${lat}');
                                lat = _lat!.text;
                              });
                            },
                          );
                        },
                      ));
                    },
                    child: (district_map != null ||
                            cummune_map != null ||
                            provice_map != null)
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: EdgeInsets.only(
                                right: 30, left: 30, bottom: 10),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 255, 255, 255)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  size: 30,
                                  color: kImageColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('${province_map}', style: sizefont_map),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('/ ${district_map}', style: sizefont_map),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('/ ${cummune_map}', style: sizefont_map),
                              ],
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: EdgeInsets.only(right: 30, left: 30),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 255, 255, 255)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  size: 30,
                                  color: kImageColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'address',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ))
                : SizedBox(),
            (widget.list[index_p]['lat'] != 0)
                ? Padding(
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: _log,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                // bankcontact = value;
                                log = _log!.text;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.numbers_outlined,
                                color: kImageColor,
                              ),
                              hintText: "log",
                              contentPadding: EdgeInsets.symmetric(vertical: 8),

                              fillColor: kwhite,
                              // hintText: (bankcontact == null || bankcontact == '')
                              //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
                              //     : bankcontact,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: _lat,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                // bankcontact = value;
                                lat = _lat!.text;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "lat",
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              prefixIcon: Icon(
                                Icons.numbers_outlined,
                                color: kImageColor,
                              ),
                              fillColor: kwhite,
                              // hintText: (bankcontact == null || bankcontact == '')
                              //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
                              //     : bankcontact,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: pading_bt,
              child: Container(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  //value: genderValue,
                  onChanged: (newValue) {
                    setState(() {
                      customerregistered = newValue.toString();
                    });
                  },
                  value: name_customer,
                  items: _list_Registered_By
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value["person_id"].toString(),
                          child: Text(
                            value["assiigned_name"],
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 13,
                                height: 0.1),
                          ),
                        ),
                      )
                      .toList(),
                  // add extra sugar..
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kImageColor,
                  ),

                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    labelText: 'Registered By *',
                    hintText: 'Registered By ',
                    prefixIcon: Icon(
                      Icons.app_registration_sharp,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: pading_b,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      //value: genderValue,
                      onChanged: (newValue) {
                        setState(() {
                          customercasefrom = newValue.toString();
                        });
                      },
                      value: _case,
                      items: cases
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value["numer_id"].toString(),
                              child: Text(
                                value["type"].toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.textScaleFactorOf(context) *
                                            13,
                                    height: 0.1),
                              ),
                            ),
                          )
                          .toList(),
                      // add extra sugar..
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kImageColor,
                      ),

                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        labelText:
                            (widget.list[index_p]['customercasefrom'] == null)
                                ? 'case'
                                : (customercasefrom == '0')
                                    ? '0'
                                    : (customercasefrom == '1')
                                        ? 'Private'
                                        : 'Bank',
                        hintText: 'case',
                        prefixIcon: Icon(
                          Icons.app_registration_sharp,
                          color: kImageColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      controller: todate, //editing controller of this TextField
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: kImageColor,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ), //icon of text field
                        labelText: "${formattedDate}",
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ), //label text of field
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            todate.text = formattedDate!;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Bank
            BankDropdown(
              bn: widget.list[index_p]['bank_name'].toString(),
              brn: widget.list[index_p]['bank_branch_name'].toString(),
              bank: (value) {
                setState(() {
                  customerpropertybankname = value.toString();
                });
              },
              bankbranch: (value) {
                setState(() {
                  customerpropertybankbranch = value.toString();
                });
              },
            ),
            for (int j = 0; j < bank.length; j++)
              Padding(
                padding: pading,
                child: Container(
                  child: TextFormField(
                    controller: (j == 0) ? _officer_name : _office_tell,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        if (j == 0) {
                          officer_name = value.toString();
                        } else if (j == 1) {
                          office_tell = value.toString();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: bank_branch.elementAt(j),
                      hintText: bank.elementAt(j).toString(),
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: pading_bt,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerA,
                      // controller: _Account_Receivable,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _controllerA = TextEditingController(text: '$value');
                          _updateTotal();
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        prefixIcon: const Icon(
                          Icons.feed_outlined,
                          color: kImageColor,
                        ),
                        hintText: (widget.list[index_p]
                                    ['customerservicecharge'] ==
                                null)
                            ? "Total Fee Charge *"
                            : customerservicecharge,
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      // controller: _controllerD,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        hintText: (widget.list[index_p]
                                    ['customerservicechargeunpaid'] ==
                                null)
                            ? "  Account Receivable (A/R)"
                            : customerservicechargeunpaid,
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            payment_first(
              controller1: _customerservicechargeunpaid,
              controller2: _customerBuildSize,
              OR_N: 'OR N',
              hintTexts: 'First pay',
              First_Pay: (value) {
                setState(() {
                  payfirst = value;
                  _controllerB = TextEditingController(text: '$value');

                  // Total_Fee_dok = _controllerC.text;
                  _updateTotal();
                });
              },
              hintText: (value) {
                setState(() {
                  customerorn = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            payment_first(
              controller1: _CustomerInvoice,
              controller2: _paid_by,
              OR_N: 'Pain_by',
              hintTexts: 'Invoice',
              First_Pay: (value) {
                setState(() {
                  CustomerInvoice = value.toString();
                });
              },
              hintText: (value) {
                setState(() {
                  paid_by = value.toString();
                });
              },
            ),
            //Final Date
            Date_click(
              date_get: date_dayment,
              date: (value) {
                setState(() {
                  date_dayment = value.toString();
                });
              },
            ),
            payment_first(
              controller1: _controllerC,
              controller2: _customerorns,
              OR_N: 'OR N',
              hintTexts: 'Final pay',
              First_Pay: (value) {
                setState(() {
                  _controllerC = TextEditingController(text: '$value');
                  _updateTotal();
                });
              },
              hintText: (value) {
                setState(() {
                  customerorns = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            payment_first(
              controller1: _CustomerInvoices,
              controller2: _paid_bys,
              hintTexts: 'Invoice',
              OR_N: 'Paid bys',
              First_Pay: (value) {
                setState(() {
                  CustomerInvoices = value.toString();
                });
              },
              hintText: (value) {
                setState(() {
                  paid_bys = value.toString();
                });
              },
            ),
            Date_click(
              date: (value) {
                setState(() {
                  second_date_payment = value.toString();
                });
              },
            ),
            payment_first(
              controller1: _customerinstructorname,
              controller2: _customerinstructortel,
              hintTexts: 'Instructor Name',
              OR_N: 'Instructor Tell',
              First_Pay: (value) {
                setState(() {
                  customerinstructorname = value.toString();
                });
              },
              hintText: (value) {
                setState(() {
                  customerinstructortel = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    padding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          customerappraisalname = newValue.toString();
                        });
                      },
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select bank';
                        }
                        return null;
                      },
                      items: _list_appraiser
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value["person_id"].toString(),
                              child: Text(
                                value["Appraiser_name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: kImageColor,
                      ),
                      decoration: InputDecoration(
                        labelStyle: sizefont,
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        labelText: (widget.list[index_p]['Appraiser_name'] ==
                                null)
                            ? 'Appraiser'
                            : widget.list[index_p]['Appraiser_name'].toString(),
                        hintText: 'Appraiser',
                        prefixIcon: const Icon(
                          Icons.real_estate_agent_outlined,
                          color: kImageColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          accompany = newValue.toString();
                        });
                      },
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select bank';
                        }
                        return null;
                      },
                      items: _list_Accompany_by
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value["person_id"].toString(),
                              child: Text(
                                value["Accompany_by_name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: kImageColor,
                      ),
                      decoration: InputDecoration(
                        labelStyle: sizefont,
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        labelText:
                            (widget.list[index_p]['Accompany_by_name'] == null)
                                ? 'Accompany by'
                                : widget.list[index_p]['Accompany_by_name']
                                    .toString(),
                        hintText:
                            (widget.list[index_p]['Accompany_by_name'] == null)
                                ? 'Accompany by'
                                : accompany,
                        prefixIcon: const Icon(
                          Icons.real_estate_agent_outlined,
                          color: kImageColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// Start day and End day
            Padding(
              padding: pading,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10)),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('End Date*  -  Start Date*  = ', style: sizefont),
                      (widget.list[index_p]['customerdatetotal'] == null)
                          ? Text(
                              selectedStartDate != null &&
                                      selectedEndDate != null &&
                                      selectedEndDate!
                                              .difference(selectedStartDate!)
                                              .inDays >=
                                          0
                                  ? ' (${selectedEndDate!.difference(selectedStartDate!).inDays} days)'
                                  : '( ? )',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: Colors.red))
                          : Text(
                              selectedStartDate != null &&
                                      selectedEndDate != null &&
                                      selectedEndDate!
                                              .difference(selectedStartDate!)
                                              .inDays >=
                                          0
                                  ? ' (${selectedEndDate!.difference(selectedStartDate!).inDays} days)'
                                  : '($customerdatetotal)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: Colors.red))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: pading,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      controller:
                          start_date, //editing controller of this TextField
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: kImageColor,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ), //icon of text field
                        labelText:
                            (widget.list[index_p]['customerstartdate'] == null)
                                ? 'Start Date *'
                                : customerstartdate,
                        // labelText: "${formattedDate}",
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ), //label text of field
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        selectedStartDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (selectedStartDate != null) {
                          customerstartdate = DateFormat('yyyy-MM-dd')
                              .format(selectedStartDate!);

                          setState(() {
                            start_date.text = customerstartdate!;
                            customerdatetotal = selectedEndDate!
                                .difference(selectedStartDate!)
                                .inDays
                                .toString();
                          });
                        } else {
                          print("Date is not selected");
                        }
                        if (selectedEndDate!
                                .difference(selectedStartDate!)
                                .inDays <
                            0) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Error',
                            desc: "Please check ",
                            btnOkOnPress: () {},
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red,
                          ).show();
                        } else {}
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      controller:
                          end_date, //editing controller of this TextField
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: kImageColor,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ), //icon of text field
                        // labelText: "${formattedDate}",
                        labelText:
                            (widget.list[index_p]['customerenddate'] == null)
                                ? 'End Date *'
                                : customerenddate,
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ), //label text of field
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        selectedEndDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (selectedEndDate != null) {
                          customerenddate =
                              DateFormat('yyyy-MM-dd').format(selectedEndDate!);

                          setState(() {
                            end_date.text = customerenddate!;
                            customerdatetotal = selectedEndDate!
                                .difference(selectedStartDate!)
                                .inDays
                                .toString();
                          });
                        } else {
                          print("Date is not selected");
                        }
                        if (selectedEndDate!
                                .difference(selectedStartDate!)
                                .inDays <
                            0) {
                          setState(() {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Please Check',
                              desc: "You should Input (Start date < End Date)",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                          });
                        } else {}
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          customerinspector = newValue.toString();
                        });
                      },
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select bank';
                        }
                        return null;
                      },
                      items: _list_Inspector
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value["person_id"].toString(),
                              child: Text(
                                value["Inspector_name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kImageColor,
                      ),
                      decoration: InputDecoration(
                        labelStyle: sizehintext,
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        labelText: (widget.list[index_p]['Inspector_name'] ==
                                null)
                            ? 'Inspector Name *'
                            : widget.list[index_p]['Inspector_name'].toString(),
                        hintText: (widget.list[index_p]['customerinspector'] ==
                                null)
                            ? 'Inspector Name *'
                            : widget.list[index_p]['Inspector_name'].toString(),
                        prefixIcon: Icon(
                          Icons.real_estate_agent_outlined,
                          color: kImageColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          customerinspectors = newValue.toString();
                        });
                      },
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select bank';
                        }
                        return null;
                      },
                      items: _list_Inspectors
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value["person_id"].toString(),
                              child: Text(
                                value["Inspectors_name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kImageColor,
                      ),
                      decoration: InputDecoration(
                        labelStyle: sizehintext,
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        labelText:
                            (widget.list[index_p]['customerinspectors'] == null)
                                ? 'Inspectors Name *'
                                : widget.list[index_p]['Inspectors_name']
                                    .toString(),
                        hintText:
                            (widget.list[index_p]['customerinspectors'] == null)
                                ? 'Inspectors Name *'
                                : widget.list[index_p]['Inspectors_name']
                                    .toString(),
                        prefixIcon: Icon(
                          Icons.real_estate_agent_outlined,
                          color: kImageColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: pading_t,
              child: Container(
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                  ),
                  controller:
                      Inspecting_date, //editing controller of this TextField
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: kImageColor,
                      size: MediaQuery.of(context).size.height * 0.025,
                    ), //icon of text field
                    labelText: (customerinspectingdate == null)
                        ? 'Inspecting Date'
                        : customerinspectingdate,
                    // labelText: "${formattedDate}",
                    fillColor: kwhite,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ), //label text of field
                  ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      customerinspectingdate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        Inspecting_date.text = customerinspectingdate!;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: pading_bt,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            customerassigned = newValue.toString();
                          });
                        },
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select bank';
                          }
                          return null;
                        },
                        items: _list_assigned_By
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value["person_id"].toString(),
                                child: Text(
                                  value["assiigned_name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.012,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                            .toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: kImageColor,
                        ),
                        decoration: InputDecoration(
                          labelStyle: sizehintext,
                          fillColor: kwhite,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          labelText:
                              (widget.list[index_p]['customerassigned'] == null)
                                  ? 'Assigned By*'
                                  : widget.list[index_p]['assiigned_name']
                                      .toString(),
                          hintText:
                              (widget.list[index_p]['customerassigned'] == null)
                                  ? 'Assigned By*'
                                  : widget.list[index_p]['assiigned_name']
                                      .toString(),
                          prefixIcon: Icon(
                            Icons.real_estate_agent_outlined,
                            color: kImageColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kerror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: kerror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      controller:
                          assigndate, //editing controller of this TextField
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: kImageColor,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ), //icon of text field
                        // labelText: "${formattedDate}",
                        labelText: (widget.list[index_p]
                                    ['customerassigneddate'] ==
                                null)
                            ? 'Assigned Date'
                            : customerassigneddate,
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ), //label text of field
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          customerassigneddate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            assigndate.text = customerassigneddate!;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: pading_t,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  controller: _customerremark,
                  onChanged: (value) {
                    setState(() {
                      customerremark = value.toString();
                    });
                  },
                  maxLines: 3,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Remark',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Printing.layoutPdf(
              onLayout: (format) => _generatePdf(format, widget.list, index_p));
        },
        child: Icon(
          Icons.print,
          size: MediaQuery.of(context).size.height * 0.04,
        ),
      ),
    );
  }

  // Image select file
  File? _imageFile;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
      });
    }
  }

  String ARF_ID_GET = '';
  List _ARF_List = [];

  // void ARF_last_ID() async {
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/AFR_ID_Get'));
  //   if (rs.statusCode == 200) {
  //     var jsonData = jsonDecode(rs.body);
  //     setState(() {
  //       _ARF_List = jsonData;
  //       var _ARF_ID_GET = int.parse(_ARF_List[0]['arf_id'].toString()) + 1;
  //       ARF_ID_GET = _ARF_ID_GET.toString();
  //       yyy_formart();
  //     });
  //   }
  // }

  List _list_getnder = [];
  void Gender_dropdown() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Gender_model'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body)['data'];
      setState(() {
        _list_getnder = jsonData;
      });
    }
  }

  void ARF_ID() async {
    Map<String, dynamic> payload = await {
      'arf_id': ARF_ID_GET,
      'customer_status': int.parse(status.toString()),
    };

    final url = await Uri.parse(
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

  Future<void> _name() async {
    await Future.wait([
      Registered_By(),
      appraiser(),
      Inspector(),
      Inspectors(),
      assigned_By(),
      Accompany_by()
    ]);
  }

  List _list_Registered_By = [];
  Future<void> Registered_By() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Registered_By/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Registered_By = jsonBody;
        setState(() {
          _list_Registered_By;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_appraiser = [];
  Future<void> appraiser() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/appraiser/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_appraiser = jsonBody;
        setState(() {
          _list_appraiser;
        });
      } else {
        print('Error appraiser');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_Inspector = [];
  Future<void> Inspector() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspector/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Inspector = jsonBody;
        setState(() {
          _list_Inspector;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_Inspectors = [];
  Future<void> Inspectors() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspectors/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Inspectors = jsonBody;
        setState(() {
          _list_Inspectors;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_assigned_By = [];
  Future<void> assigned_By() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/assigned_By/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_assigned_By = jsonBody;
        setState(() {
          _list_assigned_By;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_Accompany_by = [];
  Future<void> Accompany_by() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Accompany_by/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Accompany_by = jsonBody;
        setState(() {
          _list_Accompany_by;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, List items, int index) async {
    // Create a new PDF document
    double sizefont = MediaQuery.of(context).size.height * 0.013;
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    Uint8List image_latlog = (await NetworkAssetBundle(Uri.parse(
                'https://maps.googleapis.com/maps/api/staticmap?center=${items[index]['lat'].toString()},${items[index]['log'].toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${items[index]['lat'].toString()},${items[index]['log'].toString()}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'))
            .load(
                'https://maps.googleapis.com/maps/api/staticmap?center=${items[index]['lat'].toString()},${items[index]['log'].toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${items[index]['lat'].toString()},${items[index]['log'].toString()}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'))
        .buffer
        .asUint8List();
    pdf.addPage(pw.MultiPage(
      // orientation: pw.PageOrientation.landscape,
      build: (context) {
        return [
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 0, bottom: 10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  height: 70,
                  margin: pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 80,
                        height: 50,
                        child: pw.Image(
                            pw.MemoryImage(
                              byteList,
                              // bytes1,
                            ),
                            fit: pw.BoxFit.fill),
                      ),
                      pw.SizedBox(width: 50),
                      pw.Text("KMER FOUNDATION APPAISAL",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
                pw.Text('APPRAISAL REGISTRATION FORM (ARF)',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('PROPERTY INFORMATION ONLY:',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('ARF Serial No ${items[index]['customercode']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      (items[index]['lat'].toString() != 'null')
                          ? pw.Padding(
                              padding: pw.EdgeInsets.only(left: 30, right: 30),
                              child: pw.Container(
                                height: 100,
                                width: 200,
                                child: pw.Image(pw.MemoryImage(image_latlog),
                                    fit: pw.BoxFit.cover),
                              ),
                            )
                          : pw.SizedBox()
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          'Owner Name: ${items[index]['gendername']}${items[index]['customerengname']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Tel : ${items[index]['customercontactbys']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Property: ${items[index]['property_type_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Land Size : ${items[index]['customersize']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Building Size : ${items[index]['customerBuildSize']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          'Registered by: ${items[index]['assiigned_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Date : $formattedDate',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('Signature :_____________________',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Text('VALUATION DEPARTMENT USE ONLY:',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          'Total Fee Charge : ${items[index]['customerservicecharge']} \$',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Property Guard : ${items[index]['customerservicechargePaid']} \$',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Second Payment : ${items[index]['second_payment']} \$',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          'Property Guard : ${items[index]['customercontactname']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Tel : ${items[index]['customerphones']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          'Bank Officer Name : ${items[index]['officer_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Tel : ${items[index]['office_tell']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Case From : ${items[index]['officer_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Bank : ${items[index]['bank_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Branch : ${(items[index]['bank_branch_name'] == null) ? '' : items[index]['bank_branch_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          'Starting Date : ${items[index]['customerstartdate']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('End Date : ${items[index]['customerenddate']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          'Inspector Name :${items[index]['Inspector_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Inspecting Date : ${items[index]['customerinspectingdate']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Assigned by : ${items[index]['assiigned_name']}',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Column(children: [
                        pw.Text('Signature : ____________________',
                            style: pw.TextStyle(
                                fontSize: sizefont,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            'Assigned Date : ${items[index]['customerassigneddate']}',
                            style: pw.TextStyle(
                                fontSize: sizefont,
                                fontWeight: pw.FontWeight.bold)),
                      ])
                    ]),
                pw.SizedBox(height: 10),
                pw.Text('ACCOUNT/FINANCE DEPARTMENT USE ONLY: :',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Signature :_____________________',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Received and Filed by : _____________________',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Text('ACCOUNT/FINANCE DEPARTMENT USE ONLY: :',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Approved by :NOUN Rithy',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Signature :_____________________',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Position : CEO',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Date :_____________________',
                          style: pw.TextStyle(
                              fontSize: sizefont,
                              fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Divider(height: 5),
                pw.SizedBox(height: 10),
                pw.Text(
                    '#36A, St.04 Borey Peng Huot the Star Natural 371, Sangkat Chak Angre Lieu. Khan Meanchey. Phnom Penh, Cambodia.',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.SizedBox(height: 10),
                pw.Text('Tel: (855) 023 999 855/023 988 911. www.kfa.com.kh',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          )
        ];
      },
    ));
    bool isprint = false;
    final Color_Test = Color.fromARGB(255, 131, 18, 10);
    // Get the bytes of the PDF document
    final pdfBytes = pdf.save();

    // Print the PDF document to the default printer
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    return pdf.save();
  }

  void showConfirmationBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 32, 14, 165),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Please Check Your Information again',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.019,
                        color: Colors.white),
                  ),
                )),
          ),
        );
      },
    );
  }
}
