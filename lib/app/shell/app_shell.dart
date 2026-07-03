import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTabChanged;
  final bool showBottomNav;

  const AppShell({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabChanged,
    this.showBottomNav = true,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,

      bottomNavigationBar: widget.showBottomNav
          ? BottomNavigationBar(
              currentIndex: widget.currentIndex,
              onTap: widget.onTabChanged,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mic),
                  label: "Record",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_tree),
                  label: "Mind Map",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
            )
          : null,
    );
  }
}