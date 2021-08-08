import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'core/data/datasources/supabase.dart';
import 'core/data/datasources/theme.dart';
import 'core/services/theme.dart';
import 'core/utils/logger.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        enableLog: true,
        logWriterCallback: Logger.write,
        initialBinding: SupabaseBinding(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        title: dotenv.env['APP_NAME']!,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightTheme,
        darkTheme: AppTheme().darkTheme,
        themeMode: ThemeService().getThemeMode(),
      ),
      designSize: const Size(800, 600),
    );
  }
}
