import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import 'colors.dart';

class TextfieldValidate extends StatefulWidget {
  const TextfieldValidate({super.key});

  @override
  State<TextfieldValidate> createState() => _HometestState();
}

class _HometestState extends State<TextfieldValidate> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              // GFButton(
              //     text: 'Save',
              //     onPressed: () {
              //       setState(() {
              //         validateAndSave();
              //       });
              //     }),
              TextFormField(
                controller: _emailController,
                //obscureText: true,
                // textInputAction: TextInputAction.next,
                // onEditingComplete: () => TextInput.finishAutofillContext(),
                // autofillHints:  [AutofillHints.email],
                // controller: Email,
                //onSaved: (input) => requestModel.email = input!,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: kImageColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(0, 126, 250, 1),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 249, 0, 0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 249, 0, 0),
                    ),
                    //  borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'require *';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
