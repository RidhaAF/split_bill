import 'package:go_router/go_router.dart';
import 'package:split_bill/pages/home/home_page.dart';
import 'package:split_bill/pages/main_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'main',
      path: '/',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
