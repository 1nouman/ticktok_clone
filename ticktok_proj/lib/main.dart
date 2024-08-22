
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticktok_proj/core/constants.dart';

import 'package:ticktok_proj/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticktok_proj/features/auth/presentation/pages/login_screen.dart';

import 'package:ticktok_proj/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await initDependencies();
  // await Firebase.initializeApp(
  //   // name: 'tiktokproject-75ddd',
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
    MultiBlocProvider(
      child: const MyApp(),
      providers: [
        BlocProvider(
          create: (context) => serviceLocater<AuthBloc>()
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.b
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}
