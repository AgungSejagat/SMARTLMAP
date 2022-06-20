import 'package:flutter/material.dart';
import '/app_setting/appsetting_screen.dart';
import '/app_setting/language_screen.dart';
import '/app_setting/theme_screen.dart';
import '/app_setting/aboutus_screen.dart';
import '/home_screen/home_screen.dart';
import '/device_setting/devicesetting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import '../providers/my_devices.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return ChangeNotifierProvider.value(
              value: MyDevices(),
              child: MaterialApp(
                home: HomeScreen(),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primarySwatch: Colors.indigo),
                darkTheme: ThemeData.dark(),
                themeMode: currentMode,
                initialRoute: 'home_screen',
                routes: {
                  'home_screen': (context) => HomeScreen(),
                  'appsetting_screen': (context) => SettingScreen(),
                  'devicesetting_screen': (context) => DeviceSettingsScreen(),
                  'language_screen': (context) => LanguageScreen(),
                  'theme_screen': (context) => ThemeScreen(),
                  'aboutus_screen': (context) => AboutUsScreen(),
                },
              ));
        });
  }
}
