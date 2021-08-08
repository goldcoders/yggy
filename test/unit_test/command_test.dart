import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yggy/core/domain/repositories/command.dart';
import 'package:yggy/core/utils/constants.dart';

class FakeCommand extends Fake implements Command {
  @override
  Future<bool> locate(String command) async {
    if (command == 'node' ||
        command == 'webi' ||
        command == 'pathman' ||
        command == 'hugo') {
      return Future.value(true);
    }
    return false;
  }

  @override
  Future<String?> getVersion(String command, List<String> args) async {
    if (command == 'node') {
      final String version = dotenv.env[NODE_VERSION]!;
      return Future.value(version);
    } else if (command == 'hugo') {
      final String version = dotenv.env[HUGO_VERSION]!;
      return Future.value(version);
    } else {
      return Future.value(null);
    }
  }
}

void main() {
  final command = FakeCommand();

  setUp(() {
    print(Directory.current.toString());
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  });

  group('Command Exists in PATH', () {
    test('Node Should Be Installed', () async {
      final bool installed = await command.locate('node');
      expect(installed, true);
    });

    test('Webi Should Be Installed', () async {
      final bool installed = await command.locate('webi');
      expect(installed, true);
    });

    test('Hugo Should Be Installed', () async {
      final bool installed = await command.locate('hugo');
      expect(installed, true);
    });
  });

  group('Version Check', () {
    test('Node Version Installed Should be v14.17.1', () async {
      final List<String> args = ['-v'];
      final String? version = await command.getVersion('node', args);
      expect(version, 'v14.17.1');
    });
    test('Hugo Version Installed Should be v0.85.0+extended', () async {
      final List<String> args = ['version'];
      final String? version = await command.getVersion('hugo', args);
      expect(version, 'v0.85.0+extended');
    });
  });
}
