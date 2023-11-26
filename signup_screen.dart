import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nearbyconnect/screens/log_in_screen.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nearbyconnect/screens/share_file_screen.dart';
import 'config.dart';
import 'package:nearbyconnect/core/colors.dart';
import 'package:nearbyconnect/core/space.dart';
import 'package:nearbyconnect/core/text_style.dart';
import 'package:nearbyconnect/screens/share_file_screen.dart';
import 'package:nearbyconnect/screens/log_in_screen.dart';
import 'package:nearbyconnect/widget/main_button.dart';
import 'package:nearbyconnect/widget/text_fild.dart';

class SignupPage extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<SignupPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController spController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async{
    if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty && spController.text.isNotEmpty)
    {

      var regBody = {
        "username":usernameController.text,
        "password":passwordController.text,
        "sharingpreference" : spController.text
      };

      var response = await http.post(Uri.parse(register),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if(jsonResponse['status']){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInPage()));
      }else{
        print("SomeThing Went Wrong");
      }
    }else{
      setState(() {
        _isNotValidate = true;
      });
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
          'Create your Account',
          style: headline1,
        ),
      ),
    ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HeightBox(70),
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: blackTextFild,
                          errorStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: "Username",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: grayText,
                            fontWeight: FontWeight.bold, // Customize the hint text color
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                      style: headline2,
                    ).p4().px24(),
                    TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(icon: Icon(Icons.copy),onPressed: (){
                            final data = ClipboardData(text: passwordController.text);
                            Clipboard.setData(data);
                          },),
                          prefixIcon: IconButton(icon: Icon(Icons.password),onPressed: (){
                            String passGen =  generatePassword();
                            passwordController.text = passGen;
                            setState(() {

                            });
                          },),
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
                    TextField(
                      controller: spController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: blackTextFild,
                          errorStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: "Sharing Preference",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: grayText,
                            fontWeight: FontWeight.bold,// Customize the hint text color
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                    ).p4().px24(),
                    SizedBox(height: 80.0),
                    GestureDetector(
                      onTap: () {
                        registerUser();
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



                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: headline.copyWith(fontSize: 14.0),
                          ),
                          TextSpan(
                            text: ' Sign In',
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

String generatePassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  String symbols = '!@#\$%^&*()<>,./';

  String password = '';

  int passLength = 20;

  String seed = upper + lower + numbers + symbols;

  List<String> list = seed.split('').toList();

  Random rand = Random();

  for (int i = 0; i < passLength; i++) {
    int index = rand.nextInt(list.length);
    password += list[index];
  }
  return password;
}