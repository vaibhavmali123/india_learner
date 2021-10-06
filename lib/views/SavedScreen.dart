import 'dart:convert';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/PdfViewer.dart';

class SavedScreen extends StatefulWidget {
  SavedScreenState createState() => SavedScreenState();
}

class SavedScreenState extends State<SavedScreen> {
  String theme;
  PDFDocument document;
  bool isLoading = false;
  List<dynamic> notesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    String str = Database.getDownloadedNotes();
    print("NOTESSS ${str}");
    if (str != null) {
      notesList = json.decode(str);
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;

    return Scaffold(
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
        title: Text('Saved', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 6,
              child: notesList != null
                  ? ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {},
                            child: Padding(
                                padding: EdgeInsets.only(top: 22),
                                child: Container(
                                    child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 10, left: 14),
                                            height: 75,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.cyan.withOpacity(0.3),
                                            ),
                                            child: Center(
                                                child: Icon(
                                              Icons.picture_as_pdf,
                                              size: 40,
                                            )))
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
                                              notesList[index]['title'],
                                              style: TextStyle(fontSize: 15, height: 2, color: Colors.cyan, fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        ButtonTheme(
                                          minWidth: Get.size.width / 3,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Get.to(PdfViewer(pdfDocument: notesList[index]['path']));
                                            },
                                            color: color.primaryColor,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                                            child: Text(
                                              'Read now',
                                              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        )
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
      /*Container(height: Get.size.height, width: Get.size.width, child: isLoading == true ? PDFViewer(document: document) : CircularProgressIndicator())*/,
    );
  }

  void getDocument(int index) async {
    document = await PDFDocument.fromFile(File(notesList[index]['path'].toString()));
    setState(() {
      isLoading = true;
    });
  }
}
