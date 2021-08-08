import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/package_controller.dart';

class HomeView extends GetView<PackageController> {
  // use get find here we will make a new controller that is globally available
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
            onPressed: () async {
              print(controller.nodeInstalled);
              print(controller.nodeVersion);
              print(controller.webiInstalled);
              // TODO: Handle Upgrade if the version is outdated
              // TODO: Uninstall that Specific Command
              // TODO: Uninstall Specific Version of CLI
            },
            child: const Text('Check Node')),
      ),
    );
  }
}
