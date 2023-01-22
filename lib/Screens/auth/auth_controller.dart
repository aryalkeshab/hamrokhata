import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_repository_impl.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

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
    // Get.offAndToNamed(Routes.login);
    Get.offNamed(Routes.login);
    authRepository.logout();
    isLoggedIn.value = false;
    showSuccessToast('Successfully logged out. ');
  }

  authorize() async {
    isLoggedIn.value = true;
    Get.offAndToNamed(Routes.dashboard);
  }
}
