import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:novindius/Models/patienModel.dart';
import 'package:novindius/Screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientListPage extends StatefulWidget {
  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  List<Patient> patients = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Future<void> fetchData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final response = await http.get(
  //       Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'),
  //       headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzkzNjEzMjM3LCJpYXQiOjE3MDcyMTMyMzcsImp0aSI6ImZjMDkzMjdiNDdjZDRkYWM4ZTk5MmMyYzcxNzI1MDE1IiwidXNlcl9pZCI6MjF9.bpYH7vDW0P-3SXaVQ6eGJOV8pXDtplCCNlMRx9B8peE"});
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     List<Patient> fetchedPatients = [];
  //     for (var patient in data) {
  //       fetchedPatients.add(Patient.fromJson(patient));
  //     }
  //     setState(() {
  //       patients = fetchedPatients;
  //       isLoading = false;
  //     });
  //   } else {
  //     throw Exception('Failed to load patients');
  //   }

  // }
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    String? token = await gettheToken();
    if (token == null) {
      // Handle the case when token is not available (user not logged in)
      // You may navigate the user to the login screen or handle it according to your app's flow
      return;
    }

    final response = await http.get(
      Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Patient> fetchedPatients = [];
      for (var patient in data) {
        fetchedPatients.add(Patient.fromJson(patient));
      }
      setState(() {
        patients = fetchedPatients;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load patients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search',
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(1, 106, 41, 0.98),
                          Color.fromRGBO(1, 106, 41, 0.98)
                        ],
                      ),
                    ),
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          // Implement search button logic here
                        },
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : patients.isEmpty
                      ? Center(
                          child: Text('Empty list image'),
                        )
                      : ListView.builder(
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            final patient = patients[index];
                            return ListTile(
                              title: Text(patient.name),
                              subtitle: Text(
                                  'ID: ${patient.id}, Name: ${patient.name}'),
                            );
                          },
                        ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(1, 106, 41, 0.98),
                    Color.fromRGBO(1, 106, 41, 0.98)
                  ],
                ),
              ),
              margin: EdgeInsets.all(10),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationForm()));
                  },
                  child: Text(
                    'Register Now',
                    style: TextStyle(color: Color.fromARGB(255, 243, 240, 240)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> gettheToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}
