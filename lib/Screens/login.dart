import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:novindius/Screens/patientlist.dart';
import 'package:novindius/Screens/sign.dart';
import 'package:novindius/webservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LOGIN extends StatefulWidget {
  const LOGIN({super.key});

  @override
  State<LOGIN> createState() => _LOGINState();
}

class _LOGINState extends State<LOGIN> {
  final usernameController = TextEditingController();
  final passworController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print("isLoggedIn =" + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => PatientListScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(foregroundColor: Colors.redAccent),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'images/second.png',
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(30)),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 245, 243),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Login Or Register To Book\n Your Appointments',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Enter Your Email",
                                    labelText: "Username",
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: passworController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Your Password",
                                      labelText: "Password",
                                      prefixIcon: Icon(Icons.password)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the text";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, 6)
                          ],
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              print('username =' +
                                  usernameController.text.toString());
                              print('Password =' +
                                  passworController.text.toString());
                              login(usernameController.text.toString(),
                                  passworController.text.toString());
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "By creating or logging into an account you are agreeing with our Terms and Conditions and Privacy Policy.")
                        ])
                  ]),
            ),
          ),
        ));
  }

  login(String username, String password) async {
    try {
      print("Webservice");
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> logindata = {
        "username": username,
        "password": password,
      };
      final response = await http.post(
        Uri.parse('https://flutter-amr.noviindus.in/api/Login'),
        body: logindata,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("username", username);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PatientListScreen();
          }));
        } else {
          print("login Failed");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            padding: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text(
              "Login Failed",
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w200, color: Colors.red),
            ),
          ));
        }
      } else {
        result = {print(json.decode(response.body)['error'].toString())};
      }

      return result;
    } catch (e) {
      print(e.toString());
    }
  }
}
