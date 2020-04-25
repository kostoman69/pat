import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:starspat/model/bar_chart_data.dart';
import 'package:starspat/model/self_assessment_classes.dart';
import 'package:starspat/screens/horizontal_bar_label_custom.dart';
import 'dart:math';

import 'package:starspat/screens/simple_barchart.dart';
import 'package:starspat/screens/simple_scatter_plot.dart';

import 'initial_hint_animation.dart';

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class ChartScreen extends StatefulWidget {
  static String routeName = '/chart';
  final RangeParams rangeType;
  final List<BarChartData> rangeValues = null;
  final List<RangeValue> rangeValues1;

  ChartScreen({key, @required this.rangeType, @required this.rangeValues1})
      : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  Widget chartContainer = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text('Chart Viewer')],
  );
  List<BarChartData> fakeData;
  int chartBarSelector;
  String chartType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fakeData = [
      new BarChartData('2014 13:22', 5),
      new BarChartData('2015 13:22', 25),
      new BarChartData('2016 13:22', 100),
      new BarChartData('2017 13:22', 75),
    ];
  }

  @override
  void initState() {
    super.initState();
    chartBarSelector = 1;
    chartType = "SimpleBarChart";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Charts in Flutter'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: chartContainer,
              ),
              SizedBox(
                height: 100.0,
              ),
              Text(chartType),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Chart switching'),
                    onPressed: () {
                      setState(() {
                        switch (chartBarSelector) {
                          case 1:
                            chartContainer =
                                SimpleBarChart2.withSampleData(animate: true);
                            chartBarSelector = 2;
                            chartType = "SimpleBarChart";
                            break;
                          case 2:
                            chartContainer =
                                HorizontalBarLabelCustomChart.withRandomData();
                            chartBarSelector = 3;
                            chartType = "HorizontalBarLabelCustomChart";
                            break;
                          case 3:
                            chartContainer =
                                SimpleScatterPlotChart.withRandomData();
                            chartBarSelector = 4;
                            chartType = "SimpleScatterPlotChart";
                            break;
                          case 4:
                            chartContainer = InitialHintAnimation2.withRealData(
                              data: widget.rangeValues,
                              animate: true,
                            );
                            chartBarSelector = 1;
                            chartType = "InitialHintAnimation";
                            break;
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // SingleChildScrollView(
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               height: 150,
  //               //child: _buildBarChart(),
  //               child: HorizontalBarLabelCustomChart.withSampleData(),
  //             ),
  //           ],
  //         ),
  //       ),

  Widget _buildBarChart() {
    return new charts.BarChart(
      _createData(),
      animate: false,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  List<charts.Series<BarChartData, String>> _createData() {
    widget.rangeValues
        .forEach((v) => print(v.value.toString() + ' at ' + v.datetime));
    return [
      new charts.Series<BarChartData, String>(
        id: 'RangeParamChart',
        domainFn: (BarChartData rv, _) => rv.datetime,
        measureFn: (BarChartData rv, _) => rv.value,
        //data: widget.rangeValues,
        data: fakeData,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (BarChartData rv, _) {
          var datetime = DateTime.parse(rv.datetime);
          var formatter = new DateFormat('dd-MM-yyyy HH:mm');

          return '${formatter.format(datetime)} | ${rv.value.toString()}';
        },
        insideLabelStyleAccessorFn: (BarChartData rv, _) {
          final color = (rv.value > 50)
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.white;
          return new charts.TextStyleSpec(color: color);
        },
        outsideLabelStyleAccessorFn: (BarChartData rv, _) {
          final color = (rv.value > 50)
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.white;
          return new charts.TextStyleSpec(color: color);
        },
      )
    ];
  }
}
