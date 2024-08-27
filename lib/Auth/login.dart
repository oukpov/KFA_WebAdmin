import 'dart:html' as html;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:web_admin/Auth/register.dart';
import '../Customs/ProgressHUD.dart';
import '../Customs/responsive.dart';
import '../components/colors.dart';
import '../getx/Auth/Auth.dart';
import '../models/Auth/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (MediaQuery.of(context).size.longestSide <= 1124.0)
          ? const EdgeInsets.only(left: 50, right: 50)
          : const EdgeInsets.only(left: 0, right: 0),
      child: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool isApiCallProcess = false;
  int id = 0;
  static bool status = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthenModel authenModel = AuthenModel();
  @override
  void initState() {
    super.initState();
    authentication.login(authenModel, context);
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  Authentication authentication = Authentication();
  Widget _uiSteup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/KFA-Logo.png',
          height: 80,
          width: 100,
        ),
        toolbarHeight: 100,
      ),
      backgroundColor: kwhite_new,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35.0),
            topLeft: Radius.circular(35.0),
          ),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
        ),
        child: SingleChildScrollView(
          child: Responsive(
            mobile: login(context),
            tablet: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: login(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
            desktop: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: login(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
            phone: login(context),
          ),
        ),
      ),
    );
  }

  Padding login(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Welcome to KFA system',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "ONE CLICK ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kImageColor,
                    ),
                  ),
                  TextSpan(
                    text: "1\$",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: kerror,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            ((status == false) ? input(context) : output(context)),
            const SizedBox(height: 10.0),
            SizedBox(
              width: 150,
              child: GFButton(
                onPressed: () {
                  setState(() {
                    if (authenModel.user == null || authenModel.user!.isEmpty) {
                      authenModel.user = [User()];
                    }

                    authenModel.user![0].username = 'somnang.se';
                    authenModel.user![0].password = 'KFA@somnang2023';
                  });
                  authentication.login(authenModel, context);
                },
                color: kwhite_new,
                text: "Login",
                hoverElevation: 10,
                hoverColor: kImageColor,
                boxShadow: const BoxShadow(
                    blurRadius: 5,
                    color: Colors.black45,
                    offset: Offset(-2, 5)),
                shape: GFButtonShape.pills,
                fullWidthButton: true,
              ),
            ),
            const SizedBox(height: 20.0),
            Text.rich(TextSpan(children: [
              const TextSpan(
                text: "Don't have any account? ",
                style: TextStyle(fontSize: 16.0, color: kTextLightColor),
              ),
              TextSpan(
                text: 'Register',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kImageColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }

  bool successfuly = false;
  // Future firebaseLogin(value) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: requestModel.email,
  //       password: requestModel.password,
  //     );

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget input(BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _emailController,
              //obscureText: true,
              // textInputAction: TextInputAction.next,
              // onEditingComplete: () => TextInput.finishAutofillContext(),
              // autofillHints:  [AutofillHints.email],
              // controller: Email,
              // onSaved: (input) => requestModel.email = input!,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email, color: kImageColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromRGBO(0, 126, 250, 1)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromARGB(255, 249, 0, 0)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 249, 0, 0)),
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
          ),
          const SizedBox(height: 10),
          Padding(
            //   height: 55,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _passwordController,
              // initialValue: "list[0].password",
              //   textInputAction: TextInputAction.next,
              //  autofillHints:  [AutofillHints.password],
              //  onEditingComplete: () => TextInput.finishAutofillContext(),
              // onSaved: (input) => requestModel.password = input!,
              obscureText: _isObscure,
              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelText: 'Enter password',
                prefixIcon: const Icon(Icons.key, color: kImageColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    color: kImageColor,
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  // onPressed: () {
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: kerror),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: kerror),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'require *';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget output(BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _emailController,
              onChanged: (input) => authenModel.user![0].username = input,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                labelText: 'UserName',
                prefixIcon: const Icon(
                  Icons.email,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color.fromRGBO(0, 126, 250, 1),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromARGB(255, 249, 0, 0)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 249, 0, 0)),
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
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _passwordController,
              onChanged: (input) => authenModel.user![0].password = input,
              obscureText: _isObscure,
              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelText: 'Enter password',
                prefixIcon: const Icon(
                  Icons.key,
                  color: kImageColor,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    color: kImageColor,
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: kerror),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: kerror),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'require *';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
