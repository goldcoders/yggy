import 'package:get/get.dart';

import '../controllers/package_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageController>(
      () => PackageController(),
    );
  }
}
