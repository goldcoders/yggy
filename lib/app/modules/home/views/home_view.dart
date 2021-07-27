import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../commands/utils.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final homectl = Get.put(HomeController());
  // use get find here we will make a new controller that is globally available
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
            child: Text('Check Node'),
            onPressed: () async {
              // This is How we Use Our Get Command and Check Version Command
              if (await getCommand('node', homectl)) {
                List<String> args = ['-v'];
                String? version = await checkVersion('node', args, homectl);
                if (version != null) {
                  Get.snackbar("Node", "version: $version");
                }
              }
              // TODO: Handle Download if there is no command
              // TODO: Handle Upgrade if the version is outdated
              // TODO: Uninstall that Specific Command
              // TODO: Uninstall Specific Version of CLI
            }),
      ),
    );
  }
}
