import 'package:get/get.dart';

import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/loading/views/loading_view.dart';
import '../modules/login_user/bindings/login_user_binding.dart';
import '../modules/login_user/views/login_user_view.dart';
import '../modules/register_user/bindings/register_user_binding.dart';
import '../modules/register_user/views/register_user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOADING;

  static final routes = [
    GetPage(
      name: _Paths.LOADING,
      page: () => const LoadingView(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_USER,
      page: () => const LoginUserView(),
      binding: LoginUserBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_USER,
      page: () => const RegisterUserView(),
      binding: RegisterUserBinding(),
    ),
  ];
}
