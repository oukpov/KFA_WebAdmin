import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/colors.dart';
import '../../../getx/Auth/setAdmin.dart';
import '../Customer/component/Web/simple/inputfiled.dart';

class SetAdminClass extends StatefulWidget {
  const SetAdminClass({super.key});

  @override
  State<SetAdminClass> createState() => _SetAdminClassState();
}

class _SetAdminClassState extends State<SetAdminClass> {
  final controller = SetAdmin();
  String? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Set Admin'),
        actions: [
          InkWell(
            onTap: () {
              AwesomeDialog(
                      width: 500,
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.question,
                      showCloseIcon: false,
                      title: 'Do you want to Client to Admin?',
                      btnOkOnPress: () {
                        controller.setAdmin(id!);
                      },
                      btnCancelOnPress: () {},
                      // autoHide: const Duration(seconds: 2),
                      onDismissCallback: (type) {})
                  .show();
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: greyColor),
                    borderRadius: BorderRadius.circular(5),
                    color: whiteColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Save',
                        style: TextStyle(
                            color: greyColor, fontWeight: FontWeight.bold)),
                    Icon(Icons.save_alt, color: greyColor)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 30)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Inputfied(
                    filedName: "ID Client",
                    readOnly: false,
                    validator: false,
                    flex: 2,
                    value: (value) {
                      setState(() {
                        id = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
