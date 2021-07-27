import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/home/views/home_view.dart';

Future<void> main() async {
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  runApp(GetMaterialApp(home: HomeView()));
}
