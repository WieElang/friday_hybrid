import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/ui/tasks/details/viewModel/task_detail_view_model.dart';
import 'package:friday_hybrid/ui/tasks/form/viewModel/task_form_view_model.dart';
import 'package:friday_hybrid/ui/tasks/index/viewModel/task_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../data/local/schemas.dart';

class TaskFormScreen extends StatefulWidget {
  final Project project;
  final Task? task;
  const TaskFormScreen({super.key, required this.project, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  bool isInitialized = false;

  Issue? _selectedIssue;
  TaskStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    Provider.of<TaskFormViewModel>(context, listen: false).getIssues(widget.project.id);
  }

  @override
  Widget build(BuildContext context) {
    final String title;
    List<Issue> issues = Provider.of<TaskFormViewModel>(context).issues;

    if (widget.task != null) {
      title = "Update Task";
      if (!isInitialized) {
        _nameController.text = widget.task!.name;
        _notesController.text = widget.task!.notes ?? "";
        _linkController.text = widget.task!.link ?? "";
        _selectedIssue = widget.task!.issue;
        _selectedStatus = TaskStatus.getStatus(widget.task!.statusValue);
        isInitialized = true;
      }
    } else {
      title = "Add Task";
    }

    return Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: Text(title),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: false,
                    floating: true,
                    snap: true,
                    expandedHeight: 0.0,
                    forceElevated: innerBoxIsScrolled,
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Issue"),
                              const SizedBox(height: 4),
                              Card(
                                child: DropdownMenu<Issue>(
                                  initialSelection: _selectedIssue,
                                  dropdownMenuEntries: issues.map<DropdownMenuEntry<Issue>>((Issue value) {
                                    return DropdownMenuEntry<Issue>(
                                        value: value,
                                        label: value.title
                                    );
                                  }).toList(),
                                  onSelected: (Issue? value) {
                                    setState(() {
                                      if (value != null) {
                                        _selectedIssue = value;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                              labelText: 'Notes'
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _linkController,
                          decoration: const InputDecoration(
                              labelText: 'Link'
                          ),
                        ),
                        if (widget.task != null)
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Text("Status"),
                                const SizedBox(height: 4),
                                Card(
                                  child: DropdownMenu<TaskStatus>(
                                    initialSelection: _selectedStatus,
                                    dropdownMenuEntries: TaskStatus.values.map<DropdownMenuEntry<TaskStatus>>((TaskStatus value) {
                                      return DropdownMenuEntry<TaskStatus>(
                                          value: value,
                                          label: value.displayName
                                      );
                                    }).toList(),
                                    onSelected: (TaskStatus? value) {
                                      setState(() {
                                        if (value != null) {
                                          _selectedStatus = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: double.infinity,
                          height: 45.0,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  )
                              ),
                              onPressed: () {
                                final name = _nameController.text;
                                final notes = _notesController.text;
                                final link = _linkController.text;

                                if (name.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Task name is required'),
                                    ),
                                  );
                                  return;
                                }

                                if (widget.task != null) {
                                  Provider.of<TaskFormViewModel>(context, listen: false).edit(widget.task!.id, widget.project.id, _selectedIssue!.id, name, _selectedStatus!.value, notes: notes, link: link).then((value) => {
                                    if (value != null) {
                                      if (value.data != null) {
                                        Navigator.pop(context),
                                        Provider.of<TaskDetailViewModel>(context, listen: false).getTask(widget.task!.id)
                                      } else if (value.errorMessage != null) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(value.errorMessage ?? 'Something wrong'),
                                        ))
                                      }
                                    }
                                  });
                                } else {
                                  Provider.of<TaskFormViewModel>(context, listen: false).add(widget.project.id, _selectedIssue!.id, name, notes: notes, link: link).then((value) => {
                                    if (value != null) {
                                      if (value.data != null) {
                                        Navigator.pop(context),
                                        Provider.of<TaskViewModel>(context, listen: false).getTasks(widget.project.id)
                                      } else if (value.errorMessage != null) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(value.errorMessage ?? 'Something wrong'),
                                        ))
                                      }
                                    }
                                  });
                                }
                              },
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.0
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
