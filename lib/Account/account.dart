import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import '../Auth/login.dart';
import '../Profile/components/Drop_down.dart';
import '../Profile/components/FieldBox.dart';
import '../Profile/components/TwinBox.dart';
import '../Profile/components/singleBox.dart';
import '../Profile/contants.dart';
import '../models/register_model.dart';

class Account extends StatefulWidget {
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  final String? set_email;
  final String? set_password;
  const Account({
    Key? key,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
    this.set_email,
    this.set_password,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
//update data from api
  var url = "https://img.icons8.com/fluency/100/user-male-circle.png";
  String? id_get_image_profile;
//get image and crop
  String? _imagepath;
  File? _imagefile;
  bool _isObscure = true;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];
  var set_id_user;
  List<dynamic> list_User_by_id = [];
  void get_control_user_image(String id) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_User_by_id = jsonData;
        if (list_User_by_id[0]['control_user'] != null) {
          url;
          set_id_user = list_User_by_id[0]['control_user'].toString();
          get_image(list_User_by_id[0]['control_user'].toString());
        }
      });
    }
  }

  void get_image(String id) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user_profile/${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        url = jsonData[0]['url'];
      });
    }
  }

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

  Random random = new Random();
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

  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Fluttertoast.showToast(
      msg: 'Log Out',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.blue,
      fontSize: 20,
    );
    Get.off(() => Login());
  }

  Future<void> updateUser() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/edit/${widget.id}'));
    request.fields.addAll({
      'first_name': requestModel!.first_name,
      'last_name': requestModel!.last_name,
      'gender': requestModel!.gender,
      'tel_num': requestModel!.email,
      'email': requestModel!.email,
      'password': requestModel!.password,
      'known_from': requestModel!.known_from,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }

  RegisterRequestModel_update? requestModel;
  TextEditingController? Password;

  @override
  void initState() {
    requestModel = RegisterRequestModel_update(
        email: widget.email,
        password: widget.set_password!,
        first_name: widget.first_name,
        gender: widget.gender,
        known_from: widget.from,
        last_name: widget.last_name,
        tel_num: widget.tel);
    get_control_user_image(widget.id);
    super.initState();
    Password = TextEditingController(text: widget.set_password.toString());
  }

  @override
  Widget build(BuildContext context) {
    //controller to update dataInfo
    final controller = TextEditingController(text: widget.username);
    //Get.lazyPut(() => ImageController());
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(0),
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: 750,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 200,
                    decoration: BoxDecoration(
                      color: kwhite_new,
                      borderRadius: kBottomBorderRadius,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_byesData == null) {
                                  OpenImgae();
                                } else {
                                  _cropImage();
                                }
                              });
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                if (_byesData == null)
                                  GFAvatar(
                                    size: 100,
                                    backgroundImage: NetworkImage('${url}'),
                                  )
                                else if (_byesData != null && get_bytes == null)
                                  GFAvatar(
                                    size: 100,
                                    backgroundImage: MemoryImage(_byesData!),
                                  )
                                else
                                  GFAvatar(
                                    size: 100,
                                    backgroundImage: MemoryImage(get_bytes!),
                                  ),
                                Container(
                                  height: 20,
                                  width: 50,
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(95, 67, 67, 67),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    (_byesData == null)
                                        ? Icons.edit
                                        : Icons.crop,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // controller: controller,
                                'Name : ${widget.username}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (list_User_by_id.isNotEmpty)
                                Text(
                                  'ID : ${list_User_by_id[0]['control_user'] ?? ''}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      TwinBox(
                        labelText1: 'Firstname',
                        labelText2: 'Lastname',
                        fname: widget.first_name,
                        lname: widget.last_name,
                        get_fname: (value) {
                          setState(() {
                            requestModel!.first_name = value;
                          });
                        },
                        get_lname: (value) {
                          setState(() {
                            requestModel!.last_name = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Dropdown(
                            gender: widget.gender,
                            get_gender: (value) {
                              setState(() {
                                requestModel!.gender = value;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          // បិទសឹនបើមានការUpdate ដោយអនុញ្ញាតិអោយគេអាចធ្វើការកែប្រែបានចាំបើក​ SizedBoxខាងក្រោម ។
                          SizedBox(
                            height: 59,
                            width: 140,
                            child: DropdownButtonFormField<String>(
                              onChanged: (String? newValue) {
                                setState(() {
                                  requestModel!.known_from = newValue!;
                                });
                              },

                              value: widget.from,
                              items: bank
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                              // add extra sugar..
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kwhite_new,
                              ),

                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Bank',
                                hintText: 'Select',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      SingleBox(
                        phone: widget.tel,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Field_box(
                        name: 'email',
                        email: widget.email,
                        get_email: (value) {
                          setState(() {
                            requestModel!.email = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 2,
                      ),

                      SizedBox(
                        height: 60,
                        width: 280,
                        child: TextFormField(
                          controller: Password!,
                          onChanged: (input) {
                            setState(() {
                              requestModel!.password = input;
                            });
                          },
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            filled: true,
                            labelText: 'Your Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                color: const Color.fromRGBO(169, 203, 56, 1),
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
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
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text('Save Change'),
                          onPressed: () async {
                            if (_byesData != null) {
                              uploadImage();
                            }
                            updateUser();

                            // APIservice apIservice = APIservice();
                            // if (_byesData != null) {
                            //   uploadImage();
                            // }
                            // await apIservice.update_user(
                            //     requestModel!, int.parse(widget.id));
                            // html.window.localStorage['email'] =
                            //     requestModel!.email;
                            // html.window.localStorage['password'] =
                            //     requestModel!.password;
                            // // ignore: use_build_context_synchronously
                            // Navigator.pop(context);
                            // // ignore: use_build_context_synchronously
                            // Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          child: Text('Log Out'),
                          onPressed: () {
                            logOut();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // Column(
              //   children: [

              //   ],
              // ),
            ],
          )),
    );
  }
}
