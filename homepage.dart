import 'package:flutter/material.dart';
import 'dart:convert';
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
import 'griddashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class HomePage extends StatefulWidget {
  final token;
  const HomePage({@required this.token,Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late String userid;
  List? items ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userid = jwtDecodedToken['_id'];
    getFileList(userid);
  }

  void getFileList(userid) async {
    var regBody = {
      "userid":userid
    };

    var response = await http.post(Uri.parse(getfiles),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regBody)
    );

    var jsonResponse = jsonDecode(response.body);
    items = jsonResponse['success'];

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: blackBG,//blackBG,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
           const Padding(
            padding: EdgeInsets.only(left: 16, right: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Home",
                      style: headline1,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Making File Sharing Easy",
                      style: headline3,
                    ),
                    //GridDashboard(token: widget.token),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 110,
          ),
          GridDashboard(token: widget.token),
          const SizedBox(
            height: 10,
          ),
          //GridDashboard(token: widget.token),


        ],

      ),
    );

  }
}