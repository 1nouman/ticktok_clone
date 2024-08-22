import 'package:fpdart/src/either.dart';
import 'package:ticktok_proj/core/entities/user.dart';
import 'package:ticktok_proj/core/usecase/usecase.dart';
import 'package:ticktok_proj/core/error/failure.dart';
import 'package:ticktok_proj/features/auth/domain/repositeries/auth_repositry.dart';

class LoginUsecase implements Usecase<User, LoginParams> {
  final AuthRepositry repositry;
  LoginUsecase(this.repositry);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repositry.loginwithEmailPassword(
        email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}
