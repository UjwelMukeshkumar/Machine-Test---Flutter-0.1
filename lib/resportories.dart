import 'package:novindius/Presentation/pages/patientlist.dart';

class FetchPatientsUseCase {
  final PatientListPage repository;

  FetchPatientsUseCase(this.repository, {required patientRepository});

  Future<List<PatientListPage>> execute() async {
    return repository.fetchPatients();
  }
}

