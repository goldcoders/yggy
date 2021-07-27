import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  void toggleLoading() => _isLoading.value = !_isLoading.value;
}
