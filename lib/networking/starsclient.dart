import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:starspat/model/doctorprofile.dart';
import 'package:starspat/model/self_assessment_classes.dart';

class STARSRestfulClient {
  static String _baseUrl = "https://stars.forthehealth.gr/STARSAPI/";
  static bool _error = false;
  static String _errorDesc;

  static Future<String> apiAccounts(
      String username, String password, DoctorProfile dp) async {
    var response;
    String url;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('apiuser:apipass'));

    url = _baseUrl +
        'api/accounts?' +
        'username=' +
        username +
        '&password=' +
        password;
    print(url);
    Map<String, String> _headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };
    try {
      response = await http.get(Uri.encodeFull(url), headers: _headers);

      switch (response.statusCode) {
        case 200:
          _errorDesc = null;
          _error = false;
          break;
        case 400:
          _error = true;
          _errorDesc = 'BadRequest:  ${response.statusCode}';
          break;
        case 401:
        case 403:
          _error = true;
          _errorDesc = 'Unauthorised: ${response.statusCode}';
          break;
        case 500:
        default:
          _error = true;
          _errorDesc =
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}';
          break;
      }
    } on SocketException {
      _error = true;
      _errorDesc = 'No Internet connection';
    }

    if (_error) {
      dp.profile['error'] = true;
      dp.profile['error_description'] = _errorDesc;
    } else {
      dp.profile = jsonDecode(response.body);

      dp.profile['error'] = false;
    }
    return _errorDesc;
  }

  static Future<RangeValueList> apiRangeParamValues(int profileID) async {
    var response;
    String url;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('apiuser:apipass'));

    url = _baseUrl + 'api/RangeParamValues/' + profileID.toString();
    print(url);
    Map<String, String> _headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };
    try {
      response = await http.get(Uri.encodeFull(url), headers: _headers);

      switch (response.statusCode) {
        case 200:
          if (response.body.contains('401 Unauthorized')) {
            _errorDesc = '401 Unauthorized';
            _error = true;
          } else {
            _errorDesc = null;
            _error = false;
          }
          break;
        case 400:
          _error = true;
          _errorDesc = 'BadRequest:  ${response.statusCode}';
          break;
        case 401:
        case 403:
          _error = true;
          _errorDesc = 'Unauthorised: ${response.statusCode}';
          break;
        case 500:
        default:
          _error = true;
          _errorDesc =
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}';
          break;
      }
    } on SocketException {
      _error = true;
      _errorDesc = 'No Internet connection';
    }

    if (_error) {
      throw (_errorDesc);
    } else {
      print(response.body);
      //var rangeParams = jsonDecode(response.body);
      Map<String, dynamic> rangeParamValues =
          jsonDecode('{"RangeValue": ' + response.body + '}');
      return RangeValueList.fromJson(rangeParamValues);
    }
  }
}
