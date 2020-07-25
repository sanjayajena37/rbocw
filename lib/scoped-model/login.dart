import 'package:rbocw/providers/api_factory.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginModel extends Model {
  bool _isLoginLoading = false;
  Map<String, dynamic> _loginResponse = {};

  Future<Map<String, dynamic>> getLoginResponse(
      Map<String, dynamic> loginBody) async {
    _isLoginLoading = true;
    notifyListeners();
    print(loginBody);
    String loginApi = ApiFactory.loginApi;
    // await http.get('http://api.open-notify.org/astros')
    //     .then((http.Response response) {
    //   _loginResponse = json.decode(response.body);
    //   _isLoginLoading = false;
    //   notifyListeners();
    // });
    // return _loginResponse;
    await Future.delayed(const Duration(seconds: 2), () {
      print("callllllllllllllllllllllllll");
      _isLoginLoading = false;
      notifyListeners();
      _loginResponse = {"message": "Login Sucess"};
    });
    return _loginResponse;
  }

  bool get isLoginLoading {
    return _isLoginLoading;
  }
}
