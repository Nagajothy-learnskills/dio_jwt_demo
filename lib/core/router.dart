import 'package:dio_jwt_demo/features/auth/presentation/screens/home_screen.dart';
import 'package:dio_jwt_demo/features/auth/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
    builder: (context,state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context,state) => const HomeScreen(),
    )
  ]
);