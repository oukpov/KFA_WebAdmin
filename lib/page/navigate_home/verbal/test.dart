import 'package:flutter/material.dart';

class MyFormTTTT extends StatefulWidget {
  @override
  _MyFormTTTTState createState() => _MyFormTTTTState();
}

class _MyFormTTTTState extends State<MyFormTTTT> {
  final _formKey = GlobalKey<FormState>();
  String usernameC = '';
  String usernameS = '';
  String tempUsername = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),

                // Called every time the text changes
                onChanged: (value) {
                  setState(() {
                    usernameC = value;
                  });
                  print("onChanged: $value");
                },

                onSaved: (value) {
                  setState(() {
                    usernameS = value ?? '';
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Triggers onSaved for each field in the form
                    _formKey.currentState!.save();
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text(
                    //       "Form Saved! Username: $username",
                    //     ),
                    //   ),
                    // );
                  }
                },
                child: Text('Save'),
              ),
              SizedBox(height: 20),
              Text("Live Username (onChanged): $usernameC"),
              Text("Final Username (onSaved): $usernameS"),
            ],
          ),
        ),
      ),
    );
  }
}
