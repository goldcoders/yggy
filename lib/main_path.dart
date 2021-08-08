import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'app.dart';

Future<void> main() async {
  print('Current path style: ${p.style}');

// useful for getting the current path
  print('Current process path: ${p.current}');

  print('Separators');
  for (final entry in [p.posix, p.windows, p.url]) {
    print('  ${entry.style.toString().padRight(7)}: ${entry.separator}');
  }
  runApp(App());
}
