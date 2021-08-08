import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test/test.dart';
import 'package:yggy/core/utils/constants.dart';

void main() {
  group('dotenv', () {
    setUp(() {
      print(Directory.current.toString());
      dotenv.testLoad(
          fileInput: File('.env.test')
              .readAsStringSync()); //, mergeWith: Platform.environment
    });
    test('able to load .env', () {
      expect(dotenv.env[API_URL], 'https://test.supabase.co');
      expect(dotenv.env[API_DOMAIN], 'goldcoders.dev');
      expect(dotenv.env[API_KEY], 'SomeRandomString');
      expect(dotenv.env[API_SECRET], 'secret');
      expect(dotenv.env[API_HOST], 'localhost');
      expect(dotenv.env[APP_LOGO], 'assets/images/app.png');
      expect(dotenv.env[APP_NAME], 'YGGY');
      expect(dotenv.env[APP_VERSION], 'V1.0.0');
      expect(dotenv.env[APP_COMPANY], 'GOLDCODERS CORP.');
      expect(dotenv.env[PRODUCTION], 'true');
      expect(dotenv.env[NODE_VERSION], 'v14.17.1');
    });
  });
}
