import '../../api_manager.dart';

class ServiceNotAvailableFailure extends ReportableFailure {
  ServiceNotAvailableFailure(FailureInfo failureInfo)
      : super(failureInfo: failureInfo, type: 'Service Not Available');
}
