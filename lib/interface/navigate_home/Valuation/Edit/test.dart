import 'package:flutter/material.dart';

class ClassTestin extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ClassTestin> {
  TextEditingController? customerID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Null Check Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simulate setting customerID to null
                setState(() {
                  customerID = TextEditingController(text: '23432');
                });
              },
              child: Text('Set customerID to "23432"'),
            ),
            SizedBox(height: 20),
            // Display different text based on the nullability of customerID
            customerID == null
                ? Text('Text: null')
                : Text('Text: ${customerID!.text}'),
          ],
        ),
      ),
    );
  }
}
