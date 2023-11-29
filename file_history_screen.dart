import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nearbyconnect/core/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nearbyconnect/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nearbyconnect/screens/share_file_screen.dart';
import 'package:nearbyconnect/core/text_style.dart';


class FileHistory extends StatefulWidget {
  final token;
  const FileHistory({@required this.token,Key? key}) : super(key: key);

  @override
  State<FileHistory> createState() => FileHistoryState();
}

class FileHistoryState extends State<FileHistory> {

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

  /*void getDeviceList(userId) async {
    var regBody = {
      "userid":userid
    };

    var response = await http.post(Uri.parse(getdevice),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regBody)
    );

    var jsonResponse = jsonDecode(response.body);
    items = jsonResponse['success'];

    setState(() {

    });
  }*/

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

  void deleteItem(id) async{
    var regBody = {
      "id":id
    };
    var response = await http.post(Uri.parse(deletefile),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regBody)
    );
    var jsonResponse = jsonDecode(response.body);
    if(jsonResponse['status']){
      getFileList(userid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60.0,left: 30.0,right: 30.0,bottom: 30.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //CircleAvatar(child: Icon(Icons.list,size: 30.0,),backgroundColor: Colors.white,radius: 30.0,),
                SizedBox(height: 40.0),
                Text('File History',style:headline1),
                SizedBox(height: 40.0),
              ],
            ),
          ),
          Expanded(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: blackTextFild,
                  border: Border.all(
                    color: Color(0xFF5468FF),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: items == null
                      ? null
                      : ListView.builder(
                    itemCount: items!.length,
                    itemBuilder: (context, int index) {
                      return Card(
                        color: blackBG,
                        borderOnForeground: false,

                        child: ListTile(
                          leading: const Icon(Icons.file_copy_rounded,color: Colors.white,),
                          title: Text('${items![index]['filetype']}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text('${items![index]['filepath']}',
                            style: const TextStyle(
                              color: grayText,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}