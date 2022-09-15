import 'package:login_bloc_example/login/models/auth_data.dart';

enum PasswordValidationErrorType { empty }

// class PasswordValidationError implements AuthDataError {
//   @override
//   late final String message;
//   final PasswordValidationErrorType passwordValidationErrorType;
//
//   PasswordValidationError(this.passwordValidationErrorType) {
//     switch (passwordValidationErrorType) {
//       case PasswordValidationErrorType.empty:
//         message = 'Empty password';
//         break;
//       default:
//         message = 'Undefined error';
//         break;
//     }
//   }
// }

class Password implements AuthDataField {
  @override
  late final String value;
  bool _invalid = true;

  @override
  bool get invalid => _invalid;

  Password(String password) {
    final errorType = validator(password);
    value = password;
    if (errorType != null) {
      _invalid = true;
      return;
      // throw PasswordValidationError(errorType);
    }
    _invalid = false;
  }

  Password.empty() : value = '';

  @override
  PasswordValidationErrorType? validator(String? value) {
    if (value?.isNotEmpty ?? true) {
      return null;
    } else {
      return PasswordValidationErrorType.empty;
    }
  }
}
