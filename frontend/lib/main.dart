import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart' as logger;
import 'package:uuid/uuid.dart';
import 'core/app_export.dart';

var uuid = const Uuid();

List<CameraDescription> cameras = <CameraDescription>[];
Future<void> main() async {
  logger.Logger.root.level = logger.Level.WARNING; // defaults to Level.INFO
  logger.Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    // Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        translations: AppLocalization(),
        locale: Get.deviceLocale, //for setting localization strings
        fallbackLocale: Locale('en', 'US'),
        title: 'vaibhav_s_application2',
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
      );
    });

  }
}
