import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(
      const Duration(
        milliseconds: 300,
      ),
      () {
        if (username == '1' && password == '2') {
          _controller.add(AuthenticationStatus.authenticated);
          Future<void>.delayed(
            const Duration(seconds: 5),
            () {
              _controller.add(AuthenticationStatus.unauthenticated);
            },
          );
        } else {
          throw Exception('Wrong login/password');
        }
      },
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
