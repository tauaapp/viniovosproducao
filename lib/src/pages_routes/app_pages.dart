import 'package:get/get.dart';
import 'package:viniovos/src/pages/base/base_screen.dart';
import 'package:viniovos/src/pages/home/binding/home_binding.dart';
import 'package:viniovos/src/pages/splash/splash_screen.dart';

import '../pages/auth/view/sign_in_screen.dart';
import '../pages/auth/view/sign_up_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    // GetPage(
    //   page: () => ProductScreen(),
    //   name: PagesRoutes.productRoute,
    // ),
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.signUpRoute,
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        //   NavigationBinding(),
        HomeBinding(),
        //   CartBinding(),
        //   OrdersBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String productRoute = '/product';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
