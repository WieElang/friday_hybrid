import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/daily_tasks/viewModel/daily_task_view_model.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/tasks/details/ui/task_detail_screen.dart';
import 'package:provider/provider.dart';

class DailyTaskScreen extends StatefulWidget {
  const DailyTaskScreen({super.key});

  @override
  State<DailyTaskScreen> createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    Provider.of<DailyTaskViewModel>(context, listen: false).getTasks();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<DailyTaskViewModel>(context, listen: false).getTasks();
    }
  }

  void _onSelectedTask(Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task))
    );
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Task>> taskData = Provider.of<DailyTaskViewModel>(context).baseData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Task"),
        backgroundColor: Colors.transparent,
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          taskData.data != null && taskData.data!.isNotEmpty
              ? Expanded(
              child: ListView.builder(
                  itemCount: taskData.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Task task = taskData.data![index];
                    return InkWell(
                      onTap: () => _onSelectedTask(task),
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            child: Text(task.name),
                          )
                      ),
                    );
                  }
              ))
              : const Expanded(child: Center(
            child: Text('No Data'),
          )),
          Expanded(
              child: Center(
                  child: Column(
                    children: [
                      if (taskData.errorMessage != null)
                        Text(taskData.errorMessage!),
                      if (taskData.exception is SessionException)
                        ElevatedButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginScreen())
                              )
                            },
                            child: const Text('Login Again')
                        )
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}
