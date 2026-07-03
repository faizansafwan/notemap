import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notemap/app/shell/app_shell.dart';
import 'package:notemap/features/home/home_page.dart';
import 'package:notemap/features/mindmap/mindmap_page.dart';
import 'package:notemap/features/record/record_page.dart';
import 'package:notemap/features/settings/settings_page.dart';

Future<void> main() async {

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootNavigation(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

class RootNavigation extends StatefulWidget {
  const RootNavigation({super.key});

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int index = 0;

  final pages = const [
    HomePage(),
    RecordPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      currentIndex: index,
      onTabChanged: (i) => setState(() => index = i),
      child: pages[index],
    );
  }
}