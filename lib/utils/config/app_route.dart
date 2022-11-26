import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/tab_bar_bindings.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/tab_bar_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/add_address/add_address_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/add_address/add_address_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_camera/confirm_camera_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_camera/confirm_camera_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_shipper_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/status_confirm/status_confirm_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/status_confirm/status_confirm_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/forgot_password/forgot_password_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/forgot_password/forgot_password_otp_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/forgot_password/forgot_password_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/login/login_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/login/login_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/register_customer/confirm_register_customer/confirm_register_customer_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/register_customer/confirm_register_customer/confirm_register_customer_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/register_customer/register_customer_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/register_customer/register_customer_page.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/welcome/welcome_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/welcome/welcome_page.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/chat_detail/chat_detail_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/view_media/view_media_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/view_media/view_media_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/create_order/create_order_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/create_order/create_order_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/order_address/order_address_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/order_address/order_address_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/permission_handler/permission_handler_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/permission_handler/permission_handler_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/search/search_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/search/search_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/setting/setting_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/setting/setting_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/chat_detail/chat_detail_page.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/chat_home/chat_home_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/chat_home/chat_home_page.dart';
import 'package:get/route_manager.dart';

import '../../../feature/authentication/presentation/view/demo/demo_bindings.dart';
import '../../../feature/authentication/presentation/view/demo/demo_page.dart';
import '../../feature/authentication/presentation/view/root/root_bindings.dart';
import '../../feature/authentication/presentation/view/root/root_page.dart';

class AppRoute {
  static String root = '/';
  static String demo = '/demo';
  static String welcome = '/welcome';
  static String login = '/login';
  static String forgotPassword = '/forgotPassword';
  static String forgotPasswordOtp = '/forgotPasswordOtp';
  static String registerCustomer = '/register_customer';
  static String confirmRegisterCustomer = '/confirmRegisterCustomer';
  static String tabBar = '/tabBar';
  static String permissionHandler = '/permissionHandler';
  static String serach = '/search';
  static String chatHome = '/chatHome';
  static String chatDetail = '/chatDetail';
  static String viewMedia = '/viewMedia';
  static String confirmShipper = '/confirmShipper';
  static String addAddress = '/addAddress';
  static String confirmShipperCamera = '/confirmShipperCamera';
  static String statusConfirm = '/statusConfirm';
  static String createOrder = '/createOrder';
  static String orderAddress = '/orderAddress';
  static String setting = '/setting';

  static List<GetPage> generateGetPages = [
    GetPage(
      name: root,
      page: RootPage.new,
      binding: RootBindings(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: demo,
      page: DemoPage.new,
      binding: DemoBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: welcome,
      page: WelcomePage.new,
      binding: WelcomeBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: LoginPage.new,
      binding: LoginBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: forgotPassword,
      page: ForgotPasswordPage.new,
      binding: ForgotPasswordBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: forgotPasswordOtp,
      page: ForgotPasswordOtpPage.new,
      binding: ForgotPasswordBindings(),
    ),
    GetPage(
      name: registerCustomer,
      page: RegisterCustomerPage.new,
      binding: RegisterCustomerBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: confirmRegisterCustomer,
      page: ConfirmRegisterCustomerPage.new,
      binding: ConfirmRegisterCustomerBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: tabBar,
      page: TabBarPage.new,
      binding: TabBarBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: permissionHandler,
      page: PermissionHandlerPage.new,
      binding: PermissionHandlerBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: serach,
      page: SearchPage.new,
      binding: SearchBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: chatHome,
      page: ChatHomePage.new,
      binding: ChatHomeBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: chatDetail,
      page: ChatDetailPage.new,
      binding: ChatDetailBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: viewMedia,
      page: ViewMediaPage.new,
      binding: ViewMediaBindings(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: confirmShipper,
      page: ConfirmShipperPage.new,
      binding: ConfirmShipperBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: addAddress,
      page: AddAddressPage.new,
      binding: AddAddressBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: confirmShipperCamera,
      page: ConfirmCameraPage.new,
      binding: ConfirmCameraBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: statusConfirm,
      page: StatusConfirmPage.new,
      binding: StatusConfirmBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: createOrder,
      page: CreateOrderPage.new,
      binding: CreateOrderBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: orderAddress,
      page: OrderAddressPage.new,
      binding: OrderAddressBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: setting,
      page: SettingPage.new,
      binding: SettingBindings(),
      transition: Transition.cupertino,
    ),
  ];
}
