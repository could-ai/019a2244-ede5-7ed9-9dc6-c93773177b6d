import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/request_screen.dart';
import 'screens/messaging_screen.dart';
import 'screens/provider_panel_screen.dart';
import 'app_state.dart';

void main() {
  runApp(const BambifixApp());
}

class BambifixApp extends StatelessWidget {
  const BambifixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Bambifix - Uganda Service Finder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF007A33), // Uganda green
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF007A33),
            secondary: const Color(0xFFFFD100), // Yellow accent
          ),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16),
          ),
        ),
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => const AuthScreen(),
          '/home': (context) => const HomeScreen(),
          '/request': (context) => const RequestScreen(),
          '/messaging': (context) => const MessagingScreen(),
          '/provider_panel': (context) => const ProviderPanelScreen(),
        },
      ),
    );
  }
}