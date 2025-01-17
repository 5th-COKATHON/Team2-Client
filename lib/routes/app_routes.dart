import 'package:get/get.dart';
import 'package:team2_client/views/sample_page.dart';

class AppRoutes {
  static const HOME = '/';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => SamplePage(),
    ),
  ];
}
