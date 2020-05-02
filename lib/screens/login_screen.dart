import 'package:flutter/material.dart';
import 'package:starspat/global.dart';
import 'package:starspat/model/stars_account.dart';
import 'package:starspat/networking/starsclient.dart';

class LoginScreen extends StatefulWidget {
  final StarsAccount _debugAccount = StarsAccount(
    recordID: 15,
    accountID: 33,
    profileID: 7,
    accountFullname: 'Βασίλης Τζικούλης',
    accountEmail: 'vasilistzikoulis@gmail.com',
  );

  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _waitWidgetPlaceHolder = SizedBox(child: Text('   '));

  final TextStyle _style = TextStyle(fontSize: 20.0);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = new GlobalKey<ScaffoldState>();

  bool _passwordVisible;
  Widget _waitWidget = _waitWidgetPlaceHolder;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _usernameField = TextField(
      obscureText: false,
      controller: _usernameController,
      style: _style,
      decoration:
          InputDecoration(contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0), hintText: "Username", border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final _passwordField = TextField(
      obscureText: !_passwordVisible,
      toolbarOptions: ToolbarOptions(
        cut: false,
        copy: false,
        selectAll: false,
        paste: false,
      ),
      controller: _passwordController,
      style: _style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hasFloatingPlaceholder: true,
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        suffixIcon: GestureDetector(
          onLongPress: () {
            setState(() {
              _passwordVisible = true;
            });
          },
          onLongPressUp: () {
            setState(() {
              _passwordVisible = false;
            });
          },
          child: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );

    final _loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          setState(() {
            _waitWidget = Column(
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
            );
          });
          STARSRestfulClient.apiAccounts(_usernameController.text, _passwordController.text).then((sa) {
            setState(() {
              _waitWidget = _waitWidgetPlaceHolder;
            });
            if (sa.valid) {
              Navigator.pushNamed(context, dashboardScreenRoute, arguments: widget._debugAccount);
            } else {
              _key.currentState.showSnackBar(new SnackBar(
                content: new Text(sa.errDescription),
              ));
            }
          });
        },
        child: Text("Login", textAlign: TextAlign.center, style: _style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
//SingleChildScrollView
    return Scaffold(
        key: _key,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    _usernameField,
                    SizedBox(height: 25.0),
                    _passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    _loginButon,
                    SizedBox(
                      height: 30.0,
                    ),
                    _waitWidget,
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
