import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/tasks/details/viewModel/task_detail_view_model.dart';
import 'package:friday_hybrid/utils/display_utils.dart';
import 'package:provider/provider.dart';

import '../../form/ui/task_form_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    Provider.of<TaskDetailViewModel>(context, listen: false).getTask(widget.task.id);
  }

  void _onEditTask() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskFormScreen(project: widget.task.project!, task: widget.task))
    );
  }

  void _onDeleteTask() {
    DisplayUtils.showAlert(
        context,
        "Delete Task",
        "Do you want to delete this task ?", () => {
          Provider.of<TaskDetailViewModel>(context, listen: false).delete(widget.task.id).then((value) => {
            if (value != null) {
              if (value.data != null) {
                  Navigator.pop(context)
                } else if (value.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.errorMessage ?? 'Something wrong'),
                ))
              }
            }
          })
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    BaseData<Task> taskData = Provider.of<TaskDetailViewModel>(context).taskData;
    List<TaskActivity> activities = Provider.of<TaskDetailViewModel>(context).activities;
    List<Comment> comments = Provider.of<TaskDetailViewModel>(context).comments;

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text("Task Detail"),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: false,
                  floating: true,
                  snap: true,
                  expandedHeight: 0.0,
                  forceElevated: innerBoxIsScrolled,
                  actions: [
                    IconButton(
                        onPressed: () => _onEditTask(),
                        icon: const Icon(Icons.edit,
                          color: Colors.orange,
                        )
                    ),
                    IconButton(
                        onPressed: () => _onDeleteTask(),
                        icon: const Icon(Icons.delete,
                          color: Colors.redAccent,
                        )
                    )
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  taskData.data?.name ?? "-",
                                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4.0),
                                Card(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                        child: Text(TaskStatus.getStatus(taskData.data?.statusValue ?? 0)?.displayName ?? "-")
                                    )
                                ),
                                const SizedBox(height: 16.0),
                                Text(taskData.data?.notes ?? "-"),
                                const SizedBox(height: 16.0),
                                Text("Related Link: ${taskData.data?.link ?? "-"}"),
                                const SizedBox(height: 24.0),
                                Text("Last Updated: ${taskData.data?.updated.toString()}"),
                                const SizedBox(height: 8.0),
                                Text("Created: ${taskData.data?.created.toString()}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (activities.isNotEmpty)
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 16.0),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: activities.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      TaskActivity activity = activities[index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                              "Changes from ${TaskStatus.getStatus(activity.oldStatusValue)!.displayName} to ${TaskStatus.getStatus(activity.newStatusValue)!.displayName} on ${activity.created.toString()}"
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (comments.isNotEmpty)
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 16.0),
                              const Text(
                                "Comments",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: comments.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      Comment comment = comments[index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                comment.userName,
                                                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(comment.message)
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
              ),
              if (taskData.errorMessage != null)
                Expanded(
                    child: Center(
                      child: Column(
                          children: [
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
                              )]),
                    )
                )
            ],
          ),
        )
      ),
    );
  }
}
