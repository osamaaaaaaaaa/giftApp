import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AuthController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Authcontroller());
  }
}
