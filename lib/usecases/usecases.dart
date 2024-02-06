import 'package:novindius/Entities/patienModel.dart';

class FetchPatientsUseCase {
  final PatientRepository repository;

  FetchPatientsUseCase(this.repository);

  Future<List<Patient>> execute() async {
    return repository.fetchPatients();
  }
}

class RegisterPatientUseCase {
  final PatientRepository patientRepository;

  RegisterPatientUseCase(this.patientRepository);

  Future<void> execute(Patient patient) async {
    await patientRepository.registerPatient(patient);
  }
}

class FetchBranchesUseCase {
  final BranchRepository repository;

  FetchBranchesUseCase(this.repository);

  Future<List<Branch>> execute() async {
    return repository.fetchBranches();
  }
}

class FetchTreatmentsUseCase {
  final TreatmentRepository repository;

  FetchTreatmentsUseCase(this.repository);

  Future<List<Treatment>> execute() async {
    return repository.fetchTreatments();
  }
}