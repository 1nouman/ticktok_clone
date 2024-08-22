import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/src/either.dart';
import 'package:ticktok_proj/core/entities/user.dart';
import 'package:ticktok_proj/core/usecase/usecase.dart';
import 'package:ticktok_proj/core/error/failure.dart';
import 'package:ticktok_proj/features/auth/domain/repositeries/auth_repositry.dart';

class SignupUsecase implements Usecase<User, SignUpParams> {
  final AuthRepositry repositry;
  SignupUsecase(this.repositry);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repositry.signUpwithEmailPassword(
        name: params.name, email: params.email, password: params.password, image: params.image);
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;
  final File image;


  SignUpParams(this.email, this.name, this.password, this.image);
}
