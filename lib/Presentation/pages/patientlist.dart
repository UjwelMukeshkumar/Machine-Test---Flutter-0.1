// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:novindius/Entities/patienModel.dart';
// import 'package:novindius/Presentation/pages/register.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class PatientListPage extends StatefulWidget {
//   @override
//   _PatientListPageState createState() => _PatientListPageState();
// }

// class _PatientListPageState extends State<PatientListPage> {
//   List<Patient> patients = [];
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   // Future<void> fetchData() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   final response = await http.get(
//   //       Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'),
//   //       headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzkzNjEzMjM3LCJpYXQiOjE3MDcyMTMyMzcsImp0aSI6ImZjMDkzMjdiNDdjZDRkYWM4ZTk5MmMyYzcxNzI1MDE1IiwidXNlcl9pZCI6MjF9.bpYH7vDW0P-3SXaVQ6eGJOV8pXDtplCCNlMRx9B8peE"});
//   //   if (response.statusCode == 200) {
//   //     final data = jsonDecode(response.body);
//   //     List<Patient> fetchedPatients = [];
//   //     for (var patient in data) {
//   //       fetchedPatients.add(Patient.fromJson(patient));
//   //     }
//   //     setState(() {
//   //       patients = fetchedPatients;
//   //       isLoading = false;
//   //     });
//   //   } else {
//   //     throw Exception('Failed to load patients');
//   //   }

//   // }
//   Future<void> fetchData() async {
//     setState(() {
//       isLoading = true;
//     });
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString('token');
//     final response = await http.get(
//       Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'),
//       headers: {"Authorization": "Bearer $token"},
//     );

//     if (response.statusCode == 200) {
//       print(response.body);
//       final data = jsonDecode(response.body);
//       print("my data ${data}");
//       List<Patient> fetchedPatients = [];
//       data.forEach(
//         (key, value) {
//           fetchedPatients.add(Patient.fromJson(value));
//         },
//       );
//       // for (var patient in data) {
//       //   fetchedPatients.add(Patient.fromJson(patient));
//       // }
//       setState(() {
//         patients = fetchedPatients;
//         isLoading = false;
//       });
//     } else {
//       throw Exception('Failed to load patients');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Patient List'),
//       ),
//       body: RefreshIndicator(
//         onRefresh: fetchData,
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Search',
//                       ),
//                       onChanged: (value) {},
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color.fromRGBO(1, 106, 41, 0.98),
//                           Color.fromRGBO(1, 106, 41, 0.98)
//                         ],
//                       ),
//                     ),
//                     margin: EdgeInsets.all(10),
//                     child: Center(
//                       child: TextButton(
//                         onPressed: () {
//                           // Implement search button logic here
//                         },
//                         child: Text(
//                           'Search',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : patients.isEmpty
//                       ? Center(
//                           child: Text('Empty list image'),
//                         )
//                       : ListView.builder(
//                           itemCount: patients.length,
//                           itemBuilder: (context, index) {
//                             final patient = patients[index];
//                             return ListTile(
//                               title: Text(patient.name),
//                               subtitle: Text(
//                                   'ID: ${patient.id}, Name: ${patient.name}'),
//                             );
//                           },
//                         ),
//             ),
//             Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color.fromRGBO(1, 106, 41, 0.98),
//                     Color.fromRGBO(1, 106, 41, 0.98)
//                   ],
//                 ),
//               ),
//               margin: EdgeInsets.all(10),
//               child: Center(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => RegistrationForm()));
//                   },
//                   child: Text(
//                     'Register Now',
//                     style: TextStyle(color: Color.fromARGB(255, 243, 240, 240)),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String?> Savethetoken(String entrytoken) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novindius/Entities/patienModel.dart';
import 'package:novindius/Presentation/pages/register.dart';
import 'package:novindius/resportories.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class PatientListPage extends StatelessWidget {
  final PatientListController controller = Get.put(PatientListController(fetchPatientsUseCase: null!));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.patients.isEmpty) {
            return Center(
              child: Text('Empty list image'),
            );
          } else {
            return ListView.builder(
              itemCount: controller.patients.length,
              itemBuilder: (context, index) {
                final patient = controller.patients[index];
                return ListTile(
                  title: Text(patient.name),
                  subtitle: Text('ID: ${patient.id}, Name: ${patient.name}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(RegistrationForm());
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> fetchData() async {
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    final response = await http.get(
      Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      print("my data ${data}");
      List<Patient> fetchedPatients = [];
      data.forEach(
        (key, value) {
          fetchedPatients.add(Patient.fromJson(value));
        },
      );
      // for (var patient in data) {
      //   fetchedPatients.add(Patient.fromJson(patient));
      // }
    
    } else {
      throw Exception('Failed to load patients');
    }
  }

  Future<List<PatientListPage>> fetchPatients() {}

}

class PatientListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchPatientsUseCase(
          patientRepository: PatientRepositoryImpl(
            client: http.Client(),
          ),
        ));
    Get.lazyPut(() => PatientListController(fetchPatientsUseCase: null!));
  }
}

class PatientListController extends GetxController {
  final FetchPatientsUseCase fetchPatientsUseCase;

  PatientListController({
    required this.fetchPatientsUseCase,
  });

  final RxBool isLoading = true.obs;
  final RxList<Patient> patients = <Patient>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    isLoading.value = true;
    try {
      final patientsResult = await fetchPatientsUseCase.execute();
      patients.assignAll(patientsResult as Iterable<Patient>);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch patients: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}