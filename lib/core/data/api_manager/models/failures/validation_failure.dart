import '../../api_manager.dart';

class ValidationFailure extends Failure {
  ValidationFailure(this.valueKey);
  final String valueKey;

  @override
  List<Object?> get props => [id, valueKey];
}
