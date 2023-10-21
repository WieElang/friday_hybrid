import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/tasks/details/ui/task_detail_screen.dart';
import 'package:friday_hybrid/ui/tasks/form/ui/task_form_screen.dart';
import 'package:friday_hybrid/ui/tasks/index/viewModel/task_view_model.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  final Project project;
  const TaskScreen({super.key, required this.project});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).getTasks(widget.project.id);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<TaskViewModel>(context, listen: false).getTasks(widget.project.id);
    }
  }

  void _onSelectedTask(Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task))
    );
  }

  void _onAddTask() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskFormScreen(project: widget.project))
    ).then((value) => {
      Provider.of<TaskViewModel>(context, listen: false).getTasks(widget.project.id)
    });
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Task>> taskData = Provider.of<TaskViewModel>(context).baseData;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task.name),
                                const SizedBox(height: 4.0),
                                Text(TaskStatus.getStatus(task.statusValue)?.displayName ?? "-")
                              ]
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddTask(),
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
