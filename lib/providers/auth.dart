import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authtimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) return _token;

    return null;
  }

  String get userId {
    return _userId;
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userdata')) {
      print("not found");
      return false;
    }

    final extractedUser =
        jsonDecode(prefs.getString('userdata')) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUser['expiryDate']);
    print("data");

    if (expiryDate.isBefore(DateTime.now())) {
      print("here");
      return false;
    }
    print(_token);
    _token = extractedUser['token'];
    _userId = extractedUser['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAObEesV-UwUrAkgSpIb87awoSK8x8HqmI');
    final response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw HttpException(body['error']['message']);
    }
    print(jsonDecode(response.body));
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAObEesV-UwUrAkgSpIb87awoSK8x8HqmI');
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final body = jsonDecode(response.body);
      if (body['error'] != null) {
        throw HttpException(body['error']['message']);
      }
      _token = body['idToken'];
      _userId = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      _autoLogout();
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('userdata', userData);
      print(prefs.getString('userdata'));
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authtimer != null) {
      _authtimer.cancel();
      _authtimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authtimer != null) {
      _authtimer.cancel();
    }
    final timeExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authtimer = Timer(Duration(seconds: timeExpiry), logout);
  }
}
