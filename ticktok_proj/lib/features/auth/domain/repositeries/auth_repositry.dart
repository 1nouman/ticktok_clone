import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:ticktok_proj/core/entities/user.dart';
import 'package:ticktok_proj/core/error/failure.dart';

abstract interface class AuthRepositry {
  
 Future<Either<Failure,User>> signUpwithEmailPassword({ required String name,
    required String email,
    required String password,
    
    required File image,
    
    });
  
 Future<Either<Failure,User>> loginwithEmailPassword({
    required String email,
    required String password,});
}
