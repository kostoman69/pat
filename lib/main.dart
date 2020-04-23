import 'package:flutter/material.dart';
import 'package:starspat/gui/self_assessment_screen.dart';
import 'package:starspat/model/stars_account.dart';
//import 'package:starspat/services/service_locator.dart';
//import 'package:starspat/services/user_service.dart';

void main() {
  runApp(StarsPatApp());
}

class StarsPatApp extends StatelessWidget {
  final StarsAccount _account = StarsAccount(
    recordID: 15,
    accountID: 33,
    profileID: 7,
    accountFullname: 'Βασίλης Τζικούλης',
    accountEmail: 'vasilistzikoulis@gmail.com',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Patient Application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(child: HomePage(account: _account)),
        routes: <String, WidgetBuilder>{
          SelfAssessmentScreen.routeName: (context) =>
              SelfAssessmentScreen(account: _account),
        });
  }
}

class HomePage extends StatefulWidget {
  final StarsAccount account;

  HomePage({Key key, this.account}) : super(key: key);

  final List homePageViewData = [
    {
      'type': 'home_spacer',
      'height': 50.0,
    },
    {
      'type': 'home_menuitem',
      'name': 'Profiler',
      'count': '20',
      'icon': Icons.people,
      'iconColor': Colors.blue[700],
      'cardColor': Colors.blue[600],
    },
    {
      'type': 'home_menuitem',
      'name': 'Comunication',
      'count': '10',
      'icon': Icons.people,
      'iconColor': Colors.blue[700],
      'cardColor': Colors.blue[600],
    },
    {
      'type': 'home_menuitem',
      'name': 'Traking',
      'count': '8',
      'icon': Icons.people,
      'iconColor': Colors.blue[700],
      'cardColor': Colors.blue[600],
    },
    {
      'type': 'home_menuitem',
      'name': 'Self-assessment',
      'count': '8',
      'icon': Icons.people,
      'iconColor': Colors.blue[700],
      'cardColor': Colors.blue[600],
      'route': SelfAssessmentScreen.routeName
    },
    {
      'type': 'home_menuitem',
      'name': 'Caregiver',
      'count': '2',
      'icon': Icons.people,
      'iconColor': Colors.blue[700],
      'cardColor': Colors.blue[600],
    },
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _bottomNav(),
    );
  }

  // Widget _buildBodyForTests() => Container(
  //         decoration: BoxDecoration(
  //       color: const Color(0xff7c94b6),
  //       image: const DecorationImage(
  //         image: NetworkImage(
  //             'https:///flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
  //         fit: BoxFit.cover,
  //       ),
  //       border: Border.all(
  //         color: Colors.black,
  //         width: 1,
  //       ),
  //       borderRadius: BorderRadius.circular(12),
  //     ));

  Widget _buildBody() => Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: widget.homePageViewData.length,
                  itemBuilder: (context, index) {
                    return _buildCard(index);
                  }),
            ),
          ],
        ),
      );

  Widget _bottomNav() => BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.cached, size: 30),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.favorite, size: 30),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.location_on, size: 30),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.person, size: 30),
            title: SizedBox.shrink(),
          )
        ],
      );

  AppBar _buildAppBar() {
    final mainMenuBtn = IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        print('Drawer...');
        _scaffoldKey.currentState.openDrawer();
      },
    );
    final searchBtn = IconButton(
      icon: const Icon(Icons.search),
      tooltip: 'Search...',
      onPressed: () {
        print('Search...');
      },
    );
    final subMenuBtn = IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        print('Other menu...');
      },
    );

    final appBartitle = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 40),
        Text(
          "PATIENT",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    return AppBar(
      leading: mainMenuBtn,
      actions: <Widget>[searchBtn, subMenuBtn],
      title: appBartitle,
      elevation: 10,
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: const Color(0xff7c94b6),
                  //   image: const DecorationImage(
                  //     image: NetworkImage(
                  //         'https:///flutter.github.io/assets-for-api-docs/assets/widgets/owl-1.jpg'),
                  //     fit: BoxFit.cover,
                  //   ),
                  //   border: Border.all(
                  //     color: Colors.black,
                  //     width: 1,
                  //   ),
                  //   borderRadius: BorderRadius.circular(12),
                  // ),
                  accountName: Text(widget.account.accountFullname),
                  accountEmail: Text(widget.account.accountEmail),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Text(
                      "J",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  //leading: Icon(Icons.home),
                  title: Text("Profiler"),
                ),
                ListTile(
                  //leading: Icon(Icons.people),
                  title: Text("Communication"),
                  //trailing: _patientPopup(),
                ),
                ListTile(
                  //leading: Icon(Icons.comment),
                  title: Text("Tracking"),
                ),
                ListTile(
                    //leading: Icon(Icons.question_answer),
                    title: Text("Self-assesment"),
                    //trailing: _gotoScreen("Self-assesment"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, SelfAssessmentScreen.routeName);
                    }),
                ListTile(
                  //leading: Icon(Icons.question_answer),
                  title: Text("Caregiver"),
                ),
                SizedBox(height: 40.0),
                ListTile(
                  //leading: Icon(Icons.question_answer),
                  title: Text("Settings"),
                ),
              ],
            ),
          ), // This container holds the align
          // This container holds the align
          Container(
              // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView

                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(thickness: 2.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "   \u00a9 2019    ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: "STARS SYSTEM",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Text("   Vesion: 1.0.1"),
                    ],
                  ))))
        ],
      ),
    );
  }

  Widget _buildCard(index) {
    switch (widget.homePageViewData[index]['type']) {
      case 'home_spacer':
        return SizedBox(height: widget.homePageViewData[index]['height']);
      case 'home_menuitem':
        return Stack(children: <Widget>[
          Card(
            elevation: 15,
            margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                  color: widget.homePageViewData[index]['cardColor']),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        right: 12.0, left: 12.0, top: 10, bottom: 10.0),
                    decoration: BoxDecoration(
                      color: widget.homePageViewData[index]['iconColor'],
                      border: Border(
                        right: BorderSide(
                          width: 1.0,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                    child: Icon(
                      widget.homePageViewData[index]['icon'],
                      size: 56.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.homePageViewData[index]['name'],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  //   onTap: () {
                  //   print('pressed $index');
                  // }),
                  onTap: () => Navigator.pushNamed(
                      context, widget.homePageViewData[index]['route']),
                )),
          ),
        ]);
      default:
        return Text("Widget not Found!");
    }
  }
}
