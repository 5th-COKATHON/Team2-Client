import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:team2_client/routes/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '',
      initialRoute: AppRoutes.HOME,
      getPages: AppRoutes.routes,
    );
  }
}
