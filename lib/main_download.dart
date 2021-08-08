import 'dart:io';

import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as p;

import 'app.dart';

Future<void> main() async {
  await GetStorage.init();
  await dotenv.load();

  download('https://curl.se/windows/dl-7.78.0/curl-7.78.0-win64-mingw.zip');

  runApp(App());
}

Future<DownloaderCore> download(String url) async {
  return Flowder.download(url, dlProgress());
}

DownloaderUtils dlProgress() {
  return DownloaderUtils(
    progressCallback: (current, total) {
      final progress = (current / total) * 100;
      print('Downloading: $progress');
    },
    file: File('${p.current}/downloads/curl.zip'),
    progress: ProgressImplementation(),
    onDone: () => print('Download done'),
    deleteOnCancel: true,
  );
}
