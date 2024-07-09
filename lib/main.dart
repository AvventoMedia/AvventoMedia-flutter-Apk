import 'dart:io';

import 'package:avvento_media/componets/app_constants.dart';
import 'package:avvento_media/firebase_options.dart';
import 'package:avvento_media/routes/routes.dart';
import 'package:avvento_media/themes/dark_theme.dart';
import 'package:avvento_media/themes/light_theme.dart';
import 'package:avvento_media/widgets/providers/programs_provider.dart';
import 'package:avvento_media/widgets/providers/radio_podcast_provider.dart';
import 'package:avvento_media/widgets/providers/radio_station_provider.dart';
import 'package:avvento_media/widgets/providers/youtube_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import 'bindings/initial_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  await Upgrader.clearSavedSettings(); // clear upgrader settings
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationIcon: 'mipmap/ic_logo_icon',
    androidNotificationOngoing: true,
    androidStopForegroundOnPause: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProgramsProvider>(
        create: (context) => ProgramsProvider(),
        ),
        ChangeNotifierProvider<RadioStationProvider>(
            create: (context) => RadioStationProvider(),
        ),
        ChangeNotifierProvider<RadioPodcastProvider>(
          create: (context) => RadioPodcastProvider(),
        ),
        ChangeNotifierProvider<YoutubeProvider>(
          create: (context) => YoutubeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  //DependencyInjection.init();
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: GetMaterialApp( // Use GetMaterialApp instead of MaterialApp
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          initialRoute: Routes.getHomeRoute(), // Set the initial route to '/'
          getPages: Routes.routes,
          initialBinding: InitialBinding(),
        ),
      ),
    );
  }
}
