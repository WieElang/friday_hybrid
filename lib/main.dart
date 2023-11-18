import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friday_hybrid/ui/accounts/ui/account_screen.dart';
import 'package:friday_hybrid/ui/accounts/viewModel/account_view_model.dart';
import 'package:friday_hybrid/ui/daily_tasks/ui/daily_task_screen.dart';
import 'package:friday_hybrid/ui/daily_tasks/viewModel/daily_task_view_model.dart';
import 'package:friday_hybrid/ui/home/ui/home_screen.dart';
import 'package:friday_hybrid/ui/home/viewModel/home_view_model.dart';
import 'package:friday_hybrid/ui/issues/details/viewModel/issue_detail_view_model.dart';
import 'package:friday_hybrid/ui/issues/form/viewModel/issue_form_view_model.dart';
import 'package:friday_hybrid/ui/issues/index/ui/issue_screen.dart';
import 'package:friday_hybrid/ui/issues/index/viewModel/issue_view_model.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/login/viewModel/login_view_model.dart';
import 'package:friday_hybrid/ui/tasks/details/viewModel/task_detail_view_model.dart';
import 'package:friday_hybrid/ui/tasks/form/viewModel/task_form_view_model.dart';
import 'package:friday_hybrid/ui/tasks/index/viewModel/task_view_model.dart';
import 'package:friday_hybrid/utils/alarm_utils.dart';
import 'package:provider/provider.dart';

import 'core/session.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // setupAlarm();
  runApp(const MyApp());
}

void setupAlarm() async {
  await Alarm.init();
  AlarmUtils.stopAllAlarm();

  var now = DateTime.now();
  int day = now.weekday;
  if (![DateTime.saturday, DateTime.sunday].contains(day)) {
    // Set Morning Alarm
    AlarmUtils.setAlarm(
        AlarmUtils.morningAlarmId,
        DateTime(now.year, now.month, now.day, 9, 0, 0).toLocal(),
        "Be Ready For Work", "Please check your task and issue"
    );

    // Set Afternoon Alarm
    AlarmUtils.setAlarm(
        AlarmUtils.afternoonAlarmId,
        DateTime(now.year, now.month, now.day, 16, 30, 0).toLocal(),
        "End Of Day", "Please update your task"
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => TaskDetailViewModel()),
        ChangeNotifierProvider(create: (_) => TaskFormViewModel()),
        ChangeNotifierProvider(create: (_) => IssueViewModel()),
        ChangeNotifierProvider(create: (_) => IssueDetailViewModel()),
        ChangeNotifierProvider(create: (_) => IssueFormViewModel()),
        ChangeNotifierProvider(create: (_) => DailyTaskViewModel()),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Friday',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.light,
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white
        ),
        darkTheme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.dark,
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.black
        ),
        themeMode: ThemeMode.dark,
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
        ).then((value) => {
          Provider.of<HomeViewModel>(context, listen: false).getProjects()
        });
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
        backgroundColor: Colors.transparent,
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
