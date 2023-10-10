import 'package:flutter/material.dart';
import 'package:friday_hybrid/ui/tasks/form/viewModel/task_form_view_model.dart';
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

  @override
  Widget build(BuildContext context) {
    final String title;
    if (widget.task == null) {
      title = "Add Task";
    } else {
      title = "Edit Task";
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
                    elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
                    centerTitle: false,
                    floating: true,
                    snap: true,
                    expandedHeight: 0.0,
                    forceElevated: innerBoxIsScrolled,
                  ),
                ),
              ];
            },
            body: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
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

                            // Provider.of<TaskFormViewModel>(context, listen: false).add(email, password).then((value) => {
                            //   if (value != null) {
                            //     if (value.data != null) {
                            //       Navigator.pop(context)
                            //     } else if (value.errorMessage != null) {
                            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //         content: Text(value.errorMessage ?? 'Something wrong'),
                            //       ))
                            //     }
                            //   }
                            // });
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
          ),
        )
    );
  }
}
