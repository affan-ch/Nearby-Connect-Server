import 'dart:io';
import 'package:file_selector/file_selector.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:share_plus/share_plus.dart';
import 'image_previews.dart';
import 'package:nearbyconnect/core/colors.dart';
import 'package:nearbyconnect/core/text_style.dart';
import 'package:nearbyconnect/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class ShareFilePage extends StatefulWidget
{
  final token;
  const ShareFilePage({@required this.token,Key? key}) : super(key: key);

  @override
  ShareFilePageState createState() => ShareFilePageState();
}

class ShareFilePageState extends State<ShareFilePage>
{
  late String senderuserid;
  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];
  bool _isNotValidate = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    senderuserid = jwtDecodedToken['_id'];

  }

  void storeFiles() async{


      var regBody = {
        "filename": imageNames,
        "filepath": imagePaths,
        "filetype" : "image",
        "senderuserid" : senderuserid

      };

      var response = await http.post(Uri.parse(addFile),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if(jsonResponse['status']){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(token: widget.token,)));
      }else{
        print("SomeThing Went Wrong");
      }
      setState(() {
        _isNotValidate = true;
      });

  }

  void storeTransfer() async{
    var regBody = {
      "transferstatus": "Successful",
      "transfertype": "Everyone",
      "userid" : senderuserid,
    };

    var response = await http.post(Uri.parse(addTransfer),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regBody)
    );

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse['status']);

    setState(() {
      _isNotValidate = true;
    });

  }


  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
      (
      debugShowCheckedModeBanner: false,
      title: 'Share Files Here',
      theme: ThemeData
        (
          useMaterial3: true,
          colorSchemeSeed: const Color(0x9f4376f8),
        ),
      home: Scaffold
        (
          backgroundColor: blackBG,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0,left: 10.0), // Adjust horizontal padding as needed
            child: Text(
              "Share File",
              style: headline1,
            ),
          ),
          backgroundColor: blackBG,
        ),
        body: SingleChildScrollView(

          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration:  InputDecoration(
                  filled : true,
                  fillColor: blackTextFild,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Share text',
                  hintText: 'Enter the text you want to share',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: grayText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: null,
                onChanged: (String value) {
                  text = value;
                },
                style: headline2,
              ),

              const SizedBox(height: 16),
              TextField(
                decoration:  InputDecoration(
                  filled : true,
                  fillColor: blackTextFild,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Share subject',
                  hintText: 'Enter the subject you want to share',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: grayText,
                    fontWeight: FontWeight.bold, // Customize the hint text color
                  ),
                ),
                maxLines: null,
                onChanged: (String value) {
                  subject = value;

                },
                style: headline2,
              ),

              const SizedBox(height: 16),
              TextField(
                decoration:  InputDecoration(
                  filled : true,
                  fillColor: blackTextFild,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    ),
                  labelText: 'Share uri',
                  hintText: 'Enter the uri you want to share',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: grayText,
                    fontWeight: FontWeight.bold, // Customize the hint text color
                  ),
                ),
                maxLines: null,
                onChanged: (String value) {
                  setState(() => uri = value);

                },
                style: headline2,
              ),

              const SizedBox(height: 16),
              ImagePreviews(imagePaths, onDelete: _onDeleteImage),

              ElevatedButton.icon(
                label: const Text('Add image'),
                onPressed: () async {
                  // Using `package:image_picker` to get image from gallery.
                  if (!kIsWeb &&
                      (Platform.isMacOS ||
                          Platform.isLinux ||
                          Platform.isWindows)) {
                    // Using `package:file_selector` on windows, macos & Linux, since `package:image_picker` is not supported.
                    const XTypeGroup typeGroup = XTypeGroup(
                      label: 'images',
                      extensions: <String>['jpg', 'jpeg', 'png', 'gif'],
                    );
                    final file = await openFile(
                        acceptedTypeGroups: <XTypeGroup>[typeGroup]);
                    if (file != null) {
                      setState(() {
                        imagePaths.add(file.path);
                        imageNames.add(file.name);
                      });
                    }
                  } else {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        imagePaths.add(pickedFile.path);
                        imageNames.add(pickedFile.name);
                      });
                    }
                  }
                },

                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF5468FF)//foregroundColor: Colors.blue, // Change the text color here
                  // Additional styling properties can be added here as needed
                ),
              ),

              const SizedBox(height: 32),
              Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: blackBG,//Color(0xFF5468FF), // Set the border color here
                        width: 2.0, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(50.0), // Set the border radius
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,//Color(0xFF5468FF),
                        backgroundColor: Color(0xFF5468FF),
                      ),
                      onPressed: text.isEmpty && imagePaths.isEmpty && uri.isEmpty ? null : () => _onShare(context),
                      child: const Text('Share'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
      imageNames.removeAt(position);
    });
  }

  void _onShare(BuildContext context) async
  {

    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    if (uri.isNotEmpty) {
      await Share.shareUri(Uri.parse(uri));
    } else if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));

      }

      await Share.shareXFiles(files,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
    else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
    storeTransfer();
    storeFiles();

  }
}
