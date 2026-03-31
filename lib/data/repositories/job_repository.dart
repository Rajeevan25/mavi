import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/job.dart';
import '../mock/mock_data.dart';

part 'job_repository.g.dart';

@riverpod
class JobRepository extends _$JobRepository {
  @override
  List<Job> build() {
    return MockData.jobs;
  }

  void addJob(Job job) {
    state = [...state, job];
  }

  void updateJobStatus(String id, JobStatus status) {
    state = [
      for (final job in state)
        if (job.id == id) job.copyWith(status: status) else job,
    ];
  }

  void assignEmployees(String jobId, List<String> employeeIds) {
    state = [
      for (final job in state)
        if (job.id == jobId)
          job.copyWith(assignedEmployeeIds: [...job.assignedEmployeeIds, ...employeeIds])
        else
          job,
    ];
  }
}

@riverpod
Job? jobById(Ref ref, String id) {
  final jobs = ref.watch(jobRepositoryProvider);
  try {
    return jobs.firstWhere((j) => j.id == id);
  } catch (_) {
    return null;
  }
}

@riverpod
List<Job> jobsByDate(Ref ref, DateTime date) {
  final jobs = ref.watch(jobRepositoryProvider);
  return jobs.where((j) => 
    j.date.year == date.year && 
    j.date.month == date.month && 
    j.date.day == date.day
  ).toList();
}
