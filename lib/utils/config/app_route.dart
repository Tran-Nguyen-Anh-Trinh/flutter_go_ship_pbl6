import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/tab_bar_bindings.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/tab_bar_page.dart';
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
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/permission_handler/permission_handler_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/permission_handler/permission_handler_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/search/search_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/search/search_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

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
  ];
}
