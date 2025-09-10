import 'package:dio_jwt_demo/core/router.dart';
import 'package:flutter/material.dart';
import 'package:dio_jwt_demo/di/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize service Locator
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Dio + JWT + BLoC Demo',
        routerConfig: router,
      ),
    );
  }
}
