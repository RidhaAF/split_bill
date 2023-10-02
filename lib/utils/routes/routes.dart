import 'package:go_router/go_router.dart';
import 'package:split_bill/pages/bill/bill_form_page.dart';
import 'package:split_bill/pages/bill/choose_friends_page.dart';
import 'package:split_bill/pages/home/home_page.dart';
import 'package:split_bill/pages/main_page.dart';
import 'package:split_bill/pages/setting/setting_page.dart';

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
    GoRoute(
      name: 'form',
      path: '/bill/form',
      builder: (context, state) => const BillFormPage(),
    ),
    GoRoute(
      name: 'friends',
      path: '/bill/choose-friends',
      builder: (context, state) => const ChooseFriendsPage(),
    ),
    GoRoute(
      name: 'setting',
      path: '/setting',
      builder: (context, state) => const SettingPage(),
    ),
  ],
);
