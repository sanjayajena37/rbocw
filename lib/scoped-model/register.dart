import 'package:rbocw/providers/api_factory.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterModel extends Model {
  bool _isRegisterLoading = false;
  Map<String, dynamic> _registerResponse = {};

  Future<Map<String, dynamic>> getRegisterResponse(
      Map<String, dynamic> loginBody) async {
    _isRegisterLoading = true;
    notifyListeners();
    print(loginBody);
    String signAPI = ApiFactory.loginApi;
    // await http.get('http://api.open-notify.org/astros')
    //     .then((http.Response response) {
    //   _loginResponse = json.decode(response.body);
    //   _isLoginLoading = false;
    //   notifyListeners();
    // });
    // return _loginResponse;
    await Future.delayed(const Duration(seconds: 2), () {
      _isRegisterLoading = false;
      notifyListeners();
      _registerResponse = {"message": "Login Sucess"};
    });
    return _registerResponse;
  }

  bool get isRegisterLoading {
    return _isRegisterLoading;
  }
}
