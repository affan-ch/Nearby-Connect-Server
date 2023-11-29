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
import 'package:nearbyconnect/screens/file_history_screen.dart';
import 'package:nearbyconnect/screens/log_in_screen.dart';
import 'package:nearbyconnect/widget/main_button.dart';
import 'package:nearbyconnect/widget/text_fild.dart';
import 'package:nearbyconnect/screens/setting_screen.dart';

class GridDashboard extends StatelessWidget {

  final token;
  const GridDashboard({@required this.token,Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Items> myList = [ Items(
        title: "Share Files",
        img: IconButton(
          alignment: Alignment.topCenter,
          icon: const Icon(
            Icons.share_outlined,
            color:Colors.white ,//Color(0xFF5468FF),//Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShareFilePage(token: token,),
              ),
            );
          },
        )
    ),

    Items(
        title: "Settings",
        img: IconButton(
          alignment: Alignment.topCenter,
          icon: const Icon(
            Icons.settings_suggest_sharp,
            color: Colors.white,//Color(0xFF5468FF),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => SettingPage(token: token,)));
            },
        )
    ),
      Items(
        title: "File History",

        img: IconButton(
          alignment: Alignment.topCenter,
          icon: const Icon(
            Icons.history_toggle_off_sharp,
            color:Colors.white,//Color(0xFF5468FF),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FileHistory(token: token),
              ),
            );
          },
        ),
      ),
      Items(
        title: "Your Device",

        img: IconButton(
          alignment: Alignment.topCenter,
          icon: const Icon(
            Icons.phone_iphone,
            color:Colors.white,//Color(0xFF5468FF),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FileHistory(token: token),
              ),
            );
          },
        ),
      ),


    ];

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1,
          padding: EdgeInsets.only(left: 16, top : 13, right: 16,bottom: 0),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 19,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: blackTextFild,
                  border: Border.all(
                    color: Color(0xFF5468FF), // Set the desired border color here
                    width: 2, // Set the width of the border
                  ),
                  borderRadius: BorderRadius.circular(20)

              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  data.img,
                  Text(
                    data.title,
                    style: headline2,
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  IconButton img;

  Items({required this.title,required this.img});
}
