import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ticktok_proj/core/utills/firebase_options.dart';
import 'package:ticktok_proj/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:ticktok_proj/features/auth/data/repositeries/auth_repositry_impl.dart';
import 'package:ticktok_proj/features/auth/domain/repositeries/auth_repositry.dart';
import 'package:ticktok_proj/features/auth/domain/usecases/login_usecase.dart';
import 'package:ticktok_proj/features/auth/domain/usecases/signup_usecase.dart';
import 'package:ticktok_proj/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocater = GetIt.instance;
Future<void> initDependencies() async {
  await Firebase.initializeApp(
    // name: 'tiktokproject-75ddd',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseAuth auth = FirebaseAuth.instance;

  serviceLocater.registerLazySingleton<FirebaseAuth>(() => auth);

  final FirebaseStorage storage = FirebaseStorage.instance;

  serviceLocater.registerLazySingleton<FirebaseStorage>(() => storage);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  serviceLocater.registerLazySingleton<FirebaseFirestore>(() => firestore);

  _init();
}

_init() {
  serviceLocater.registerFactory<AuthRemoteDatasources>(
    () => AuthRemoteDataSourceImpl(
      serviceLocater(),
      serviceLocater(),
      serviceLocater(),

    ),
  );

  serviceLocater.registerFactory<AuthRepositry>(
    () => AuthRepositryImpl(
      serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => LoginUsecase(
      serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => SignupUsecase(
      serviceLocater(),
    ),
  );

  serviceLocater.registerLazySingleton(
    () => AuthBloc(
      loginuc: serviceLocater(),
      signupUsecase: serviceLocater(),
    ),
  );
}
