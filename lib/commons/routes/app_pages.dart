import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hamrokhata/Screens/auth/login.dart';
import 'package:hamrokhata/Screens/auth/register.dart';
import 'package:hamrokhata/Screens/dashboard/dashboard.dart';
import 'package:hamrokhata/Screens/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  final initial = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: SplashScreen.new,
    ),
    GetPage(
      name: _Paths.login,
      page: LoginScreen.new,
    ),
    GetPage(
      name: _Paths.dashboard,
      page: DashBoardScreen.new,
    ),
    GetPage(
      name: _Paths.register,
      page: RegisterScreen.new,
    ),
  ];
}
