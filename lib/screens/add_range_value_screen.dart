import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starspat/model/self_assessment_classes.dart';

class AddRangeValueScreen extends StatefulWidget {
  final RangeParams rangeType;
  final GlobalKey<_SliderWidgetState> _sliderWidgetKey = GlobalKey<_SliderWidgetState>();

  AddRangeValueScreen({key, @required this.rangeType}) : super(key: key);

  @override
  _AddRangeValueScreenState createState() => _AddRangeValueScreenState();
}

class _AddRangeValueScreenState extends State<AddRangeValueScreen> {
  double _currentValue;
  Widget _gauge;

  @override
  void initState() {
    super.initState();

    _currentValue = widget.rangeType.valueFrom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Text(widget.rangeType.name + ' assessment', style: TextStyle(fontSize: 22.0)),
            SizedBox(
              height: 80.0,
            ),
            _buildCustomSlider(),
            SizedBox(
              height: 150.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blueAccent,
                      child: MaterialButton(
                        //minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blueAccent,
                      child: MaterialButton(
                        //minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () => _showDialog(),
                        child: Text("Insert Value", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
          "Insert Value",
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

  Widget _buildCustomSlider() {
    return Center(
      child: SliderWidget(
        key: widget._sliderWidgetKey,
        min: widget.rangeType.valueFrom.toInt(),
        max: widget.rangeType.valueUntil.toInt(),
        sliderHeight: 50,
        fullWidth: false,
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Caution"),
          content: Text("You are about to insert value: " + widget._sliderWidgetKey.currentState.getValueInt().toString() + ". Are you sure?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Continue"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSlider() {
    return Center(
      //child: RotatedBox(
      //  quarterTurns: 1,
      child: SizedBox(
        width: 300.0,
        height: 65.0,
        child: Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.red,
                ],
              ),
              borderRadius: new BorderRadius.all(const Radius.circular(22.0)),
            ),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                //--------------- TRACK PROPERTIES
                //activeTrackColor: Colors.transparent,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                trackShape: RoundedRectSliderTrackShape(),
                //RectangularSliderTrackShape(),
                //RoundedRectSliderTrackShape(),
                trackHeight: 3.0,
                // Αν trackHeight <= 7.0, τα TickMarkers φαίνονται [για TickMarkers τύπου RoundSliderTickMarkShape()]
                // Αν trackHeight > 7.0, τα TickMarkers φαίνονται !!!
                // Στην περίπτωση αυτή να δοκιμάσουμε άλλου τύπου TickMarkers (π.χ. CustomTickMarkers)
                // Από μία μικρή έρευνα που έκανα μάλλον δεν υπάρχουν άλλοι Implementers της SliderTickMarkShape class
                // παρά μόνο η RoundSliderTickMarkShape.
                // Επομένως, αν θέλουμε κάτι διαφορερικό, πρέπει να το υλοποιήσουμε. Δηλαδή πρέπει να κάνουμε
                // custom TickMarker that implemets SliderTickMarkShape class.
                //--------------- TICKmARK PROPERTIES
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.red[700],
                inactiveTickMarkColor: Colors.red[100],
                //--------------- THUMB PROPERTIES
                thumbShape: CustomSliderThumbCircle(
                  thumbRadius: 22.0,
                  min: 0,
                  max: 100,
                ),
                //RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.redAccent,
                //--------------- OVERLAY PROPERTIES
                // must use an implementer of SliderComponentShape class
                overlayColor: Colors.red, //Colors.white.withOpacity(.4),
                //overlayShape: RoundSliderOverlayShape(overlayRadius: 38.0),
                overlayShape: SliderComponentShape.noOverlay,
                //--------------- VALUEiNDICATOR PROPERTIES
                //valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorShape: SliderComponentShape.noOverlay,
                valueIndicatorColor: Colors.redAccent,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.blue,
                ),
              ),
              child: Slider(
                min: widget.rangeType.valueFrom,
                max: widget.rangeType.valueUntil,
                divisions: (widget.rangeType.valueUntil - widget.rangeType.valueFrom) ~/ 10.0,
                value: _currentValue,
                label: _currentValue.toString(),
                onChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;

  SliderWidget({Key key, this.sliderHeight = 48, this.max = 10, this.min = 0, this.fullWidth = false}) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  int getValueInt() {
    return (_value * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth ? double.infinity : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF00c6ff),
              const Color(0xFF0072ff),
              // Colors.cyan,
              // Colors.red,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor, 2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${this.widget.min}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),

                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: this.widget.sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    overlayColor: Colors.white.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                  ),
                  child: Slider(
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Text(
              '${this.widget.max}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor,
      ),
      text: getValue(value),
    );

    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter = Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return ((max * value).round()).toString();
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final int min;
  final int max;

  const CustomSliderThumbRect({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: thumbHeight * 1.2, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    TextSpan span =
        new TextSpan(style: new TextStyle(fontSize: thumbHeight * .3, fontWeight: FontWeight.w700, color: sliderTheme.thumbColor, height: 0.9), text: '${getValue(value)}');
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter = Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return ((max) * (value)).round().toString();
  }
}
