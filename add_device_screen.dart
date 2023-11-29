import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nearbyconnect/core/colors.dart';
import 'package:nearbyconnect/core/text_style.dart';
import 'package:nearbyconnect/screens/setting_screen.dart';


class AddDevicePage extends StatefulWidget {
  final token;
    const AddDevicePage({@required this.token,Key? key}) : super(key: key);
  @override
  AddDeviceState createState() => AddDeviceState();
}

class AddDeviceState extends State<AddDevicePage>
{

//-----------These are text controllers to get text from user----------------
  late String userid;
  TextEditingController devicenameController = TextEditingController();
  TextEditingController devicetypeController = TextEditingController();
  bool _isNotValidate = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userid = jwtDecodedToken['_id'];

  }
//-------------This is the function to register user through API --------------------
  void addDevice() async{
    if(devicenameController.text.isNotEmpty && devicetypeController.text.isNotEmpty)
    {
      var regBody = {
        "userid" : userid,
        "devicename":devicenameController.text,
        "devicetype":devicetypeController.text,
      };

      var response = await http.post(Uri.parse(adddevice),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);
    }
    else{
      setState(()
      {
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
            const Positioned(
              top: 85,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Add A device',
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
                      controller: devicenameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: blackTextFild,
                          errorStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: "Device Name",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: grayText,
                            fontWeight: FontWeight.bold, // Customize the hint text color
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                      style: headline2,
                    ).p4().px24(),
                    TextField(
                      controller: devicetypeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: blackTextFild,
                          errorStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: "Device Type",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: grayText,
                            fontWeight: FontWeight.bold,// Customize the hint text color
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                      style: headline2,
                    ).p4().px24(),
                    SizedBox(height: 80.0),
                    GestureDetector(
                      onTap: () {
                        addDevice();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingPage(token: widget.token,)));
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
                        child: const Center(
                          child: Text(
                            "Add Device",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
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

