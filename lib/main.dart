import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'app/modules/home/views/home_view.dart';

Future<void> main() async {
  runApp(GetMaterialApp(home: HomeView()));
  await dotenv.load(fileName: ".env");
}
