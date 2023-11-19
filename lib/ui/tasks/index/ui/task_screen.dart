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

  void _onSelectedTask(Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task))
    ).then((value) => {
      setState(() {
        Provider.of<TaskViewModel>(context, listen: false).getTasks(widget.project.id);
      })
    });
  }

  void _onEditTask(Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskFormScreen(project: widget.project, task: task))
    ).then((value) => {
      setState(() {
        Provider.of<TaskViewModel>(context, listen: false).getTasks(widget.project.id);
      })
    });
  }

  void _onAddTask() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskFormScreen(project: widget.project))
    ).then((value) => {
      setState(() {
        Provider.of<TaskViewModel>(context, listen: false).getTasks(widget.project.id);
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Task>> taskData = Provider.of<TaskViewModel>(context).baseData;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Text(widget.project.name,
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                      )
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: false,
                  floating: true,
                  snap: true,
                  expandedHeight: 0.0,
                  forceElevated: innerBoxIsScrolled,
                  actions: const [],
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              Flexible(
                child: Column(
                  children: [
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Tasks",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text("${taskData.data?.length ?? 0} active tasks",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  OutlinedButton(
                                    onPressed: () => _onAddTask(),
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                        ),
                                        side: const BorderSide(
                                            color: Colors.orange,
                                            width: 1.0
                                        )
                                    ),
                                    child: const Text(
                                      "Add Task",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 14.0),
                              taskData.data != null && taskData.data!.isNotEmpty
                                ? Flexible(
                                    child: ListView.builder(
                                        itemCount: taskData.data!.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          Task task = taskData.data![index];
                                          return InkWell(
                                            onTap: () => _onSelectedTask(task),
                                            onLongPress: () => _onEditTask(task),
                                            child: Card(
                                                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                                color: const Color(0xFF363232),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          TaskStatus.getStatus(task.statusValue)?.displayName ?? "-",
                                                          style: const TextStyle(
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2.0),
                                                        Text(
                                                          task.name,
                                                          style: const TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight: FontWeight.w600
                                                          ),
                                                        ),
                                                      ]
                                                  ),
                                                )
                                            ),
                                          );
                                        }
                                    ),
                                  )
                                : const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                      child: Text('No Data')
                                  ),
                                ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
              if (taskData.errorMessage != null || taskData.exception is SessionException)
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
                                  )
                                },
                                child: const Text('Login Again')
                            )
                        ],
                      )
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
