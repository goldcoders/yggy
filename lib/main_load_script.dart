import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as p;

import 'app.dart';

Future<void> main() async {
  await GetStorage.init();
  await dotenv.load();
  final packages = await getPackageJson();
  final scripts = packages['scripts'];
  scripts.forEach((key, value) {
    print(key); // This will be showned in our UI
    print(value); // this will be run when they click the button
  });
  runApp(App());
}

Future<dynamic> getPackageJson() async {
  return File('${p.current}/downloads/package.json')
      .readAsString()
      .then((String contents) {
    return json.decode(contents);
  });
}
