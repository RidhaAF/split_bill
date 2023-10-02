import 'package:go_router/go_router.dart';
import 'package:split_bill/pages/bill/add_item_page.dart';
import 'package:split_bill/pages/bill/bill_form_page.dart';
import 'package:split_bill/pages/bill/choose_friends_page.dart';
import 'package:split_bill/pages/bill/widgets/friend_avatar.dart';
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
      name: 'choose-friends',
      path: '/bill/choose-friends',
      builder: (context, state) {
        final Map summary =
            (state.extra as Map<String, Object>)['summary'] as Map;

        return ChooseFriendsPage(
          summary: summary,
        );
      },
    ),
    GoRoute(
      name: 'add-item',
      path: '/bill/add-item',
      builder: (context, state) {
        final Map summary =
            (state.extra as Map<String, Object>)['summary'] as Map;
        final List<FriendAvatar> friends = (state.extra
            as Map<String, Object>)['friends'] as List<FriendAvatar>;

        return AddItemPage(
          summary: summary,
          friends: friends,
        );
      },
    ),
    GoRoute(
      name: 'setting',
      path: '/setting',
      builder: (context, state) => const SettingPage(),
    ),
  ],
);
