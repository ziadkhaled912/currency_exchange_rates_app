import '../../api_manager.dart';

class TypeFailure extends ReportableFailure {
  TypeFailure(FailureInfo failureInfo, [this.data])
      : super(failureInfo: failureInfo, type: 'TypeError');
  final dynamic data;
}
