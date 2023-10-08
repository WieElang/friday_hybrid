import 'package:flutter/material.dart';
import 'package:friday_hybrid/ui/accounts/ui/account_screen.dart';
import 'package:friday_hybrid/ui/accounts/viewModel/account_view_model.dart';
import 'package:friday_hybrid/ui/daily_tasks/daily_task_screen.dart';
import 'package:friday_hybrid/ui/home/ui/home_screen.dart';
import 'package:friday_hybrid/ui/home/viewModel/home_view_model.dart';
import 'package:friday_hybrid/ui/issues/ui/issue_screen.dart';
import 'package:friday_hybrid/ui/issues/viewModel/issue_view_model.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/login/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

import 'core/session.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => IssueViewModel()),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
      ],
      child: MaterialApp(
        title: 'Friday',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.dark
        ),
        home: const HomeBottomNavigationBar(),
      ),
    );
  }
}

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  State<HomeBottomNavigationBar> createState() => _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Session.getSessionKey().then((value) {
      if (value == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen())
        );
      }
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    IssueScreen(),
    DailyTaskScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack (
          children: [
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            label: 'Issues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Daily Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
