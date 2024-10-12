import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/colors/colors.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/theme_controller.dart';
import 'package:sunshine_app/services/multi_providers.dart';
import 'package:sunshine_app/view/home_screen.dart';
import 'package:sunshine_app/view/ipad11.dart';
import 'package:sunshine_app/view/ipad14.dart';
import 'package:sunshine_app/view/ipad15.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = getBoolAsync('is_dark') ?? false;

    return MultiProvider(
      providers: MultiProviderClass.providersList,
      child: Builder(
        builder: (context) {
          Provider.of<ThemeController>(context, listen: false)
              .themeChange(isDark);
          return Consumer<ThemeController>(
            builder: (context, value, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sunshine Driver Portal',
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.dark(
                  primary: AppColors.primaryColor,
                  secondary: const Color(0xff282828),
                  surface: const Color(0xff282828).withOpacity(0.6),
                  onSurface: Colors.white,
                ),
                brightness: Brightness.dark,
                textTheme: const TextTheme(
                  titleLarge: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xff111111),
                ),
              ),
              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                colorScheme: ColorScheme.light(
                  primary: AppColors.primaryColor,
                  secondary: Colors.grey.shade300,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                textTheme: const TextTheme(
                  titleLarge: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              themeMode: value.currentTheme,
              navigatorKey: navigatorKey,
              home: const VisibilityWrapper(
                bodyScreen: HomeScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
