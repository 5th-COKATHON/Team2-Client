import 'package:get/get.dart';
import 'package:team2_client/views/game_page.dart';
import 'package:team2_client/views/new_account_page.dart';
import 'package:team2_client/views/rank_board_page.dart';
import 'package:team2_client/views/signup_page.dart';
import 'package:team2_client/views/start_page.dart';

class AppRoutes {
  static const HOME = '/';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => StartPage(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupPage(),
    ),
    GetPage(
      name: '/new_account',
      page: () => NewAccountPage(),
    ),
    // 게임(괴롭히기) 화면
    GetPage(
      name: '/game',
      page: () => GamePage(),
    ),
    GetPage(
      name: '/rank',
      page: () => RankBoardPage(),
    ),
  ];
}
