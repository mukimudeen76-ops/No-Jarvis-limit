import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jarvis_ai/providers/app_state_provider.dart';
import 'package:jarvis_ai/providers/settings_provider.dart';
import 'package:jarvis_ai/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('memory');
  runApp(const JarvisApp());
}

class JarvisApp extends StatelessWidget {
  const JarvisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => AppStateProvider()..init()),
      ],
      child: MaterialApp(
        title: 'J.A.R.V.I.S.',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF030402),
          fontFamily: 'ShareTechMono',
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFFB347),
            secondary: Color(0xFFFFB347),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
