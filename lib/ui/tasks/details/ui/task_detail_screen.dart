import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/tasks/details/viewModel/task_detail_view_model.dart';
import 'package:friday_hybrid/utils/date_utils.dart' as utils;
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
        "Do you want to delete this task ?",
        () => {
          Provider.of<TaskDetailViewModel>(context, listen: false).delete(widget.task.id).then((value) => {
            if (value != null) {
              if (value.data != null) {
                Navigator.pop(context)
              } else if (value.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.errorMessage ?? 'Something wrong')
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
              Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(taskData.data?.name ?? "-",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                if (taskData.data != null && taskData.data!.link != null && taskData.data!.link!.isNotEmpty)
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => DisplayUtils.launchURL(taskData.data!.link!),
                                      icon: const Icon(Icons.open_in_new,
                                        size: 20.0,
                                        color: Colors.blue,
                                      )
                                  )
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Card(
                              color: const Color(0xFF363232),
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                    color: Colors.yellowAccent,
                                    width: 1.0
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                child: Text(TaskStatus.getStatus(taskData.data?.statusValue ?? 0)?.displayName ?? "-",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                const Text("Created on",
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                Text(utils.DateUtils.formatToDisplayString(taskData.data?.created ?? DateTime.now()),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Task Notes",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(taskData.data?.notes ?? "-")
                          ],
                        ),
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      if (activities.isNotEmpty)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Activities",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: activities.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        TaskActivity activity = activities[index];
                                        final oldStatus = TaskStatus.getStatus(activity.oldStatusValue);
                                        final newStatus = TaskStatus.getStatus(activity.newStatusValue);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(utils.DateUtils.formatToDisplayString(activity.created, format: "dd MMM yyyy, hh.mm"),
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(height: 4),
                                              Text("${oldStatus!.displayName} > ${newStatus!.displayName}")
                                            ],
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  )
              ),
              if (taskData.errorMessage != null)
                Flexible(
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
