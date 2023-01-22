import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_repository_impl.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';

class AuthController extends GetxController {
  final authRepository = Get.find<AuthRepository>();

  RxBool isLoggedIn = false.obs;

  @override
  onInit() async {
    isLoggedIn.value = await isAuthenticated();
    super.onInit();
  }

  isAuthenticated() async {
    return await authRepository.isAuthenticated();
  }

  void logout() {
    authRepository.logout();

    isLoggedIn.value = false;
    Get.offAndToNamed(Routes.login);
  }

  authorize() async {
    isLoggedIn.value = true;
    Get.offAndToNamed(Routes.dashboard);
  }
}
