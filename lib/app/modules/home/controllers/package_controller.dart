import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yggy/core/domain/repositories/command.dart';
import 'package:yggy/core/utils/constants.dart';

class PackageController extends GetxController {
  final GetStorage _getStorage = GetStorage();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final Command command = Command();

  void toggleLoading() => _isLoading.value = !_isLoading.value;

  @override
  void onInit() {
    // run system commands and initialized storage
    if (dotenv.env['PRODUCTION']! == 'false') {
      _getStorage.listenKey(NODE_PATH, (value) {
        print('NODE_PATH is $value');
      });
      _getStorage.listenKey(NODE_VERSION, (value) {
        print('NODE_VERSION is $value');
      });
      _getStorage.listenKey(NODE_INSTALLED, (value) {
        print('NODE_INSTALLED is $value');
      });
      _getStorage.listenKey(WEBI_PATH, (value) {
        print('WEBI_PATH is $value');
      });
      _getStorage.listenKey(WEBI_INSTALLED, (value) {
        print('WEBI_INSTALLED is $value');
      });
    }
    initNode();
    initNodeVersion();
    initWebi();

    super.onInit();
  }

  /// Initialized On Init
  ///
  /// > Check if node is installed on our System
  ///
  /// > Check if node is on PATH
  ///
  Future<void> initNode() async {
    nodeInstalled = await command.locate('node');
  }

  /// Set Local Storage Key:
  /// > NODE_INSTALLED
  ///
  set nodeInstalled(bool val) {
    _getStorage.write(NODE_INSTALLED, val);
  }

  /// Get Local Storage Key:
  /// > NODE_INSTALLED
  ///
  bool get nodeInstalled {
    if (_getStorage.hasData(NODE_INSTALLED)) {
      return _getStorage.read(NODE_INSTALLED) as bool;
    } else {
      return false;
    }
  }

  /// Initialized On Init
  ///
  /// > Check if webi is installed on our System
  ///
  /// > Check if webi is on PATH
  Future<void> initWebi() async {
    webiInstalled = await command.locate('webi');
  }

  /// Set Local Storage Key:
  /// > WEBI_INSTALLED
  ///
  set webiInstalled(bool val) {
    _getStorage.write(WEBI_INSTALLED, val);
  }

  /// Get Local Storage Key:
  /// > WEBI_INSTALLED
  ///
  bool get webiInstalled {
    if (_getStorage.hasData(WEBI_INSTALLED)) {
      return _getStorage.read(WEBI_INSTALLED) as bool;
    } else {
      return false;
    }
  }

  /// Initialized On Init
  ///
  /// > Check the current node version
  ///
  Future<void> initNodeVersion() async {
    final List<String> args = ['-v'];
    nodeVersion = await command.getVersion('node', args);
  }

  /// Set Local Storage Key:
  /// > NODE_VERSION
  ///
  set nodeVersion(String? val) {
    if (val != null || val != '') {
      _getStorage.write(NODE_VERSION, val);
    } else {
      _getStorage.remove(NODE_VERSION);
    }
  }

  /// Get Local Storage Key:
  /// > NODE_VERSION
  ///
  String get nodeVersion {
    if (_getStorage.hasData(NODE_VERSION)) {
      return _getStorage.read(NODE_VERSION) as String;
    } else {
      return '';
    }
  }

  // TODO: This will Download Webi and Pathman
  /// Check if webi is installed
  ///
  /// if Not installed we use curl
  ///
  /// before we use curl
  ///
  /// we check if curl exists in the system
  ///
  /// webi and pathman is added in the path
  ///
  /// Located in ~/.local/bin/
  ///
  Future<bool> initPackageManager() async {
    var curl = 'curl';
    final List<String> args = [];

    if (await command.locate('webi')) {
      return true;
    } else {
      if (GetPlatform.isWindows) {
        curl = '$curl.exe';
        args.add('-A');
        args.add('"MSA"');
        args.add('https://webinstall.dev/webi');
        args.add('|');
        args.add('powershell');
      } else {
        args.add('-sS');
        args.add('https://webinstall.dev/webi');
        args.add('|');
        args.add('bash');
      }

      toggleLoading();
      final process = await Process.start(curl, args);
      if (await process.exitCode == 1) {
        Get.snackbar('Platform Error', 'Failed to Download Webi Installer');
        return false;
      }
      toggleLoading();
      return true;
    }
  }
  // TODO: if curl doesnt exists in the system
  // This is the case on windows 10 older version
  // we can try to use wget
  // do research also we wget exist in older windows 10
  // Also we need to save all our script either in the
  // App directory Or
  // local bin directory which is added to path by pathman in webi
}
