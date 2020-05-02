import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:starspat/model/bar_chart_data.dart';

class HorizontalBarLabelCustomChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarLabelCustomChart(this.seriesList, {this.animate});

  factory HorizontalBarLabelCustomChart.withData(List<BarChartData> data,
      {animate}) {
    return new HorizontalBarLabelCustomChart(
      _createData(data),
      animate: animate,
    );
  }
  // The [BarLabelDecorator] has settings to set the text style for all labels
  // for inside the bar and outside the bar. To be able to control each datum's
  // style, set the style accessor functions on the series.
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

  static List<charts.Series<BarChartData, String>> _createData(
      List<BarChartData> data) {
    return [
      new charts.Series<BarChartData, String>(
        id: 'RangeParamChart',
        domainFn: (BarChartData rv, _) => rv.datetime,
        measureFn: (BarChartData rv, _) => rv.value,
        data: data,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (BarChartData rv, lbl) =>
            '${rv.datetime} | ${rv.value.toString()}',
        insideLabelStyleAccessorFn: (BarChartData rv, _) {
          final color = (rv.value > 50)
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.white;
          return new charts.TextStyleSpec(color: color);
        },
        outsideLabelStyleAccessorFn: (BarChartData rv, _) {
          final color = (rv.value < 50)
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.white;
          return new charts.TextStyleSpec(color: color);
        },
      )
    ];
  }
}
