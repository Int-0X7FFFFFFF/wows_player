import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wows_player/pages/splash/splash_page.dart';
import 'package:wows_player/user_setting.dart';
import 'generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle _makeSystemOverlayStyle() {
  return const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  );
}

Future<dynamic> highRefreshRate() async {
  // HighRefreshRat
  try {
    await FlutterDisplayMode.setHighRefreshRate();
  } catch (e) {
    /// e.code =>
    /// noAPI - No API support. Only Marshmallow and above.
    /// noActivity - Activity is not available. Probably app is in background
    // ignore: avoid_print
  }
  return 'OK';
}

UserSetting userSetting = UserSetting();

void main() async {
  // Navigation bar and status bar immersion
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    final overlayStye = _makeSystemOverlayStyle();
    SystemChrome.setSystemUIOverlayStyle(overlayStye);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }
  await highRefreshRate();
  await userSetting.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: userSetting),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wows player',
      locale: userSetting.locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: userSetting.getColorSeed,
        brightness:
            userSetting.getDarkMode == 1 ? Brightness.dark : Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: userSetting.getColorSeed,
        brightness: Brightness.dark,
      ),
      themeMode: userSetting.getDarkMode == -1
          ? ThemeMode.system
          : (userSetting.getDarkMode == 0 ? ThemeMode.light : ThemeMode.dark),
      builder: BotToastInit(),
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      home: const SplashPage(),
    );
  }
}
