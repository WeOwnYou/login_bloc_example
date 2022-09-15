import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future<User>.delayed(
      const Duration(microseconds: 300),
      () => _user = User(
        const Uuid().v4(),
      ),
    );
  }
}