// ignore_for_file: unused_import, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_is_empty, use_build_context_synchronously
import 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:getwidget/getwidget.dart';
import 'package:web_admin/Auth/register.dart';
import 'package:web_admin/api/api_service.dart';
import 'package:web_admin/interface/homepage.dart';
import '../screen/Property/FirstProperty/MenuPage/My Account/ChatUsers/UsersChat/chat_screen.dart';
import '../../components/contants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Customs/ProgressHUD.dart';
import '../Customs/responsive.dart';
import '../models/login_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (MediaQuery.of(context).size.longestSide <= 1124.0)
          ? EdgeInsets.only(left: 50, right: 50)
          : EdgeInsets.only(left: 0, right: 0),
      child: Login(),
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
  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  int id = 0;
  String username = "";
  String first_name = "";
  String last_name = "";
  String emails = "";
  String gender = "";
  String from = "";
  String tel = "";
  // static List<PeopleModel> list = [];
  static bool status = false;
  // PeopleModel? peopleModel;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   // Fill in password field when page is loaded
  //   fillInPassword();
  // }
  void saveEmail(String email) {
    html.window.localStorage['email'] = email;
  }

  void savePassword(String password) {
    html.window.localStorage['password'] = password;
  }

  void fillInEmail() {
    final email = html.window.localStorage['email'];
    if (email != null) {
      _emailController.text = email;
    }
  }

  void fillInPassword() {
    final password = html.window.localStorage['password'];
    if (password != null) {
      _passwordController.text = password;
    }
  }

  @override
  void initState() {
    // selectPeople();
    status;
    // list;
    super.initState();
    fillInEmail();
    fillInPassword();
    requestModel = LoginRequestModel(email: "", password: "");
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

  Widget _uiSteup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          // 'assets/images/KFA-Logo.png',
          'assets/images/KFA-Logo.png',
          height: 80,
          width: 100,
        ),
        toolbarHeight: 100,
      ),
      backgroundColor: kwhite_new,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: kwhite,
          //color: Colors.amber.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35.0),
            topLeft: Radius.circular(35.0),
          ),
          boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
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
                // ignore: prefer_const_literals_to_create_immutables
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

            SizedBox(
              height: 30.0,
            ),
            ((status == false) ? input(context) : Output(context)),

            SizedBox(
              height: 10.0,
            ),
            // ignore: deprecated_member_use
            SizedBox(
              width: 150,
              child: GFButton(
                onPressed: () {
                  if (validateAndSave()) {
                    APIservice apIservice = APIservice();
                    apIservice.login(requestModel).then((value) {
                      Load(value.token);
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (value.message == "Login Successfully!") {
                        saveEmail(_emailController.text);
                        savePassword(_passwordController.text);
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: requestModel.email,
                          password: requestModel.password,
                        );

                        AwesomeDialog(
                          btnOkOnPress: () {},
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.success,
                          showCloseIcon: false,
                          title: 'Login Successfuly',
                          autoHide: Duration(seconds: 3),
                          onDismissCallback: (type) {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) =>
                            //       Chat_Message(uid: '191K877F994A', userId: '192K381F363A'),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    password: requestModel.password,
                                    controller_user: value.user['control_user'],
                                    set_email: requestModel.email,
                                    set_password: requestModel.password,
                                    user: value.user['username'],
                                    email: value.user['email'],
                                    first_name: value.user['first_name'],
                                    last_name: value.user['last_name'],
                                    gender: value.user['gender'],
                                    from: value.user['known_from'],
                                    tel: value.user['tel_num'],
                                    id: value.user['id'].toString(),
                                  ),
                                ));
                          },
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: value.message,
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                        print(value.message);
                      }
                    });
                    // ignore: avoid_print
                    print(requestModel.toJson());
                  }
                },
                color: kwhite_new,
                text: "Login",
                // elevation: 5,
                hoverElevation: 10,
                hoverColor: kImageColor,
                boxShadow: BoxShadow(
                    blurRadius: 5,
                    color: Colors.black45,
                    offset: Offset(-2, 5)),
                shape: GFButtonShape.pills,
                fullWidthButton: true,
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "Don't have any account? ",
                style: TextStyle(fontSize: 16.0, color: kTextLightColor),
              ),
              TextSpan(
                text: 'Register',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                style: TextStyle(
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
  Future firebaseLogin(value) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: requestModel.email,
        password: requestModel.password,
      );

      AwesomeDialog(
        btnOkOnPress: () {},
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: false,
        title: 'value.message',
        autoHide: Duration(seconds: 3),
        onDismissCallback: (type) {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) =>
          //       Chat_Message(uid: '191K877F994A', userId: '192K381F363A'),
          // builder: (context) => HomePage(
          //   control_user: value.user['control_user'],
          //   set_email: requestModel.email,
          //   set_password: requestModel.password,
          //   user: value.user['username'],
          //   email: value.user['email'],
          //   first_name: value.user['first_name'],
          //   last_name: value.user['last_name'],
          //   gender: value.user['gender'],
          //   from: value.user['known_from'],
          //   tel: value.user['tel_num'],
          //   id: value.user['id'].toString(),
          // ),
          // ));
        },
      ).show();
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // navigatorKey.currentState!.popUntil(((route) => route.isFirst));
  }

  List listUser = [];
  void Load(String token) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        listUser = jsonData;
        id = jsonData["id"];
        username = jsonData['username'];
        first_name = jsonData['first_name'];
        last_name = jsonData['last_name'];
        emails = jsonData['email'];
        gender = jsonData['gender'];
        from = jsonData['known_from'];
        tel = jsonData['tel_num'];
      });
      print(id.toString());
    }
  }

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
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _emailController,
              //obscureText: true,
              // textInputAction: TextInputAction.next,
              // onEditingComplete: () => TextInput.finishAutofillContext(),
              // autofillHints:  [AutofillHints.email],
              // controller: Email,
              onSaved: (input) => requestModel.email = input!,
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
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            //   height: 55,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _passwordController,
              // initialValue: "list[0].password",
              //   textInputAction: TextInputAction.next,
              //  autofillHints:  [AutofillHints.password],
              //  onEditingComplete: () => TextInput.finishAutofillContext(),
              onSaved: (input) => requestModel.password = input!,
              obscureText: _isObscure,
              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelText: 'Enter password',
                prefixIcon: Icon(
                  Icons.key,
                  color: kImageColor,
                ),
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
                  borderSide: BorderSide(
                    width: 1,
                    color: kerror,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: kerror,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
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

  Widget Output(BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              // textInputAction: TextInputAction.next,
              // autofillHints:  [AutofillHints.email],
              // onEditingComplete: () => TextInput.finishAutofillContext(),
              controller: _emailController,
              onSaved: (input) => requestModel.email = input!,
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
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            //   height: 55,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              // textInputAction: TextInputAction.next,
              // onEditingComplete: () => TextInput.finishAutofillContext(),
              // autofillHints: [AutofillHints.password],
              controller: _passwordController,
              // initialValue: "list[0].password",
              onSaved: (input) => requestModel.password = input!,
              obscureText: _isObscure,
              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelText: 'Enter password',
                prefixIcon: Icon(
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
                  borderSide: BorderSide(
                    width: 1,
                    color: kerror,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: kerror,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
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
