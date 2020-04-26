import 'package:flutter/material.dart';
import 'package:starspat/global.dart';
import 'package:starspat/screens/add_range_value_screen.dart';
import 'package:starspat/screens/chart_screen.dart';
import 'package:starspat/screens/dashboard_screen.dart';
import 'package:starspat/screens/self_assessment_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardScreenRoute:
      var arg = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => DashboardScreen(account: arg));
    case selfAssessmentScreenRoute:
      var arg = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => SelfAssessmentScreen(account: arg));
    case addRangeValueScreenRoute:
      var arg = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddRangeValueScreen(rangeType: arg));
    // case chartScreenRoute:
    //   var arg = settings.arguments;
    //   return MaterialPageRoute(
    //       builder: (context) => ChartScreen(rangeData: arg));
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
/*---------------------------------------------------------------------------------------
| Έτσι θα καλούμε ένα route:
|
| Navigator.pushNamed(context, LoginViewRoute, arguments: 'Data Passed in');
-----------------------------------------------------------------------------------------*/

class UndefinedView extends StatelessWidget {
  final String name;
  const UndefinedView({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}
