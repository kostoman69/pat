import 'package:flutter/material.dart';
import 'package:starspat/screens/chart_screen.dart';
import 'package:starspat/model/bar_chart_data.dart';
import 'package:starspat/model/self_assessment_classes.dart';
import 'package:starspat/model/stars_account.dart';
import 'package:starspat/networking/starsclient.dart';

class SelfAssessmentScreen extends StatefulWidget {
  static String routeName = '/selfAssesment';
  final StarsAccount account;

  SelfAssessmentScreen({key, @required this.account}) : super(key: key);

  @override
  _SelfAssessmentScreenState createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen> {
  double _value = 6;

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
      body: _buildSelfAssesmentHome(),
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
          "SELF ASSESEMENT",
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

  Widget _buildSelfAssesmentHome() {
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
                                            context, ChartScreen.routeName),
                                      )),
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
                                        onTap: () {
                                          Route route = MaterialPageRoute(
                                              builder: (context) => ChartScreen(
                                                    rangeType: snapshot
                                                        .data.rangeTypes[index],
                                                    rangeValues: snapshot
                                                        .data.rangeValue
                                                        .map((v) =>
                                                            BarChartData(
                                                                v.insertedAt,
                                                                v.value))
                                                        .toList(),
                                                  ));
                                          Navigator.push(context, route);
                                        },
                                      )),
                                ),
                              ]),
                            ],
                          ),
                        );
                      }),
                ),
                _buildSlider()
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

  Widget _buildSlider() {
    return Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: SizedBox(
          width: 300.0,
          height: 50.0,
          child: Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.red, Colors.cyan],
                ),
                borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
              ),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  thumbColor: Colors.redAccent,
                  overlayColor: Colors.white,
                  //Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  activeTickMarkColor: Colors.red[700],
                  inactiveTickMarkColor: Colors.red[100],
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Colors.redAccent,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                  min: 0,
                  max: 100,
                  divisions: 10,
                  value: _value,
                  label: _value.toString(),
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
