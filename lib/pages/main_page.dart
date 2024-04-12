import 'package:avvento_media/componets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../apis/version_checker_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late VersionChecker versionChecker;

  @override
  void initState() {
    super.initState();
    OneSignal.initialize("10eb7e55-4746-4247-9880-ef6a56f92a1e");
    versionChecker = VersionChecker('https://api.github.com/repos/Muta-Jonathan/AvventoMedia-flutter-Apk/releases/latest');
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     versionChecker.checkForUpdates(context);
    });
    return const NavBar();
  }
}
