import 'package:flutter/material.dart';
import 'package:friday_hybrid/ui/accounts/account_screen.dart';
import 'package:friday_hybrid/ui/daily_tasks/daily_task_screen.dart';
import 'package:friday_hybrid/ui/issues/issue_screen.dart';
import 'package:friday_hybrid/ui/workspace/ui/workspace_screen.dart';
import 'package:friday_hybrid/ui/workspace/viewModel/workspace_view_model.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (_) => WorkspaceViewModel()),
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

  static const List<Widget> _widgetOptions = <Widget>[
    WorkspaceScreen(),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Workspace',
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
