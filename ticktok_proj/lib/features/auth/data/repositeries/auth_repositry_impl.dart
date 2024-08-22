import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:ticktok_proj/core/entities/user.dart';
import 'package:ticktok_proj/core/error/failure.dart';
import 'package:ticktok_proj/core/exception/server_exception.dart';
import 'package:ticktok_proj/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:ticktok_proj/features/auth/domain/repositeries/auth_repositry.dart';

class AuthRepositryImpl implements AuthRepositry {
  final AuthRemoteDatasources authRemoteDatasources;

  AuthRepositryImpl(this.authRemoteDatasources);

  @override
  Future<Either<Failure, User>> loginwithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDatasources.loginWithEmailPassword(
          email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpwithEmailPassword(
      {required String name,
      required String email,
      required String password,
      required File image}) async {
    try {
      final user = await authRemoteDatasources.signUpWithEmailPassword(
          email: email, password: password, name: name, image: image);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
