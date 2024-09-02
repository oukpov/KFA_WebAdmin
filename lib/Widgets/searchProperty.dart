import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../components/ApprovebyAndVerifyby.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../components/colors.dart';

class propertyType extends StatefulWidget {
  const propertyType({
    Key? key,
    required this.value,
    required this.valuenameback,
    required this.valueName,
    required this.lable,
  }) : super(key: key);
  final OnChangeCallback value;
  final OnChangeCallback valuenameback;
  final String valueName;
  final String lable;
  @override
  State<propertyType> createState() => _valueDropdownState();
}

class _valueDropdownState extends State<propertyType> {
  late String valuevalue;
  late String branchvalue;
  @override
  void initState() {
    super.initState();
    valuevalue = "";
    branchvalue = "";

    valueModel();
  }

  bool districtw = false;
  bool checkproperty = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownSearch<Map<dynamic, dynamic>>(
                items: listvalueModel,
                compareFn: (item1, item2) {
                  return item1['property_type_name'] ==
                      item2['property_type_name'];
                },
                validator: (value) {
                  setState(() {
                    if (value == null || value.isEmpty) {
                      checkproperty = true;
                    } else {
                      checkproperty = false;
                    }
                  });
                },
                popupProps: PopupProps.menu(
                  isFilterOnline: true,
                  showSearchBox: true,
                  showSelectedItems: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text(item['property_type_name'] ?? ''),
                      selected: isSelected,
                    );
                  },
                  searchFieldProps: const TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search a country',
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.value(value?['property_type_id'].toString());
                    widget
                        .valuenameback(value?['property_type_name'].toString());
                  });
                },
                selectedItem: const {"value": "A"},
                dropdownDecoratorProps: DropDownDecoratorProps(
                  // dropdownSearchDecoration: InputDecoration(
                  //   border: InputBorder.none,
                  // ),
                  dropdownSearchDecoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    hintText: widget.lable,
                    hintStyle: TextStyle(
                        color: !checkproperty ? greyColorNolots : colorsRed),
                    prefixIcon: const Icon(
                      Icons.real_estate_agent_outlined,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                filterFn: (item, filter) {
                  return item['property_type_name']
                          ?.toLowerCase()
                          .contains(filter.toLowerCase()) ??
                      false;
                },
                itemAsString: (item) => item['property_type_name'] ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<dynamic, dynamic>> listvalueModel = [];
  List listvalues = [];
  Future<void> valueModel() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listvalues = jsonDecode(json.encode(response.data));
        for (int i = 0; i < listvalues.length; i++) {
          listvalueModel.add(listvalues[i]);
        }
      });
    } else {
      print(response.statusMessage);
    }
  }
}
