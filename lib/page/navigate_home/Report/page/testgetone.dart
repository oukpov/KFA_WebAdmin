import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../../../../controller/banner_controller.dart';

class GetOneDataPage extends StatefulWidget {
  final String id;

  const GetOneDataPage({Key? key, required this.id}) : super(key: key);

  @override
  _GetOneDataPageState createState() => _GetOneDataPageState();
}

class _GetOneDataPageState extends State<GetOneDataPage> {
  List? onedata;
  bool isLoading = true;
  String? errorMessage;
  final BannerController _bannerController = BannerController();

  @override
  void initState() {
    super.initState();
    _fetchOneData();
  }

  Future<void> _fetchOneData() async {
    try {
      await _bannerController.getonedata(widget.id);
      setState(() {
        onedata = _bannerController.onedata;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get One Data ${widget.id}'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : onedata != null && onedata!.isNotEmpty
                  ? ListView.builder(
                      itemCount: onedata!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('ID: ${onedata![index]['id']}'),
                          subtitle: Text('Data: ${onedata![index].toString()}'),
                        );
                      },
                    )
                  : const Center(child: Text('No data available')),
    );
  }
}
