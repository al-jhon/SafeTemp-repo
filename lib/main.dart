import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/constants/landing%20page/landing.dart';
import 'package:provider/provider.dart';
import 'package:safe_temp/constants/theme/theme.dart';
import 'package:safe_temp/features/main%20controller/screens/main_controller.dart';
import 'package:safe_temp/provider%20functions/my_navbar_state_provider.dart';
import 'package:safe_temp/provider%20functions/my_theme_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove(); // Remove the splash screen after 3 seconds
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyThemeProvider>(
          create: (_) => MyThemeProvider(),
        ),
        ChangeNotifierProvider<MyNavbarStateProvider>(
          create: (_) => MyNavbarStateProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (context, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: context.watch<MyThemeProvider>().darkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: user == null ? const Landing() : const MainController(),
        ),
      ),
    );
  }
}
