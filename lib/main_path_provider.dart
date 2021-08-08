import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';

Future<void> main() async {
  await GetStorage.init();
  await dotenv.load();
  print(await _getDocPath());
  print(await _getAppPath());
  print(await _getAppDocPath());
  print(await _localFile('home'));
  print(await _getLibraryDirectory());
  runApp(App());
}

Future<String> _getDocPath() async {
  // final http.Client _client = http.Client();
  // final req = await _client.get(Uri.parse(url));
  // final bytes = req.bodyBytes;
  final String dir = (await getApplicationDocumentsDirectory()).path;
  // final File file = File('$dir/$filename');
  // await file.writeAsBytes(bytes);
  return dir;
}

Future<String> _getAppPath() async {
  final String dir = (await getApplicationSupportDirectory()).path;
  return dir;
}

Future<String> _getAppDocPath() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  return appDocPath;
}

Future<String> _getLibraryDirectory() async {
  return (await getApplicationDocumentsDirectory()).path;
}

Future<File> _localFile(String name) async {
  final path = await localPath();

  if (!await Directory('$path/posts').exists()) {
    await Directory('$path/posts').create(recursive: true);
  }
  if (GetPlatform.isWindows) {
    return File('$path\\posts\\$name.md');
  } else {
    return File('$path/posts/$name.md');
  }
}

Future<String?> localPath() async {
  final directory = (await getDownloadsDirectory())?.path;

  return directory;
}
