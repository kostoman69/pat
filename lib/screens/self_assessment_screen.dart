import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starspat/screens/chart_screen.dart';
import 'package:starspat/model/bar_chart_data.dart';
import 'package:starspat/model/self_assessment_classes.dart';
import 'package:starspat/model/stars_account.dart';
import 'package:starspat/networking/starsclient.dart';
import 'package:starspat/screens/add_range_value_screen.dart';
import 'package:starspat/global.dart';

class SelfAssessmentScreen extends StatefulWidget {
  final StarsAccount account;

  SelfAssessmentScreen({key, @required this.account}) : super(key: key);

  @override
  _SelfAssessmentScreenState createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   STARSRestfulClient.apiRangeParamValues(widget.account.profileID)
  //       .then((rangeParamValues) {
  //     print(rangeParamValues.rangeParamValue.length);
  //   }).catchError((err) {
  //     print(err);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildSelfAssesmentBoby(),
    );
  }

  AppBar _buildAppBar() {
    final mainMenuBtn = IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    final appBartitle = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //SizedBox(width: 1),
        Text(
          "Self Assesement",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    return AppBar(
      leading: mainMenuBtn,
      title: appBartitle,
      elevation: 10,
    );
  }

  _retRVs(int valueTypeID, List<RangeValue> mixedData) {
    //final List<BarChartData> data = snapshot.data.rangeValue
    final List<RangeValue> data =
        mixedData.where((v) => (v.rangeparamId == valueTypeID)).toList();

    //final List<double> data1 = data.map((v) => v.value);
    //data.map((v) => BarChartData(v.insertedAt, v.value));
    return data;
  }

  // .map((v) {
  //     var datetime = DateTime.parse(v.insertedAt);
  //     var formatter = new DateFormat('dd-MM-yyyy HH:mm');
  //     return BarChartData(formatter.format(datetime), v.value);
  //   })

  Widget _buildSelfAssesmentBoby() {
    return FutureBuilder<RangeValueList>(
      future: STARSRestfulClient.apiRangeParamValues(widget.account.profileID),
      builder: (BuildContext context, AsyncSnapshot<RangeValueList> snapshot) {
        Widget child;

        if (snapshot.hasData) {
          // να πάρουμε από το snapshot.hasData μία λίστα με τον τύπου των παραμέτρων (π.χ. pain, stress)
          // [
          //   {id:1, name:Pain, valueFrom:1, step:5, valueUntil:100},
          //   {id:2, name:Stress, valueFrom:1, step:5, valueUntil:100},
          // ]
          child = Container(
            margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.rangeTypes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.view_headline,
                                //color: Colors.green,
                                size: 60,
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: Text(
                                  snapshot.data.rangeTypes[index].name,
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                              Stack(children: [
                                Icon(
                                  Icons.playlist_add,
                                  color: Colors.blue,
                                  size: 60,
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        onTap: () => Navigator.pushNamed(
                                            context, addRangeValueScreenRoute,
                                            arguments: snapshot
                                                .data.rangeTypes[index])),
                                  ),
                                ),
                              ]),
                              Stack(children: [
                                Icon(
                                  Icons.show_chart,
                                  color: Colors.blue,
                                  size: 60,
                                ),
                                Positioned.fill(
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        onTap: () => Navigator.pushNamed(
                                            context, chartScreenRoute,
                                            arguments: <String, dynamic>{
                                              'type': snapshot
                                                  .data.rangeTypes[index],
                                              'value': snapshot.data.rangeValue
                                                  .where((v) =>
                                                      v.rangeparamId ==
                                                      snapshot.data
                                                          .rangeTypes[index].id)
                                                  .map((v) {
                                                var datetime = DateTime.parse(
                                                    v.insertedAt);
                                                var formatter = new DateFormat(
                                                    'dd-MM-yyyy HH:mm');
                                                BarChartData(
                                                    formatter.format(datetime),
                                                    v.value);
                                              }).toList()
                                            }),
                                      )),
                                ),
                              ]),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            ),
          );
        } else {
          child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            ),
          );
        }
        return child;
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: children,
        //   ),
        // );
      },
    );
  }

  // {
  //                                         Route route = MaterialPageRoute(
  //                                             builder: (context) => ChartScreen(
  //                                                 rangeType: snapshot
  //                                                     .data.rangeTypes[index],
  //                                                 rangeValues1: snapshot
  //                                                     .data.rangeValue));
  //                                         Navigator.push(context, route);
  //                                       }

}
