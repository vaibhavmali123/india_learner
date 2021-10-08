import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/VideoDownloadsBloc.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/VideoPlayerLocal.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsPage extends StatefulWidget {
  DownloadsPageState createState() => DownloadsPageState();
}

class DownloadsPageState extends State<DownloadsPage> {
  //CachedVideoPlayerController controller;
  File file;
  List<dynamic> list = [];
  Map<String, dynamic> map;
  String theme;
  final videoDownloadBloc = VideoDownloadBloc();

  @override
  void initState() {
    // TODO: implement initState
//    getDownloads();
    super.initState();
    Database.initDatabase();
    String str = Database.getDownloadedVideos();
    print("TTTT str ${str.toString()}");

    if (str != null) {
      list = json.decode(str);
      map = list[0];
      print("TTTT ${map['file']}");
    }
    //controller = CachedVideoPlayerController.file(File(map['file']));
    /*controller.initialize().then((_) {
      setState(() {});
      controller.play();
    });*/
  }

  void getDownloads() async {
    var directory = await getTemporaryDirectory();
    DefaultCacheManager().getSingleFile(map['file'], key: 'test').then((value) {
      setState(() {
        file = File(value.path);
      });
      print("PPPPPPPPPPPPP ${value.path}");
    });
    print("PATH ${DefaultCacheManager().getSingleFile('http://oneroofcm.com/e_learning/uploads/testing.mp4', key: 'test')}");
    // print("PATH ${path.join(directory.path, 'test')}");
    /*controller = CachedVideoPlayerController.file(File(map['file']));
    controller.initialize().then((_) {
      setState(() {});
      controller.play();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    videoDownloadBloc.getDownloads();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Downloads', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 6,
              child: list.length > 0
                  ? ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        print("TTTTTTTTT ${list.toString()}");
                        return GestureDetector(
                            onTap: () {
                              print("TTTTTTTTT ${list[index]['file']}");

                              Get.to(VideoPlayerLocal(list[index]['file'], list[index]['title']));
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 6),
                                child: Container(
                                    width: Get.size.width / 1.1,
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(top: 10, left: 14),
                                                height: 70,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  color: Colors.cyan.withOpacity(0.3),
                                                ),
                                                child: Center(child: Image.asset('assets/images/download.jpg')))
                                          ],
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  list[index]['title'],
                                                  style: TextStyle(fontSize: 15, height: 2, color: Colors.cyan, fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width / 2,
                                              child: Text(
                                                'Description here',
                                                style: TextStyle(fontSize: 14, height: 1.4, color: theme == Constants.lightTheme ? color.lightText : color.darkText, fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Lesson name here',
                                                  style: TextStyle(fontSize: 14, height: 1.2, color: theme == Constants.lightTheme ? color.lightText : color.darkText, fontWeight: FontWeight.w600),
                                                ),
                                                Text(
                                                  '10:00 PM to 12:30 PM',
                                                  style: TextStyle(fontSize: 14, color: theme == Constants.lightTheme ? color.lightText : color.darkText, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Teacher name here',
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1.2,
                                                color: theme == Constants.lightTheme ? color.lightText : color.darkText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))));
                      })
                  : Container(
                      child: Center(
                        child: Utils.noData,
                      ),
                    ))
        ],
      )
          /*Column(
        children: [
          RaisedButton(onPressed: () {
            Stream<FileResponse> fileStream;
            setState(() {
              // fileStream = DefaultCacheManager().getFileStream('http://oneroofcm.com/e_learning/uploads/testing.mp4', withProgress: true, key: 'test');
              getDownloads();
            });
          }),
          SizedBox(
            height: 50,
          ),
          Container(
              height: 400,
              width: 300,
              child: file != null
                  ? controller.value != null && controller.value.initialized
                      ? AspectRatio(
                          child: CachedVideoPlayer(controller),
                          aspectRatio: controller.value.aspectRatio,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )
                  : Container())
        ],
      )*/
          ),
    );
  }
}
