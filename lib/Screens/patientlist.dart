import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<dynamic> patients = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('http://flutter-amr.noviindus.in/api/PatientList'),
    );
    if (response.statusCode == 200) {
      setState(() {
        patients = json.decode(response.body);
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Failed to load patients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ,
              ),
              onChanged: (value) {
                // Implement your search functionality here
                // You can filter the patients list based on the search query
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : patients.isEmpty
                    ? Center(child: Text('Empty List Image'))
                    : RefreshIndicator(
                        onRefresh: fetchPatients,
                        child: ListView.builder(
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            final patient = patients[index];
                            return ListTile(
                              title: Text(patient['name']),
                              subtitle: Text(patient['condition']),
                              // Add more patient details here
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
