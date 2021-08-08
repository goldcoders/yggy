import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

class Command {
  Future<bool> locate(String command) async {
    bool installed = false;
    String? results;
    final String locator = GetPlatform.isWindows ? 'where' : 'command';

    final List<String> args = [];

    if (!GetPlatform.isWindows) {
      args.add('-v');
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
    return installed;
  }

  Future<String?> getVersion(String command, List<String> args) async {
    String? version;

    final process = await Process.start(command, args);
    final lineStream = process.stdout
        .transform(const Utf8Decoder())
        .transform(const LineSplitter());

    await for (final line in lineStream) {
      version = line;
    }
    await process.stderr.drain();

    if (await process.exitCode == 1) {
      version = null;
    }
    return version;
  }
}
