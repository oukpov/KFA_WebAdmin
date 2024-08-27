import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/Profile/components/Drop_down.dart';

import '../../../../../components/colors.dart';

class SearchText extends StatefulWidget {
  const SearchText(
      {super.key,
      required this.domainAPI,
      required this.query,
      required this.w,
      required this.backvalue,
      required this.txt});
  final String query;
  final String domainAPI;
  final double w;
  final OnChangeCallback backvalue;
  final String txt;
  @override
  State<SearchText> createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  String inspectorID = '';
  List list = [];
  Future<void> comparablesearch() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/${widget.domainAPI}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        list = jsonDecode(json.encode(response.data));
        widget.backvalue(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          height: 35,
          width: MediaQuery.of(context).size.width * widget.w,
          child: TextFormField(
            onChanged: (value) {
              setState(() {});
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.textScaleFactorOf(context) * 12,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(9),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.4, color: greyColor)),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      comparablesearch();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(5)),
                    height: 35,
                    width: 50,
                    child: Icon(
                      Icons.search,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              suffix: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: blackColor,
                ),
              ),
              border: InputBorder.none,
              hintText: '  Search listing here...',
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            setState(() {});
          },
          child: Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: greyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('All '),
                Icon(Icons.list_alt_outlined),
              ],
            ),
          ),
        )
      ],
    );
  }

  List listmid = [];
  void searchbyMonth(String year, String month) {
    String elementYear = '';
    String elementMonth = '';
    listmid = list.where((element) {
      List<String> dateParts = element['customerdate'].toString().split('-');
      if (year != '') elementYear = dateParts[0];
      if (month != '') elementMonth = dateParts[1];
      widget.backvalue(listmid);
      return elementYear == year && elementMonth == month;
    }).toList();
  }
}
