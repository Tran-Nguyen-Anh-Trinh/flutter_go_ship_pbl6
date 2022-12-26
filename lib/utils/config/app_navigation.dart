import 'package:flutter_go_ship_pbl6/base/presentation/widgets/camera_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/order_detail/order_detail_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/rating_shipper/rating_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/search/search_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Models/infor_user.dart';

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

  static void toRegisterCustomer({RouteType type = RouteType.to, required int role}) {
    type.navigate(name: AppRoute.registerCustomer, arguments: role);
  }

  static void toConfirmRegisterCustomer({RouteType type = RouteType.to, required RegisterRequest registerRequest}) {
    type.navigate(name: AppRoute.confirmRegisterCustomer, arguments: registerRequest);
  }

  static void toTabBar({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.tabBar);
  }

  static void toPermissionHandler({RouteType type = RouteType.offAll, required AccountModel account}) {
    type.navigate(name: AppRoute.permissionHandler, arguments: account);
  }

  static void toSearch({RouteType type = RouteType.to, InputSearch? inputSearch}) {
    type.navigate(name: AppRoute.serach, arguments: inputSearch);
  }

  static void toChatHome({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.chatHome);
  }

  static void toChatDetail({RouteType type = RouteType.to, InforUser? input}) {
    type.navigate(name: AppRoute.chatDetail, arguments: input);
  }

  static void toViewMedia({RouteType type = RouteType.to, Map<String, dynamic>? input}) {
    type.navigate(name: AppRoute.viewMedia, arguments: input);
  }

  static void toConfirmShipper({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.confirmShipper);
  }

  static void toAddAddress({RouteType type = RouteType.to, required bool isSetting}) {
    type.navigate(name: AppRoute.addAddress, arguments: isSetting);
  }

  static void toConfirmShipperCamera({RouteType type = RouteType.to, required TypeCamera typeCamera}) {
    type.navigate(name: AppRoute.confirmShipperCamera, arguments: typeCamera);
  }

  static void toStatusConfirm({RouteType type = RouteType.offAll, required bool isDeny}) {
    type.navigate(name: AppRoute.statusConfirm, arguments: isDeny);
  }

  static void toCreateOrder({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.createOrder);
  }

  static void toOrderAddress({RouteType type = RouteType.to, required isStartAddress}) {
    type.navigate(name: AppRoute.orderAddress, arguments: isStartAddress);
  }

  static void toSetting({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.setting);
  }

  static void toProfile({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.profile);
  }

  static void toChangePassword({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.changePassword);
  }

  static void toSettingSystem({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.settingSystem);
  }

  static void toOrderDetail({RouteType type = RouteType.to, required OrderDetailInput orderDetailInput}) {
    type.navigate(name: AppRoute.orderDetailShipper, arguments: orderDetailInput);
  }

  static void toNotification({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.notification);
  }

  static void toRatingShipper({RouteType type = RouteType.offAndTo, required RateInput rateInput}) {
    type.navigate(name: AppRoute.ratingShipper, arguments: rateInput);
  }
}
