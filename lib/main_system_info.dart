import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:system_info/system_info.dart';

import 'app.dart';

Future<void> main() async {
  await GetStorage.init();
  await dotenv.load();

  print(home);
  print(architecture);
  print(bit);
  print(os);
  print(osVersion);
  print(kernel);
  runApp(App());
}

/// Extract this to a Helper Functions
/// Use to get our Userprofile Path
///   print(userHome);
String get home {
  return SysInfo.userDirectory;
}

String get architecture {
  return SysInfo.kernelArchitecture;
}

int get bit {
  return SysInfo.kernelBitness;
}

String get kernel {
  return SysInfo.kernelName;
}

String get os {
  return SysInfo.operatingSystemName;
}

String get osVersion {
  return SysInfo.operatingSystemVersion;
}
