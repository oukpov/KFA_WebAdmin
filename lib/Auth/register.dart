// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:web_admin/Profile/contants.dart';
import 'dart:html' as html;

import '../../../api/api_service.dart';
import '../Customs/ProgressHUD.dart';
import '../Customs/formTwin.dart';
import '../Customs/formVLD.dart';
import '../Customs/responsive.dart';
import '../models/register_model.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Register();
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  // List of items in our dropdown menu
  var from = [
    'Bank',
    'Private',
    'Other',
  ];
  var gender = [
    'Female',
    'Male',
    'Other',
  ];
  late File croppedFile;
  XFile? file;
  Uint8List? get_bytes;
  Uint8List? _selectedFile;
  Uint8List? _byesData;
  File? imageFile;
  String imageUrl = '';
  String? _uploadedBlobUrl;
  String? _croppedBlobUrl;
  // var? image;
  html.File? cropimage_file;

  final completer = Completer<Uint8List>();
  Future<void> OpenImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();

    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();
      WebUiSettings settings;
      reader.onLoadEnd.listen((event) {
        setState(() {
          _byesData =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectedFile = _byesData;
          croppedFile = File.fromRawPath(_byesData!);
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future<void> _cropImage() async {
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
      cropimage_file = html.File([blob], 'cropped-image.png');
      get_bytes = Uint8List.fromList(bytes);
      // await
      setState(() {
        _croppedBlobUrl = croppedFile.path;
        saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
      });

      if (cropimage_file != null) {}
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
  }

  String? set_id_user;
  int? user_last_id;
  Random random = new Random();
  void get_user_last_id() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_last_user'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        user_last_id = jsonData;
        set_id_user =
            '${user_last_id.toString()}K${random.nextInt(999).toString()}F${user_last_id.toString()}A';
      });
    }
  }

  Future<void> uploadImage() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_profile_user'));
    request.fields['id_user'] = set_id_user ?? '';
    if (get_bytes != null) {
      request.files.add(await http.MultipartFile.fromBytes('image', get_bytes!,
          filename:
              'User ID :${set_id_user} photo ${random.nextInt(999)}.jpg'));
    } else {
      request.files.add(await http.MultipartFile.fromBytes('image', _byesData!,
          filename:
              'User ID :${set_id_user} Photo ${random.nextInt(999)}.jpg'));
    }

    var res = await request.send();
  }

  bool _isObscure = true;
  late RegisterRequestModel requestModel;
  bool isApiCallProcess = false;
  @override
  void initState() {
    get_user_last_id();
    super.initState();
    // ignore: unnecessary_new
    requestModel = new RegisterRequestModel(
      email: "",
      password: "",
      first_name: '',
      gender: '',
      known_from: '',
      last_name: '',
      tel_num: '',
      // username: '',
      password_confirmation: '',
      control_user: set_id_user ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSteup(context),
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSteup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/KFA-Logo.png',
          height: 80,
          width: 100,
        ),
        toolbarHeight: 100,
      ),
      backgroundColor: kwhite_new,
      body: Container(
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Responsive(
            mobile: register(context),
            tablet: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: register(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
            desktop: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: register(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
            phone: register(context),
          ),
        ),
      ),
    );
  }

  Padding register(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Register to KFA system',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text.rich(
                TextSpan(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TextSpan(
                      text: "ONE CLICK ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kImageColor,
                      ),
                    ),
                    TextSpan(
                      text: "1\$",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: kerror,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_byesData == null) {
                      OpenImgae();
                    } else {
                      _cropImage();
                    }
                  });
                },
                child: Center(
                    child: (_byesData == null)
                        ? Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              GFAvatar(
                                size: 100,
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                              ),
                              Container(
                                height: 20,
                                width: 30,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(96, 102, 102, 102),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        : (_byesData != null && get_bytes == null)
                            ? Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  GFAvatar(
                                    size: 100,
                                    backgroundImage: MemoryImage(_byesData!),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 30,
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(96, 102, 102, 102),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(
                                      Icons.crop,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            : Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  GFAvatar(
                                    size: 100,
                                    backgroundImage: MemoryImage(get_bytes!),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 30,
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(96, 102, 102, 102),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(
                                      Icons.crop,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )),
              ),
              SizedBox(
                height: 10,
              ),
              if (user_last_id != null)
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: 'Identity ${set_id_user}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.info_outline_rounded,
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
                ),
              SizedBox(
                height: 10,
              ),
              FormTwin(
                  Label1: 'First Name',
                  Label2: 'Last Name',
                  onSaved1: (input) => requestModel.first_name = input!,
                  onSaved2: (input) => requestModel.last_name = input!,
                  icon1: Icon(
                    Icons.person,
                    color: kImageColor,
                  ),
                  icon2: Icon(
                    Icons.person,
                    color: kImageColor,
                  )),

              // FormValidate(
              //     onSaved: (input) => requestModel.username = input!,
              //     label: 'Username',
              //     iconname: Icon(
              //       Icons.person,
              //       color: kImageColor,
              //     )),
              SizedBox(
                height: 10,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: DropdownButtonFormField<String>(
                    //value: genderValue,
                    onSaved: (input) => requestModel.gender = input!,
                    onChanged: (String? newValue) {
                      setState(() {
                        genderValue = newValue!;

                        print(newValue);
                      });
                    },
                    items: gender
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                      labelText: 'Gender',
                      hintText: 'Select one',
                      prefixIcon: Icon(
                        Icons.accessibility_new_sharp,
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
              SizedBox(
                height: 10,
              ),
              FormValidate(
                onSaved: (input) => requestModel.email = input!,
                label: 'Email',
                iconname: Icon(
                  Icons.email,
                  color: kImageColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FormValidate(
                onSaved: (input) => requestModel.tel_num = input!,
                label: 'Phone Number',
                iconname: Icon(
                  Icons.phone,
                  color: kImageColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  obscureText: _isObscure,
                  onSaved: (input) => requestModel.password = input!,
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Enter password',
                    prefixIcon: Icon(
                      Icons.key,
                      color: kImageColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: kImageColor,
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'require *';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: TextFormField(
                  obscureText: _isObscure,
                  onSaved: (input) =>
                      requestModel.password_confirmation = input!,
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Confirm password',
                    prefixIcon: Icon(
                      Icons.key,
                      color: kImageColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: kImageColor,
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'require *';
                    }
                    return null;
                  },
                ),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 70,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: DropdownButtonFormField<String>(
                    //value: fromValue,
                    onSaved: (input) => requestModel.known_from = input!,
                    onChanged: (String? newValue) {
                      setState(() {
                        fromValue = newValue!;

                        print(newValue);
                      });
                    },
                    items: from
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                      labelText: 'From',
                      hintText: 'Select one',
                      prefixIcon: Icon(
                        Icons.business_outlined,
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
                      //   decoration: InputDecoration(
                      //       labelText: 'From',
                      //       prefixIcon: Icon(Icons.business_outlined)),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 150,
                child: AnimatedButton(
                  text: 'Register',
                  color: kPrimaryColor,
                  pressEvent: () async {
                    if (validateAndSave()) {
                      setState(() {
                        isApiCallProcess = true;
                        requestModel.control_user = set_id_user!;
                      });
                      uploadImage();

                      APIservice apIservice = APIservice();
                      apIservice.register(requestModel).then((value) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.message == "User successfully registered") {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.success,
                            showCloseIcon: false,
                            title: value.message,
                            autoHide: Duration(seconds: 3),
                            onDismissCallback: (type) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                          ).show();
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
                    }
                  },
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have account? ",
                      style: TextStyle(fontSize: 16.0, color: kTextLightColor),
                    ),
                    TextSpan(
                      text: 'Log In',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kImageColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
