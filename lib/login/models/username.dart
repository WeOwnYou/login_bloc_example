import 'package:login_bloc_example/login/models/auth_data.dart';

enum UsernameValidationErrorType { empty }

// class UsernameValidationError implements AuthDataError {
//   @override
//   late final String message;
//   final UsernameValidationErrorType usernameValidationErrorType;
//
//   UsernameValidationError(this.usernameValidationErrorType) {
//     switch (usernameValidationErrorType) {
//       case UsernameValidationErrorType.empty:
//         message = 'Empty username';
//         break;
//       default:
//         message = 'Undefined error';
//         break;
//     }
//   }
// }

class Username implements AuthDataField {
  @override
  late final String value;
  bool _invalid = true;

  @override
  bool get invalid => _invalid;

  Username(String username) {
    final errorType = validator(username);
    value = username;
    if (errorType != null) {
      _invalid = true;
      return;
      // throw UsernameValidationError(errorType);
    }
    _invalid = false;
  }

  Username.empty() : value = '';

  @override
  UsernameValidationErrorType? validator(String? value) {
    if (value?.isNotEmpty ?? true) {
      return null;
    } else {
      return UsernameValidationErrorType.empty;
    }
  }
}
