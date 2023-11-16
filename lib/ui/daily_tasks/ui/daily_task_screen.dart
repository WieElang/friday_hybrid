import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/daily_tasks/viewModel/daily_task_view_model.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/tasks/details/ui/task_detail_screen.dart';
import 'package:friday_hybrid/utils/date_utils.dart' as utils;
import 'package:provider/provider.dart';

import '../../tasks/form/ui/task_form_screen.dart';

class DailyTaskScreen extends StatefulWidget {
  const DailyTaskScreen({super.key});

  @override
  State<DailyTaskScreen> createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  final DateTime today = DateTime.now().toLocal();

  @override
  void initState() {
    super.initState();
    Provider.of<DailyTaskViewModel>(context, listen: false).getTasks();
  }

  void _onSelectedTask(Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task))
    );
  }

  void _onEditTask(Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskFormScreen(project: task.project!, task: task))
    );
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Task>> taskData = Provider.of<DailyTaskViewModel>(context).baseData;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Daily Task",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600
              )
            ),
            Text(utils.DateUtils.formatToDisplayString(today),
              style: const TextStyle(fontSize: 10.0),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Column(
              children: [
                taskData.data != null && taskData.data!.isNotEmpty
                    ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListView.builder(
                          itemCount: taskData.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Task task = taskData.data![index];
                            return InkWell(
                              onTap: () => _onSelectedTask(task),
                              onLongPress: () => _onEditTask(task),
                              child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                    child: Text(task.name),
                                  )
                              ),
                            );
                          }
                      ),
                    ))
                    : const Center(child: Text('No Data')),
              ],
            ),
          ),
          Flexible(
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
                            ).then((value) => {
                              Provider.of<DailyTaskViewModel>(context, listen: false).getTasks()
                            })
                          },
                          child: const Text('Login Again')
                      )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
