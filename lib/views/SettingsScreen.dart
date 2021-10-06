import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/views/EditProfile.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  List<String> listMenu = ['My account', 'Change password', 'Courses registered', 'Help & support', 'Terms & conditions', 'Privacy & policies'];
  List<IconData> listIcons = [Icons.account_box, Icons.lock, Icons.event, Icons.help, Icons.add_photo_alternate_sharp, Icons.privacy_tip];

  String theme;

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 15, color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
        ),
      ),
      body: Container(
        height: Get.size.height,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          navigate(index);
                        },
                        leading: Icon(listIcons[index], color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
                        trailing: Icon(Icons.arrow_forward_ios_sharp, color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
                        title: Text(
                          listMenu[index],
                          style: TextStyle(color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  void navigate(int index) {
    switch (index) {
      case 0:
        Get.to(EditProfile());
        break;
    }
  }
}
