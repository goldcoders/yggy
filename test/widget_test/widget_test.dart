import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yggy/app.dart';
import 'package:yggy/app/modules/home/views/home_view.dart';
import 'package:yggy/core/utils/constants.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GetStorage g;

  const channel = MethodChannel('plugins.flutter.io/path_provider');
  void setUpMockChannels(MethodChannel channel) {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return '.';
      }
    });
  }

  setUpAll(() async {
    setUpMockChannels(channel);
    await dotenv.load();
  });

  setUp(() async {
    await GetStorage.init();
    g = GetStorage();
    await g.erase();
  });

  group('Test Local Storage For Commands', () {
    testWidgets('Set Node To Local Storage', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      final titleFinder = find.text('Check Node');

      expect(find.text('Check Node'), findsOneWidget);
      expect(titleFinder, findsOneWidget);

      await tester.tap(find.byType(TextButton));
      g.write(NODE_INSTALLED, 'true');
      g.write(NODE_VERSION, 'v14.17.1');
      await tester.pumpAndSettle();

      expect('true', g.read<String>(NODE_INSTALLED));
      expect('v14.17.1', g.read<String>(NODE_VERSION));
    });

    testWidgets('Set Webi To Local Storage', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      final titleFinder = find.text('Check Node');

      expect(find.text('Check Node'), findsOneWidget);
      expect(titleFinder, findsOneWidget);

      await tester.tap(find.byType(TextButton));
      g.write(WEBI_INSTALLED, 'false');
      await tester.pumpAndSettle();

      expect('false', g.read<String>(WEBI_INSTALLED));
    });
  });

  group('Test App Routes', () {
    testWidgets('Test Home Route Exists', (tester) async {
      await tester.pumpWidget(GetMaterialApp(
        initialRoute: '/home',
        getPages: [
          GetPage(page: () => HomeView(), name: '/home'),
        ],
      ));

      Get.toNamed('/home');

      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('Test Unknown Route as Fallback Route', (tester) async {
      await tester.pumpWidget(GetMaterialApp(
        initialRoute: '/home',
        unknownRoute: GetPage(name: '/404', page: () => const Scaffold()),
        getPages: [
          GetPage(page: () => HomeView(), name: '/home'),
        ],
      ));

      Get.toNamed('/secondd');

      await tester.pumpAndSettle();

      expect(Get.currentRoute, '/404');
    });
  });
}

// will be useful later on
// ignore: unused_element
// Future<File> _fileDb(
//     {bool isBackup = false, String fileName = 'GetStorage'}) async {
//   final dir = await getApplicationDocumentsDirectory();
//   final _path = dir.path;
//   final _file =
//       isBackup ? File('$_path/$fileName.bak') : File('$_path/$fileName.gs');
//   return _file;
// }
