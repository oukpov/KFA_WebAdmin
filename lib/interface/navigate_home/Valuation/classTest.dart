import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ExecutiveFormWidget extends StatefulWidget {
  @override
  _ExecutiveFormWidgetState createState() => _ExecutiveFormWidgetState();
}

class _ExecutiveFormWidgetState extends State<ExecutiveFormWidget> {
  TextEditingController executiveCustomerIdController = TextEditingController();
  TextEditingController executiveValuationDateController =
      TextEditingController();
  TextEditingController executiveValuationIssueDateController =
      TextEditingController();
  TextEditingController executivePurposeController = TextEditingController();
  TextEditingController executiveLandWidthController = TextEditingController();
  TextEditingController executiveLandLengthController = TextEditingController();
  TextEditingController executiveLandTotalController = TextEditingController();
  TextEditingController executiveLandPriceController = TextEditingController();
  TextEditingController executiveLandPricePerController =
      TextEditingController();
  TextEditingController executiveBuildingController = TextEditingController();
  TextEditingController executiveFireController = TextEditingController();
  TextEditingController executiveFairController = TextEditingController();
  TextEditingController executiveForcedController = TextEditingController();
  TextEditingController executiveLonController = TextEditingController();
  TextEditingController executiveLngController = TextEditingController();
  TextEditingController executiveCreateBy = TextEditingController();
  @override
  void dispose() {
    executiveCustomerIdController.dispose();
    executiveValuationDateController.dispose();
    executiveValuationIssueDateController.dispose();
    executivePurposeController.dispose();
    executiveLandWidthController.dispose();
    executiveLandLengthController.dispose();
    executiveLandTotalController.dispose();
    executiveLandPriceController.dispose();
    executiveLandPricePerController.dispose();
    executiveBuildingController.dispose();
    executiveFireController.dispose();
    executiveFairController.dispose();
    executiveForcedController.dispose();
    executiveLonController.dispose();
    executiveLngController.dispose();
    executiveLngController.dispose();
    executiveCreateBy.dispose();
    super.dispose();
  }

  Future<void> postApiData() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "executive_customer_id": executiveCustomerIdController.text,
      "executive_valuation_date": executiveValuationDateController.text,
      "executive_valuation_issue_date":
          executiveValuationIssueDateController.text,
      "executive_purpose": executivePurposeController.text,
      "executive_land_width": executiveLandWidthController.text,
      "executive_land_length": executiveLandLengthController.text,
      "executive_land_total": executiveLandTotalController.text,
      "executive_land_price": executiveLandPriceController.text,
      "executive_land_price_per": executiveLandPricePerController.text,
      "executive_building": executiveBuildingController.text,
      "executive_fire": executiveFireController.text,
      "executive_fair": executiveFairController.text,
      "executive_forced": executiveForcedController.text,
      "executive_lon": executiveLonController.text,
      "executive_lng": executiveLngController.text,
      "executive_create_by": executiveCreateBy.text,

      // Example building data
      "building": [
        {
          "building_executive_id": "587",
          "building_size": "66.75",
          "building_price": "150.00",
          "building_price_per": "10012.50",
          "building_des": "1"
        }
      ],
      // Example appraiser data
      "appraiser": [
        {
          "appraiser_executiveid": "587",
          "appraiser_agent_id": "1",
          "appraiser_position": "1",
          "appraiser_price": "1",
          "appraiser_remark": "1"
        }
      ],
      // Example comparable map data
      "conparable_map": [
        {
          "propertycomparable_executive_id": "587",
          "propertycomparable_com_id": "1444",
          "propertycomparable_status": "1"
        }
      ]
    });

    var dio = Dio();

    try {
      var response = await dio.post(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_executive/587',
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // Handle success, e.g., show a success message
      } else {
        print(response.statusMessage);
        // Handle error, e.g., show an error message
      }
    } catch (error) {
      print('Error: $error');
      // Handle error, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Executive Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: executiveCustomerIdController,
                decoration: InputDecoration(labelText: 'Customer ID'),
              ),
              // Add similar fields for other properties

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  postApiData();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
