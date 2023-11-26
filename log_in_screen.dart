import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nearbyconnect/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nearbyconnect/screens/share_file_screen.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:nearbyconnect/core/colors.dart';
import 'package:nearbyconnect/core/space.dart';
import 'package:nearbyconnect/core/text_style.dart';
import 'package:nearbyconnect/screens/homepage.dart';
import 'package:nearbyconnect/screens/share_file_screen.dart';
import 'package:nearbyconnect/screens/log_in_screen.dart';
import 'package:nearbyconnect/widget/main_button.dart';
import 'package:nearbyconnect/widget/text_fild.dart';

class LogInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<LogInPage> {
  TextEditingController unameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;

  get token => null;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (unameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "username": unameController.text,
        "password": passwordController.text
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(token: token)));
      } else {
        print('Something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackBG,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 65,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Welcome Back!',
                  style: headline1,
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Please sign in to your account',
                  style: headline3,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SpaceVH(height: 30.0),
                    TextField(
                      controller: unameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: blackTextFild,
                          hintText: "User Name",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: grayText,
                            fontWeight: FontWeight.bold, // Customize the hint text color
                          ),
                          errorText:
                          _isNotValidate ? "Enter Proper Info" : null,
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                      style: headline2,
                    ).p4().px24(),
                    TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: blackTextFild,
                          errorStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: grayText,
                            fontWeight: FontWeight.bold,// Customize the hint text color
                          ),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                      style: headline2,
                    ).p4().px24(),
                    SizedBox(height: 80.0),
                    GestureDetector(
                      onTap: () {
                        loginUser();
                      },
                      child: Container(
                        height: 70.0,
                        width: 320.0,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF5468FF),
                          borderRadius: BorderRadius.circular(50),
                          //padding: EdgeInsets.all(16.0),
                        ),
                        child: Center(
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),


                    SpaceVH(height: 10.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Don\' have an account? ',
                            style: headline.copyWith(fontSize: 14.0),
                          ),
                          TextSpan(
                            text: ' Sign Up',
                            style: headlineDot.copyWith(fontSize: 14.0),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
