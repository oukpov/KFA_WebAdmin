import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CheckboxListExample extends StatefulWidget {
  @override
  _CheckboxListExampleState createState() => _CheckboxListExampleState();
}

class _CheckboxListExampleState extends State<CheckboxListExample> {
  // Move the initialization of bedslistings above checkboxValues
  List<Map<String, String>> bedslistings = [
    {'title': 'All Beds', 'count': '0'},
    {'title': '1 Bed', 'count': '1'},
    {'title': '2 Beds', 'count': '2'},
    {'title': '3 Beds', 'count': '3'},
    {'title': '4 Beds', 'count': '4'},
    {'title': '5 Beds', 'count': '5'},
    {'title': '6 Beds', 'count': '6'},
    {'title': '7 Beds', 'count': '7'},
    {'title': '8 Beds', 'count': '8'},
    {'title': '9 Beds', 'count': '9'},
    {'title': '10 Beds', 'count': '10'},
    {'title': '11 Beds', 'count': '11'},
    {'title': '12 Beds', 'count': '12'}, // Fix the count for the last item
  ];

  List<bool> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkboxValues after bedslistings is defined
    checkboxValues = List.generate(bedslistings.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox List Example'),
      ),
      body: ListView.builder(
        itemCount: bedslistings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${bedslistings[index]['title']}'),
            trailing: GFCheckbox(
              size: GFSize.SMALL,
              activeBgColor: GFColors.DANGER,
              type: GFCheckboxType.circle,
              onChanged: (value) {
                setState(() {
                  checkboxValues[index] = value;
                });
              },
              value: checkboxValues[index],
              inactiveIcon: null,
            ),
          );
        },
      ),
    );
  }
}
