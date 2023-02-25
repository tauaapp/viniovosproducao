// ignore_for_file: avoid_print, duplicate_ignore

import 'package:get/get.dart';
import 'package:viniovos/src/constants/storage_keys.dart';
import 'package:viniovos/src/models/user_model.dart';
import 'package:viniovos/src/pages/auth/result/auth_result.dart';
import 'package:viniovos/src/pages_routes/app_pages.dart';
import 'package:viniovos/src/services/utils_services.dart';
import '../respository/auth_respository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  Future<void> validateToken() async {
    // recuperando o token que foi salvo localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }
    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (messager) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // Zerar user
    user = UserModel();
    // Remover o token localmente
    await utilsServices.removeLocalData(key: StorageKeys.token);

    // Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    // salve token
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);
    // tela base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signIn({
    required String phone,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(phone: phone, password: password);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}

  // final utilsServices = UtilsServices();

  // UserModel user = UserModel();

  // @override
  // void onInit() {
  //   super.onInit();

  //   validateToken();
  // }

 
  
  
  


  // Future<void> signOut() async {
  //   // Zerar o user
  //   user = UserModel();

  //   // Remover o token localmente
  //   await utilsServices.removeLocalData(key: StorageKeys.token);

  //   // Ir para o login
  //   Get.offAllNamed(PagesRoutes.signInRoute);
  // }

  // void saveTokenAndProceedToBase() {
  //   // Salvar o token
  //   utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

  //   // Ir para a base
  //   Get.offAllNamed(PagesRoutes.baseRoute);
  // }

  