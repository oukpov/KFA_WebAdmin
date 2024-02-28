// // ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unnecessary_new, unused_local_variable, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, await_only_futures, unnecessary_null_comparison, empty_catches, unused_field, unrelated_type_equality_checks, sized_box_for_whitespace, use_build_context_synchronously, unused_import, avoid_web_libraries_in_flutter, prefer_const_declarations

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:getwidget/components/animation/gf_animation.dart';
// import 'package:getwidget/types/gf_animation_type.dart';
// import 'package:http/http.dart' as http;
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:kfaProjectAdmin/afa/customs/google_web/map_all/map_in_add_verbal.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../../../contants.dart';
// import '../../../api/api_service.dart';
// import '../../../models/autoVerbal.dart';
// import '../../../models/model_bl_new.dart';
// import '../../../screen/Customs/form.dart';
// import '../../../screen/Customs/formTwinN.dart';
// import '../../../screen/Customs/responsive.dart';
// import '../../../screen/Profile/components/Drop.dart';
// import '../../../screen/components/ApprovebyAndVerifyby.dart';
// import '../../../screen/components/code.dart';
// import '../../../screen/components/comment.dart';
// import '../../../screen/components/forceSale.dart';
// import '../../../screen/components/property.dart';
// import 'dart:html' as html;
// import 'afa/components/LandBuilding.dart';

// class Add2222 extends StatefulWidget {
//   const Add2222(
//       {super.key, required this.id, required PageDisplayStyle displayStyle});
//   final String id;

//   @override
//   State<Add2222> createState() => _AddState();
// }

// class _AddState extends State<Add2222> with SingleTickerProviderStateMixin {
//   // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   OpenImgae() async {
//     html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.multiple = true;
//     uploadInput.draggable = true;
//     uploadInput.click();
//     uploadInput.onChange.listen((event) {
//       final files = uploadInput.files;
//       final file = files!.elementAt(0);
//       final reader = html.FileReader();
//       WebUiSettings settings;
//       reader.onLoadEnd.listen((event) {
//         setState(() {
//           _byesData =
//               Base64Decoder().convert(reader.result.toString().split(',').last);
//           _selectedFile = _byesData;
//           croppedFile = File.fromRawPath(_byesData!);
//           imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
//         });
//       });
//       reader.readAsDataUrl(file);
//     });
//   }

//   XFile? file;
//   Uint8List? get_bytes;
//   late AnimationController controller;
//   late Animation<double> animation;
//   late Animation<Offset> offsetAnimation;
//   var id_verbal;
//   @override
//   void initState() {
//     addVerbal(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(235, 8, 11, 161),
//         elevation: 0,
//         // centerTitle: true,
//         actions: <Widget>[
//           InkWell(
//             onTap: () {
//               // uploadt_image(_file!);
//               Post_Image(code, get_bytes);
//               // uploadt_image(_file!);
//               // setState(() {
//               //   print('image_file = $_file');
//               // });
//             },
//             child: Container(
//               margin: EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 4),
//               decoration: BoxDecoration(
//                 color: Colors.lightGreen[700],
//                 boxShadow: [BoxShadow(color: Colors.green, blurRadius: 5)],
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(80),
//                   bottomLeft: Radius.circular(80),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("Save"),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Container(
//                     width: 10,
//                     height: 50,
//                     alignment: Alignment.topRight,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],

//         toolbarHeight: 80,
//       ),
//       // backgroundColor: Color.fromARGB(235, 8, 11, 161),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: addVerbal(context),
//         ),
//       ),
//     );
//   }

//   Widget addVerbal(BuildContext context) {
//     return Column(
//       children: [
//         Code(
//           code: (value) {
//             setState(() {
//               code = value;
//             });
//           },
//           check_property: 1,
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         if (get_bytes != null && _byesData != null)
//           Container(
//             height: 300,
//             width: 300,
//             color: Colors.white,
//             child: Image.memory(get_bytes!),
//           ),
//         _byesData != null
//             ? Column(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         _cropImage();
//                       },
//                       icon: Icon(Icons.crop)),
//                   if (get_bytes == null)
//                     Image.memory(
//                       _byesData!,
//                       width: 400,
//                       height: 200,
//                     ),
//                 ],
//               )
//             : _byesData == null
//                 ? TextButton(
//                     onPressed: () {
//                       OpenImgae();
//                     },
//                     child: FractionallySizedBox(
//                       widthFactor: 1,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 22, right: 22),
//                         child: Container(
//                           height: 60,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               width: 1,
//                               color: kPrimaryColor,
//                             ),
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           // padding: EdgeInsets.only(left: 30, right: 30),
//                           child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Row(
//                                 children: [
//                                   SizedBox(width: 10),
//                                   Icon(
//                                     Icons.map_sharp,
//                                     color: kImageColor,
//                                   ),
//                                   SizedBox(width: 10),
//                                   Text(
//                                     'Choose Image',
//                                     style: TextStyle(color: Colors.black54),
//                                   ),
//                                 ],
//                               )),
//                         ),
//                       ),
//                     ),
//                   )
//                 : SizedBox(),
//       ],
//     );
//   }

