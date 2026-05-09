import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home_screen.dart';
import 'screens/workspace_screen.dart';
import 'screens/bot_builder_screen.dart';

void main() {
  runApp(const NovaForgeApp());
}

class NovaForgeApp extends StatelessWidget {
  const NovaForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaForge AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F111A), // Dark tech background
        primaryColor: const Color(0xFF6C63FF), // Purple neon accent
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF00E5FF), // Cyan neon accent
          surface: Color(0xFF1A1D2D), // Card surface color
          background: Color(0xFF0F111A),
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F111A),
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1A1D2D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/workspace': (context) => const WorkspaceScreen(),
        '/bot_builder': (context) => const BotBuilderScreen(),
      },
    );
  }
}
