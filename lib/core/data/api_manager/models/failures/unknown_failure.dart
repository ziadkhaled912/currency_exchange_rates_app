import '../../api_manager.dart';

class UnknownFailure extends ReportableFailure {
  UnknownFailure(FailureInfo failureInfo)
      : super(failureInfo: failureInfo, type: 'Unkown Failure');
}
