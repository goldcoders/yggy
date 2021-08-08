import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../services/theme.dart';

class SupabaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => AuthService());
    Get.put(ThemeService());
  }
}
