part of 'login_bloc.dart';

enum LoginStatus {
  submissionInProgress,
  validationFailure,
  submissionFailure,
  initial,
  validated
}

class LoginState extends Equatable {
  final LoginStatus status;
  final Username username;
  final Password password;
  LoginState({
    this.status = LoginStatus.initial,
    Username? username,
    Password? password,
  })  : username = username ?? Username.empty(),
        password = password ?? Password.empty();

  LoginState copyWith({
    LoginStatus? status,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [status, username, password];
}
