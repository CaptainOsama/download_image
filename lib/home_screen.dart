// import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String get url => "https://media.almashhad.com/storage/attachments/3473/%D9%85%D8%B4%D8%A7%D9%87%D8%AF%D8%A9-%D8%B5%D9%88%D8%B1-%D8%A7%D9%84%D9%82%D8%AA%D9%84%D9%89-%D9%88%D8%A7%D9%84%D8%AF%D9%85%D8%A7%D8%A1-%D9%81%D9%8A-%D8%BA%D8%B2%D8%A9-%D9%83%D9%8A%D9%81-%D9%8A%D8%AC%D8%A8-%D8%A7%D9%84%D8%AA%D8%B9%D8%A7%D9%85%D9%84-%D9%85%D8%B9%D9%87-1697525597627_highres.webp";

  @override
  Widget build(BuildContext context) {
    String url =
        "https://media.almashhad.com/storage/attachments/3473/%D9%85%D8%B4%D8%A7%D9%87%D8%AF%D8%A9-%D8%B5%D9%88%D8%B1-%D8%A7%D9%84%D9%82%D8%AA%D9%84%D9%89-%D9%88%D8%A7%D9%84%D8%AF%D9%85%D8%A7%D8%A1-%D9%81%D9%8A-%D8%BA%D8%B2%D8%A9-%D9%83%D9%8A%D9%81-%D9%8A%D8%AC%D8%A8-%D8%A7%D9%84%D8%AA%D8%B9%D8%A7%D9%85%D9%84-%D9%85%D8%B9%D9%87-1697525597627_highres.webp";
    return Scaffold(
      appBar: AppBar(
        title: Text("untitled"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.indigo,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              height: 200,
              width: 300,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                // DownloadFile();
                _saveNetworkImage();
              },
              child: Text("Download"))
        ],
      ),
    );
  }

  _saveNetworkImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio().get(
          "https://media.almashhad.com/storage/attachments/3473/%D9%85%D8%B4%D8%A7%D9%87%D8%AF%D8%A9-%D8%B5%D9%88%D8%B1-%D8%A7%D9%84%D9%82%D8%AA%D9%84%D9%89-%D9%88%D8%A7%D9%84%D8%AF%D9%85%D8%A7%D8%A1-%D9%81%D9%8A-%D8%BA%D8%B2%D8%A9-%D9%83%D9%8A%D9%81-%D9%8A%D8%AC%D8%A8-%D8%A7%D9%84%D8%AA%D8%B9%D8%A7%D9%85%D9%84-%D9%85%D8%B9%D9%87-1697525597627_highres.webp",
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
    }
  }

  // void DownloadFile() async{
  //   var time = DateTime.now().microsecondsSinceEpoch;
  //   var path = "/Download$time.jpg";
  //   var file =File(path);
  //   String nrl = "";
  //   var res = await Dio().get(url);
  //   file.writeAsBytes(res.bodyBytes);

  // }
}
