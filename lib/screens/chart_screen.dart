import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:starspat/model/bar_chart_data.dart';
import 'package:starspat/model/self_assessment_classes.dart';
import 'dart:math';

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class ChartScreen extends StatefulWidget {
  static String routeName = '/chart';
  final RangeParams rangeType;
  final List<BarChartData> rangeValues;

  ChartScreen({key, @required this.rangeType, @required this.rangeValues})
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fakeData = [
      new BarChartData('2014', 5),
      new BarChartData('2015', 25),
      new BarChartData('2016', 100),
      new BarChartData('2017', 75),
    ];
  }

  @override
  void initState() {
    super.initState();
    chartBarSelector = 1;
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
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Charts'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Simple'),
                    onPressed: () {
                      chartBarSelector = chartBarSelector + 1;
                      if (chartBarSelector == 4) {
                        chartBarSelector = 0;
                      }
                      setState(() {
                        switch (chartBarSelector) {
                          case 1:
                            chartContainer =
                                SimpleBarChart.withSampleData(animate: true);
                            break;
                          case 2:
                            chartContainer =
                                HorizontalBarLabelCustomChart.withRandomData(
                                    animate: true);
                            break;
                          case 3:
                            chartContainer =
                                SimpleScatterPlotChart.withRandomData();
                            break;
                          default:
                            chartContainer =
                                SimpleBarChart.withSampleData(animate: true);
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

/*
  switch(chartBarSelector) { 
                        case 1: { 
                            chartContainer =
                                                SimpleBarChart.withSampleData(animate: true); 
                        } 
                        break; 
                        case 2: { 
                            chartContainer =
                                                HorizontalBarLabelCustomChart.withRandomData(animate: true); 
                        } 
                        break; 
                        case 3: {
                            chartContainer =
                                                  SimpleScatterPlotChart.withRandomData(); 
                        } 
                        break; 
                        default: { 
                            chartContainer =
                                                SimpleBarChart.withSampleData(animate: true);   
                        }
                        break; 
                      }
  */

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

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData({animate}) {
    return new SimpleBarChart(
      _createSampleData(),
      animate: animate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<BarChartData, String>> _createSampleData() {
    final data = [
      new BarChartData('2014', 5),
      new BarChartData('2015', 25),
      new BarChartData('2016', 100),
      new BarChartData('2017', 75),
    ];

    return [
      new charts.Series<BarChartData, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (BarChartData v, _) => v.datetime,
        measureFn: (BarChartData v, _) => v.value,
        data: data,
      )
    ];
  }
}

class HorizontalBarLabelCustomChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarLabelCustomChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarLabelCustomChart.withSampleData({animate}) {
    return HorizontalBarLabelCustomChart(
      _createSampleData(),
      animate: animate,
    );
  }

  factory HorizontalBarLabelCustomChart.withRandomData({animate}) {
    return HorizontalBarLabelCustomChart(
      _createRandomData(),
      animate: animate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<BarChartData, String>> _createSampleData() {
    final data = [
      new BarChartData('2014', 5),
      new BarChartData('2015', 25),
      new BarChartData('2016', 100),
      new BarChartData('2017', 75),
    ];

    return [
      new charts.Series<BarChartData, String>(
        id: 'RangeParamChart',
        domainFn: (BarChartData rv, _) => rv.datetime,
        measureFn: (BarChartData rv, _) => rv.value,
        //data: widget.rangeValues,
        data: data,
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

  /// Create one series with sample hard coded data.
  static List<charts.Series<BarChartData, String>> _createRandomData() {
    final random = new Random();

    final data = [
      new BarChartData('2014', random.nextInt(100).toDouble()),
      new BarChartData('2015', random.nextInt(100).toDouble()),
      new BarChartData('2016', random.nextInt(100).toDouble()),
      new BarChartData('2017', random.nextInt(100).toDouble()),
    ];

    return [
      new charts.Series<BarChartData, String>(
        id: 'RangeParamChart',
        domainFn: (BarChartData rv, _) => rv.datetime,
        measureFn: (BarChartData rv, _) => rv.value,
        //data: widget.rangeValues,
        data: data,
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

class SimpleScatterPlotChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleScatterPlotChart(this.seriesList, {this.animate});

  /// Creates a [ScatterPlotChart] with sample data and no transition.
  factory SimpleScatterPlotChart.withSampleData() {
    return new SimpleScatterPlotChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  factory SimpleScatterPlotChart.withRandomData() {
    return new SimpleScatterPlotChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final makeRadius = (int value) => (random.nextInt(value) + 2).toDouble();

    final data = [
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6)),
    ];

    final maxMeasure = 100;

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (LinearSales sales, _) {
          // Color bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        radiusPxFn: (LinearSales sales, _) => sales.radius,
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.ScatterPlotChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5, 3.0),
      new LinearSales(10, 25, 5.0),
      new LinearSales(12, 75, 4.0),
      new LinearSales(13, 225, 5.0),
      new LinearSales(16, 50, 4.0),
      new LinearSales(24, 75, 3.0),
      new LinearSales(25, 100, 3.0),
      new LinearSales(34, 150, 5.0),
      new LinearSales(37, 10, 4.5),
      new LinearSales(45, 300, 8.0),
      new LinearSales(52, 15, 4.0),
      new LinearSales(56, 200, 7.0),
    ];

    final maxMeasure = 300;

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        // Providing a color function is optional.
        colorFn: (LinearSales sales, _) {
          // Bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        // Providing a radius function is optional.
        radiusPxFn: (LinearSales sales, _) => sales.radius,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final double radius;

  LinearSales(this.year, this.sales, this.radius);
}
