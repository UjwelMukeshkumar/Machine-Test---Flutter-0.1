import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService extends GetxController {
  ApiService(String string, String string2);

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      var result;
      final Map<String, dynamic> loginData = {
        "username": username,
        "password": password,
      };
      final response = await http.post(
        Uri.parse('https://flutter-amr.noviindus.in/api/Login'),
        body: loginData,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          result = {"success": true};
        } else {
          print("login Failed");
          result = {"success": false, "message": "Login failed"};
        }
      } else {
        result = {
          "success": false,
          "message": json.decode(response.body)['error'].toString()
        };
      }

      return result;
    } catch (e) {
      print(e.toString());
      return {"success": false, "message": "An error occurred"};
    }
  }
  
  
}
