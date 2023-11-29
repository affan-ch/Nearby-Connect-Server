import 'package:flutter/material.dart';
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
import 'package:nearbyconnect/screens/setting_screen.dart';
import 'setting_gridboard.dart';


class SettingPage extends StatefulWidget {
  final token;
  const SettingPage({@required this.token,Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: blackBG,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Settings",
                      style: headline1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Making File Sharing Easy",
                      style: headline3,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          SettingGridDashboard(token: widget.token)
        ],

      ),

    );

  }
}