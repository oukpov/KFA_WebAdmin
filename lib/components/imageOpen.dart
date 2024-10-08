// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class ImageOpen extends StatefulWidget {
  @override
  State<ImageOpen> createState() => _ImageOpenState();
}

class _ImageOpenState extends State<ImageOpen> {
  var imageopen;
  late String nameFile = '';
  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result == null) return;
    final file = result.files.first;
    setState(() {
      imageopen = file;
      nameFile = result.files.first.name;
    });

    print(nameFile);
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              // padding: EdgeInsets.only(left: 30, right: 30),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.file_present_sharp,
                          color: kImageColor,
                        ),
                        SizedBox(width: 3),
                        TextButton(
                          onPressed: () {
                            _pickImage();
                          },
                          child: Text(
                            'Choose Image',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        child: nameFile != ''
                            ? Text(nameFile,
                                style: TextStyle(color: kImageColor))
                            : Text(
                                nameFile,
                                style: TextStyle(color: kImageColor),
                              ),
                        onTap: () => _openFile(imageopen),
                        // onTap: ()=>_pickImage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
