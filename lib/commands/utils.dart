import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import '../app/modules/home/controllers/home_controller.dart';

Future<bool> getCommand(String command, HomeController controller) async {
  bool installed = false;
  String? results;
  String? locator = GetPlatform.isWindows ? "where" : "command";

  List<String> args = [];

  controller.toggleLoading();

  if (!GetPlatform.isWindows) {
    args.add("-v");
  }
  args.add(command);
  final process = await Process.start(locator, args);
  final lineStream = process.stdout
      .transform(const Utf8Decoder())
      .transform(const LineSplitter());

  await for (final line in lineStream) {
    results = line;
  }
  await process.stderr.drain();

  if (results != null) {
    installed = true;
  }

  if (await process.exitCode == 1) {
    Get.snackbar('Platform Error', '$command is not Installed in the System');
  }
  controller.toggleLoading();
  return installed;
}

Future<String?> checkVersion(
    String command, List<String> args, HomeController controller) async {
  String? version;
  controller.toggleLoading();

  final process = await Process.start('node', args);
  final lineStream = process.stdout
      .transform(const Utf8Decoder())
      .transform(const LineSplitter());

  await for (final line in lineStream) {
    version = line;
  }
  await process.stderr.drain();

  if (await process.exitCode == 1) {
    version = null;
    Get.snackbar('Platform Error', '$command is not Installed in the System');
  }
  controller.toggleLoading();
  return version;
}
