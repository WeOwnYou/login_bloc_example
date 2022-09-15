import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_example/login/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginState()) {
    on<LoginUsernameChanged>(_onUserNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onUserNameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username(event.username);
    final status = username.invalid || state.password.invalid
        ? LoginStatus.validationFailure
        : LoginStatus.validated;
    emit(
      state.copyWith(
        status: status,
        username: username,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password(event.password);
    final status = password.invalid || state.username.invalid
        ? LoginStatus.validationFailure
        : LoginStatus.validated;
    emit(
      state.copyWith(
        status: status,
        password: password,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status == LoginStatus.validated) {
      emit(state.copyWith(status: LoginStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {
        emit(state.copyWith(status: LoginStatus.submissionFailure));
      }
    }
  }
}
