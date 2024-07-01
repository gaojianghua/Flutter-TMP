import 'package:get/get.dart';

import '../modules/account/codeLoginStepOne/bindings/code_login_step_one_binding.dart';
import '../modules/account/codeLoginStepOne/views/code_login_step_one_view.dart';
import '../modules/account/codeLoginStepTwo/bindings/code_login_step_two_binding.dart';
import '../modules/account/codeLoginStepTwo/views/code_login_step_two_view.dart';
import '../modules/account/onStepLogin/bindings/on_step_login_binding.dart';
import '../modules/account/onStepLogin/views/on_step_login_view.dart';
import '../modules/account/passLogin/bindings/pass_login_binding.dart';
import '../modules/account/passLogin/views/pass_login_view.dart';
import '../modules/account/registerStepOne/bindings/register_step_one_binding.dart';
import '../modules/account/registerStepOne/views/register_step_one_view.dart';
import '../modules/account/registerStepThree/bindings/register_step_three_binding.dart';
import '../modules/account/registerStepThree/views/register_step_three_view.dart';
import '../modules/account/registerStepTwo/bindings/register_step_two_binding.dart';
import '../modules/account/registerStepTwo/views/register_step_two_view.dart';
import '../modules/address/addressAdd/bindings/address_add_binding.dart';
import '../modules/address/addressAdd/views/address_add_view.dart';
import '../modules/address/addressEdit/bindings/address_edit_binding.dart';
import '../modules/address/addressEdit/views/address_edit_view.dart';
import '../modules/address/addressList/bindings/address_list_binding.dart';
import '../modules/address/addressList/views/address_list_view.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/productDetail/bindings/product_detail_binding.dart';
import '../modules/productDetail/views/product_detail_view.dart';
import '../modules/productList/bindings/product_list_binding.dart';
import '../modules/productList/views/product_list_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 11:18:46
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-15 10:54:44
 * @Description: file content
 */

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TABS;

  static final routes = [
    GetPage(
      name: _Paths.TABS,
      page: () => const TabsView(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => const ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.Cart,
      page: () => CartView(),
    ),
    GetPage(
      name: _Paths.CODE_LOGIN_STEP_ONE,
      page: () => const CodeLoginStepOneView(),
      binding: CodeLoginStepOneBinding(),
    ),
    GetPage(
      name: _Paths.CODE_LOGIN_STEP_TWO,
      page: () => const CodeLoginStepTwoView(),
      binding: CodeLoginStepTwoBinding(),
    ),
    GetPage(
      name: _Paths.ON_STEP_LOGIN,
      page: () => const OnStepLoginView(),
      binding: OnStepLoginBinding(),
    ),
    GetPage(
      name: _Paths.PASS_LOGIN,
      page: () => const PassLoginView(),
      binding: PassLoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_STEP_ONE,
      page: () => const RegisterStepOneView(),
      binding: RegisterStepOneBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_STEP_TWO,
      page: () => const RegisterStepTwoView(),
      binding: RegisterStepTwoBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_STEP_THREE,
      page: () => const RegisterStepThreeView(),
      binding: RegisterStepThreeBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_LIST,
      page: () => const AddressListView(),
      binding: AddressListBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_ADD,
      page: () => const AddressAddView(),
      binding: AddressAddBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_EDIT,
      page: () => const AddressEditView(),
      binding: AddressEditBinding(),
    ),
  ];
}
