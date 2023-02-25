import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:viniovos/src/models/user_model.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult.success(UserModel user) = Success;
  factory AuthResult.error(String message) = Error;
}


// comando do build runer pluguin => flutter pub run build_runner build