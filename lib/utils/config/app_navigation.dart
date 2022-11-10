import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/search/search_controller.dart';

import '../extension/route_type.dart';
import 'app_route.dart';

class N {
  static void toDemoPage({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.demo);
  }

  static void toWelcomePage({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.welcome);
  }

  static void toLoginPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.login);
  }

  static void toForgotPasswordPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.forgotPassword);
  }

  static void toForgotPasswordOtpPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.forgotPasswordOtp);
  }

  static void toRegisterCustomer({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.registerCustomer);
  }

  static void toConfirmRegisterCustomer({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.confirmRegisterCustomer);
  }

  static void toTabBar({RouteType type = RouteType.offAll, required AccountModel account}) {
    type.navigate(name: AppRoute.tabBar, arguments: account);
  }

  static void toPermissionHandler({RouteType type = RouteType.offAll, required AccountModel account}) {
    type.navigate(name: AppRoute.permissionHandler, arguments: account);
  }

  static void toSearch({RouteType type = RouteType.to, InputSearch? inputSearch}) {
    type.navigate(name: AppRoute.serach, arguments: inputSearch);
  }
}
