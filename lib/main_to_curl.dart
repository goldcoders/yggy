import 'package:http/http.dart';
import 'package:to_curl/to_curl.dart';

Future<void> main() async {
  final req1 = Request(
      'GET',
      Uri.parse(
          'https://curl.se/windows/dl-7.78.0/curl-7.78.0-win64-mingw.zip'));
  print(toCurl(req1));
}
