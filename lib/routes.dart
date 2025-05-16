import 'package:chat_app/components/chat/ui/chat_page.dart';
import 'package:chat_app/components/login/ui/login_page.dart';
import 'package:chat_app/components/main/ui/main_page.dart';
import 'package:chat_app/components/register/ui/register_page.dart';
import 'package:chat_app/components/spash/ui/splash_page.dart';
import 'package:chat_app/main.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  navigatorKey: navigatorKey,
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
          name: 'main_page',
          builder: (context, state) => MainPage(),
          routes: [
            GoRoute(
              path: 'chat_page',
              name: 'chat_page',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>;
                final String userEmail = extra['user_email']! as String;
                final String userId = extra['user_id']! as String;
                final String name = extra['user_name']! as String;
                return ChatPage(
                  userEmail: userEmail,
                  name: name,
                  userId: userId,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
