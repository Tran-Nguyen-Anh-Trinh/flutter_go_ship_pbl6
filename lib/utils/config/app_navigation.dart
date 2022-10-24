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
}
