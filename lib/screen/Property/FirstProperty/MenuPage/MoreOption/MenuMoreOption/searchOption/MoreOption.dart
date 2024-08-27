import 'package:flutter/material.dart';
import '../../../../../../../components/colors.dart';
import '../../OptionInHeader/DropDownOption.dart';

Widget searchOptionMobile(
    BuildContext context,
    List listBathrooms,
    List listPrice,
    List listBedrooms,
    String myIdController,
    wOption,
    h,
    topR,
    topl,
    botr,
    botl,
    hResponse,
    raDius,
    email,
    idUserController) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return OptoinBottomSheetContent(
            myIdController: myIdController,
            email: email,
            idUserController: idUserController,
            priceDropdownMax: '2',
            priceDropdownMin: '2',
            hResponse: hResponse,
            raDius: raDius,
          );
        },
      );
    },
    child: Container(
      height: h,
      width: wOption,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(topR),
              topLeft: Radius.circular(topl),
              bottomRight: Radius.circular(botr),
              bottomLeft: Radius.circular(botl))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            color: blackColor,
          ),
          const SizedBox(width: 5),
          Text(
            'More Option',
            style:
                TextStyle(fontSize: MediaQuery.textScaleFactorOf(context) * 12),
          ),
        ],
      ),
    ),
  );
}
