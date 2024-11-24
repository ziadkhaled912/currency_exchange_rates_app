import 'package:equatable/equatable.dart';

class SignUpRequestModel extends Equatable {
  const SignUpRequestModel({
    required this.email,
    required this.password,
    required this.name,
  });
  final String email;
  final String password;
  final String name;

  @override
  List<Object?> get props => [email, password, name];
}
