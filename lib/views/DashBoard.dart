import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/BrowseNav.dart';
import 'package:india_learner/views/CategoriesPage.dart';
import 'package:india_learner/views/ClassesOrCoursesScreen.dart';
import 'package:india_learner/views/FreeLiveClass.dart';
import 'package:india_learner/views/HomePageNav.dart';
import 'package:india_learner/views/PlusCoursesScreen.dart';
import 'package:india_learner/views/SettingsScreen.dart';
import 'package:india_learner/views/SubscriptionPage.dart';
import 'package:india_learner/views/TestsNav.dart';
import 'package:india_learner/views/UpdatesNav.dart';

class DashBoard extends StatefulWidget {
  DashBoardState createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int currentIndex = 0;
  List<Widget> _children = [HomePageNav(), TestsNav(), BrowseNav(), UpdatesNav()];
  String categoryName;
  String duration;
  String theme, className;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    //print("categoryName ${Database.getSelectedCategory().length}");
    categoryName = Database.getSelectedCategory();
    className = Database.getClassName();
    setState(() {
      if (className == null) {
        className = " ";
      }
    });
    print("Class ${Database.getClassName()}");
    duration = Database.getPlan();
  }

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.storage),
            color: Colors.black,
            onPressed: () {
              setState(() {
                duration = Database.getPlan();
              });
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.search,
                size: 26,
                color: Colors.black,
              ),
              SizedBox(
                width: 14,
              ),
              Icon(
                Icons.supervised_user_circle,
                color: Colors.black,
              ),
              SizedBox(
                width: 18,
              )
            ],
          )
        ],
        title: Text(categoryName + className, style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      drawer: getDrawer(),
      bottomNavigationBar: getBottomNavigation(),
      body: _children[currentIndex],
    );
  }

  void onTapBottomNav(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  List<String> listMenu = ['Plus courses', 'Free live', 'Free  classes/courses', 'Get subscription'];
  List<Icon> menuIconsList = [
    Icon(
      Icons.add,
      color: Colors.black87,
    ),
    Icon(
      Icons.lock_open,
      color: Colors.black87,
    ),
    Icon(
      Icons.bookmark_outlined,
      color: Colors.black87,
    ),
    Icon(
      Icons.school,
      color: Colors.black87,
    ),
  ];

  getDrawer() {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(),
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightBlueAccent.withOpacity(0.2),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categoryName,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
                              ),
                              Text(
                                duration != null ? duration : "",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          tileColor: Colors.cyan,
                          title: Text(
                            'Select category',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                          onTap: () {
                            Get.to(CategoriesPage());
                          },
                          trailing: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              color: Colors.cyan,
              height: 1,
            ),
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  child: Container(
                color: theme == Constants.lightTheme ? Colors.white : color.darkCard,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                          itemCount: listMenu.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('NNNNNNNNNN');
                                navigate(index);
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        navigate(index);
                                      },
                                      leading: menuIconsList[index],
                                      title: Text(
                                        listMenu[index],
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Colors.black26,
                            width: MediaQuery.of(context).size.width,
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(SettingsScreen());
                            },
                            title: Text('Settings'),
                            leading: Icon(Icons.settings),
                          ),
                          ListTile(
                            onTap: () {
                              setState(() {
                                MediaQuery.of(context).platformBrightness == Brightness.dark;
                              });
                            },
                            title: Text('Dark mode'),
                            leading: Icon(Icons.switch_right_sharp),
                          ),
                          ListTile(
                            title: Text('Messages to teacher'),
                            leading: Icon(Icons.message_rounded),
                          ),
                          ListTile(
                            onTap: () {
                              Database.initDatabase();
                              Database.logout();
                            },
                            title: Text('Logout'),
                            leading: Icon(Icons.logout),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }

  getBottomNavigation() {
    return BottomNavigationBar(
      selectedItemColor: Colors.cyan,
      unselectedItemColor: Colors.black45,
      //backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      currentIndex: currentIndex,
      selectedLabelStyle: TextStyle(fontSize: 14, color: Colors.cyan),
      unselectedLabelStyle: TextStyle(fontSize: 14, color: Colors.black54),
      onTap: onTapBottomNav,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        /*BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Syllabus'),
          ),*/
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edit,
          ),
          title: Text('Tests'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.open_in_browser),
          title: Text('Browse', style: TextStyle(fontSize: 14, color: Colors.black54)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Updates', style: TextStyle(fontSize: 14, color: Colors.black54)),
        ),
      ],
    );
  }

  void navigate(int index) async {
    print('NNNNNNNNNN');

    switch (index) {
      case 0:
        Get.to(PlusCoursesScreen());
        break;
      case 1:
        await Get.to(FreeLiveClass());
        Get.back();
        break;
      case 2:
        await Get.to(ClassesOrCoursesScreen());
        break;
      case 3:
        await Get.to(SubscriptionPage());
        Get.back();
        break;
    }
  }
}
