import 'package:get/get.dart';
import 'package:team2_client/views/signup_page.dart';

class AppRoutes {
  static const HOME = '/';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => SignupPage(),
    ),
  ];
}
