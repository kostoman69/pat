import 'package:flutter/material.dart';
import 'package:starspat/cst_chart_horizontal_bar_label_custom.dart';
import 'package:starspat/cst_chart_initial_hint_animation.dart';
import 'package:starspat/cst_chart_simple_scatter_plot.dart';
import 'package:starspat/model/bar_chart_data.dart';

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  Widget chartContainer = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text('Chart Viewer')],
  );
  double chartHeight = 250.0;
  int chartBarSelector;
  bool firstTime;
  final chartTypes = ["HorizontalBarLabelCustomChart", "InitialHintAnimation", "SimpleScatterPlotChart"];
  List<BarChartData> fakeData;
  Map _args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fakeData = [
      new BarChartData('2014-01-27 13:22:00', 65),
      new BarChartData('2015-01-27 13:22:00', 65),
      new BarChartData('2016-01-27 13:22:00', 100),
      new BarChartData('2017-01-27 13:22:00', 75),
      new BarChartData('2018-01-27 13:22:00', 85),
      new BarChartData('2019-01-27 13:22:00', 65),
      new BarChartData('2020-01-27 13:22:00', 55),
      new BarChartData('2021-01-27 13:22:00', 35),
      new BarChartData('2022-01-27 13:22:00', 15),
      new BarChartData('2023-01-27 13:22:00', 0),
      new BarChartData('2024-01-27 13:22:00', 125),
      new BarChartData('2025-01-27 13:22:00', 130),
      new BarChartData('2013-01-27 13:22:00', 75),
      new BarChartData('2012-01-27 13:22:00', 85),
      new BarChartData('2011-01-27 13:22:00', 65),
      new BarChartData('2010-01-27 13:22:00', 55),
      new BarChartData('2026-01-27 13:22:00', 35),
      new BarChartData('2027-01-27 13:22:00', 15),
      new BarChartData('2028-01-27 13:22:00', 0),
      new BarChartData('2029-01-27 13:22:00', 125),
      new BarChartData('2030-01-27 13:22:00', 130),
    ];
    //
    // didChangeDependencies() is called just few moments after the state loads its dependencies and
    // context is available at this moment, so here you can use context.
    // _args = ModalRoute.of(context).settings.arguments as Map;
    // if (_args == null) {
    //   /*--------
    //    ΠΡΟΒΛΗΜΑ: Κανονικά δε θα πρέπει να συμβεί ΠΟΤΕ!
    //    Αυτός που καλεί το ChartScreen το καλεί ως:
    //     args = {
    //             'type': RangeParams,
    //             'value': List<BarChartData>
    //            }
    //    οπότε πάντα θα έχει τιμή. Να δω κάποια στιγμή το error handling
    //   π.χ. δεν υπάρχουν data!
    //   ---------------*/
    //   print('FATAL!!!');
    // }
    // chartContainer = HorizontalBarLabelCustomChart.withData(
    //   _args['value'],
    //   animate: true,
    // );
    // chartBarSelector = 0;
  }

  @override
  void initState() {
    super.initState();
    firstTime = true;

    // Future.delayed(Duration.zero, () {
    //   _args = ModalRoute.of(context).settings.arguments as Map;
    //   if (_args == null) {
    //     /*--------
    //    ΠΡΟΒΛΗΜΑ: Κανονικά δε θα πρέπει να συμβεί ΠΟΤΕ!
    //    Αυτός που καλεί το ChartScreen το καλεί ως:
    //     args = {
    //             'type': RangeParams,
    //             'value': List<BarChartData>
    //            }
    //    οπότε πάντα θα έχει τιμή. Να δω κάποια στιγμή το error handling
    //   π.χ. δεν υπάρχουν data!
    //   ---------------*/
    //     print('FATAL from initState!!!');
    //   }
    //   print('ok from initState!!!');
    //   chartContainer = HorizontalBarLabelCustomChart.withData(
    //     _args['value'],
    //     animate: true,
    //   );
    //   chartBarSelector = 0;
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      _args = ModalRoute.of(context).settings.arguments as Map;
      if (_args == null) {
        /*--------
       ΠΡΟΒΛΗΜΑ: Κανονικά δε θα πρέπει να συμβεί ΠΟΤΕ!
       Αυτός που καλεί το ChartScreen το καλεί ως:
        args = {
                'type': RangeParams,
                'value': List<BarChartData>
               }
       οπότε πάντα θα έχει τιμή. Να δω κάποια στιγμή το error handling
      π.χ. δεν υπάρχουν data!
      ---------------*/
        print('FATAL FROM build!!!');
      }
      print('ok FROM build!!!');
      chartContainer = HorizontalBarLabelCustomChart.withData(
        _args['value'],
        animate: true,
      );
      chartBarSelector = 0;
      firstTime = false;
    }
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildChartBoby(context),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Opacity(
            opacity: chartBarSelector == 0 ? 0.7 : 0.0,
            child: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                setState(() => chartHeight = chartHeight + 50);
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.green,
              child: const Icon(Icons.plus_one, size: 36.0),
            ),
          ),
          Opacity(
            opacity: chartBarSelector == 0 ? 0.7 : 0.0,
            child: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                setState(() => chartHeight = chartHeight >= 300 ? chartHeight - 50 : chartHeight);
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.green,
              child: const Icon(Icons.mic, size: 36.0),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Opacity(
            opacity: 0.7,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                setState(() {
                  chartBarSelector++;
                  if (chartBarSelector == 3) {
                    chartBarSelector = 0;
                  }
                  switch (chartBarSelector) {
                    case 0:
                      chartContainer = HorizontalBarLabelCustomChart.withData(_args['value'], animate: true);
                      break;
                    case 1:
                      chartContainer = chartContainer = InitialHintAnimation.withData(
                        _args['value'],
                        animate: true,
                      );
                      break;
                    case 2:
                      chartContainer = SimpleScatterPlotChart.withRandomData();
                      break;
                  }
                });
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_location, size: 36.0),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final mainMenuBtn = IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    final appBartitle = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Chart",
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

  Widget _buildChartBoby(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: chartBarSelector == 0 ? chartHeight : 250,
            child: chartContainer,
          ),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
