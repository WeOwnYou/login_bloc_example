// abstract class AuthDataError implements Exception{
//   final message = '';
// }

abstract class AuthDataField {
  final String value = '';
  final bool invalid = false;
  dynamic validator(String value);
}
