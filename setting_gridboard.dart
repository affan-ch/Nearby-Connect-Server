import 'package:flutter/material.dart';
import 'package:nearbyconnect/screens/homepage.dart';
import 'package:nearbyconnect/screens/log_in_screen.dart';
import 'package:nearbyconnect/screens/share_file_screen.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:nearbyconnect/core/colors.dart';
import 'package:nearbyconnect/core/text_style.dart';
import 'package:nearbyconnect/screens/add_device_screen.dart';
import 'package:nearbyconnect/screens/file_history_screen.dart';
import 'package:nearbyconnect/screens/setting_screen.dart';

class SettingGridDashboard extends StatelessWidget {

  final token;
  const SettingGridDashboard({@required this.token,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [ Items(
        title: "Add a Device",
        img: IconButton(
          alignment: Alignment.topCenter,
          icon: const Icon(
            Icons.phone_iphone_outlined,
            color:Colors.white ,//Color(0xFF5468FF),//Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDevicePage(token: token,),
              ),
            );

          },
        )
    ),
      Items(
        title: "Log Out",
        img: IconButton(
          alignment: Alignment.topCenter,
          icon: const Icon(
            Icons.logout,
            color:Colors.white,//Color(0xFF5468FF),
          ),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogInPage(),
            ),
          );
          },
        ),
      ),
      Items(
        title: "Home",
        img: IconButton(
          alignment: Alignment.topCenter,
          icon: const Icon(
            Icons.home,
            color:Colors.white,//Color(0xFF5468FF),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(token: token),
              ),
            );
          },
        ),
      ),
    ];

    return Flexible(
      child: GridView.count(
          childAspectRatio: 2,
          padding: const EdgeInsets.only(left: 35, right: 35,top: 20),
          crossAxisCount: 1,
          crossAxisSpacing:10,
          mainAxisSpacing: 10,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: blackTextFild,
                  border: Border.all(
                    color: const Color(0xFF5468FF), // Set the desired border color here
                    width: 2, // Set the width of the border
                  ),
                  borderRadius: BorderRadius.circular(20)

              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  data.img,

                  const SizedBox(
                    height: 5,
                  ),
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
