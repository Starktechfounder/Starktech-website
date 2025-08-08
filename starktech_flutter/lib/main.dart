import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/theme.dart';
import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/projects.dart';
import 'pages/blog.dart';
import 'pages/contact.dart';

void main() {
  runApp(const StarkTechApp());
}

class StarkTechApp extends StatefulWidget {
  const StarkTechApp({super.key});

  @override
  State<StarkTechApp> createState() => _StarkTechAppState();
}

class _StarkTechAppState extends State<StarkTechApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stark Tech',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
        '/about': (context) => AboutPage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
        '/projects': (context) => ProjectsPage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
        '/blog': (context) => BlogPage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
        '/contact': (context) => ContactPage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
      },
    );
  }
}
