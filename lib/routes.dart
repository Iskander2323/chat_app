import 'package:chat_app/components/login/ui/login_page.dart';
import 'package:chat_app/components/main/ui/main_page.dart';
import 'package:chat_app/components/register/ui/register_page.dart';
import 'package:chat_app/components/spash/ui/splash_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/splash_page',
  routes: [
    GoRoute(
      path: '/splash_page',
      name: 'splash_page',
      builder: (context, state) => SplashPage(),
      routes: [
        GoRoute(
          path: 'login_page',
          name: 'login_page',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: 'register_page',
          name: 'register_page',
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: 'main_page',
          name: 'main_pag',
          builder: (context, state) => MainPage(),
        ),
      ],
    ),
  ],
);