//   Future<File> convertImageByteToFile(
//       Uint8List imageBytes, String fileName) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final path = directory.path;
//     File file = File('$path/$fileName');
//     await file.writeAsBytes(imageBytes);
//     return file;
//   }

//   Random random = new Random();

//   XFile? _image;
//   final picker = ImagePicker();
//   late String base64string;
//   XFile? _file;
//   Uint8List? imagebytes;
//   final ImagePicker imgpicker = ImagePicker();
//   String imagepath = "";
//   Future openImage() async {
//     try {
//       XFile? pickedFile =
//           await ImagePicker().pickImage(source: ImageSource.gallery);
//       //you can use ImageCourse.camera for Camera capture
//       if (pickedFile != null) {
//         imagepath = pickedFile.path;
//         CroppedFile? cropFile = await ImageCropper().cropImage(
//           sourcePath: pickedFile.path,
//           uiSettings: [
//             AndroidUiSettings(
//                 lockAspectRatio: false,
//                 initAspectRatio: CropAspectRatioPreset.original)
//           ],
//         );
//         _file = XFile(cropFile!.path);
//         File? imagefile = File(cropFile.path); //convert Path to File
//         imagebytes = await imagefile.readAsBytes(); //convert to bytes
//         String base64string =
//             base64.encode(imagebytes!); //convert bytes to base64 string
//         Uint8List decodedbytes = base64.decode(base64string);
//         //decode base64 stirng to bytes
//         setState(() {
//           _file = imagefile as XFile;
//           print('$_file');
//         });
//       } else {
//         print("No image is selected.");
//       }
//     } catch (e) {
//       print("error while picking file.");
//     }
//   }

//   Future<void> Post_Image(code, get_bytes) async {
//     final url =
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image';
//     final request = http.MultipartRequest('POST', Uri.parse(url));
//     request.fields.addAll({
//       'cid': code.toString(),
//     });
//     final file = await http.MultipartFile.fromPath('image', get_bytes);
//     request.files.add(file);
//     final response = await request.send();
//     if (response.statusCode == 200) {
//       print('Form data uploaded successfully');
//     } else {
//       print('Failed to upload form data');
//     }
//   }
// // Future<void> postImage( get_bytes) async {
// //   final url = 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image';
// //   final headers = {'Content-Type': 'application/json'};

// //   final body = {'image': get_bytes};
// //   final response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));
// //   if (response.statusCode == 200) {
// //     print('Image uploaded successfully');
// //   } else {
// //     print('Failed to upload image');
// //   }
// // }
//   Future<void> uploadt_image(_file) async {
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//             'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image'));
//     request.fields['cid'] = code.toString();
//     setState(() {});
//     if (get_bytes != null) {
//       request.files.add(await http.MultipartFile.fromBytes('image', get_bytes!,
//           filename: '${random.nextInt(99)}'));
//     } else {
//       request.files.add(await http.MultipartFile.fromBytes('image', _byesData!,
//           filename: '${random.nextInt(99)}'));
//     }
//     var res = await request.send();
//     print('$get_bytes');
//   }

//   String imageUrl = '';
//   //get khan

//   int i = 0;

//   late File croppedFile;
//   Uint8List? _selectedFile;
//   Uint8List? _byesData;
//   File? imageFile;
//   String? _uploadedBlobUrl;
//   String? _croppedBlobUrl;
//   // var? image;
//   html.File? cropimage_file;

//   final completer = Completer<Uint8List>();
//   Future<void> _cropImage() async {
//     WebUiSettings settings;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     settings = WebUiSettings(
//       context: context,
//       presentStyle: CropperPresentStyle.dialog,
//       boundary: CroppieBoundary(
//         width: (screenWidth * 0.4).round(),
//         height: (screenHeight * 0.4).round(),
//       ),
//       viewPort: const CroppieViewPort(
//         width: 300,
//         height: 300,
//       ),
//       enableExif: true,
//       enableZoom: true,
//       showZoomer: true,
//     );

//     final croppedFile = await ImageCropper().cropImage(
//       sourcePath: imageUrl,
//       compressFormat: ImageCompressFormat.jpg,
//       compressQuality: 100,
//       uiSettings: [settings],
//     );
//     if (croppedFile != null) {
//       final bytes = await croppedFile.readAsBytes();
//       final blob = html.Blob([bytes]);
//       cropimage_file = html.File([blob], 'cropped-image.png');
//       get_bytes = Uint8List.fromList(bytes);
//       // await
//       setState(() {
//         _croppedBlobUrl = croppedFile.path;
//         saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
//       });

//       if (cropimage_file != null) {}
//     }
//   }

//   Future<void> saveBlobToFile(String blobUrl, String filename) async {
//     final response = await http.get(Uri.parse(blobUrl));
//     final bytes = response.bodyBytes;

//     final directory = await getApplicationDocumentsDirectory();
//     final path = "${directory.path}/$filename";
//   }
// }
