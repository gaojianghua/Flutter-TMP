/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 11:25:45
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-20 14:47:42
 * @Description: file content
 */
import 'package:get/get.dart';

// import '../../cart/controllers/cart_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../../give/controllers/give_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../user/controllers/user_controller.dart';
import '../controllers/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    // Get.lazyPut<CartController>(
    //   () => CartController(),
    // );
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<GiveController>(
      () => GiveController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }
}
