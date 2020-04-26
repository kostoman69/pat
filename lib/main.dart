import 'package:flutter/material.dart';
import 'package:starspat/global.dart';
import 'package:starspat/screens/chart_screen.dart';
import 'package:starspat/screens/login_screen.dart';
import 'package:starspat/router.dart' as router;

void main() {
  runApp(StarsPatApp());
}

class StarsPatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STARS PatApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: LoginScreen()),
      onGenerateRoute: router.generateRoute,
      routes: <String, WidgetBuilder>{
        //   SelfAssessmentScreen.routeName: (context) =>
        //       SelfAssessmentScreen(account: _debugAccount),
        chartScreenRoute: (context) => ChartScreen(),
      },
    );
  }
}
