import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/ui/workspace/viewModel/workspace_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/local/models/project.dart';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({super.key});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<WorkspaceViewModel>(context, listen: false).getProjects();
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Project>> projectData = Provider.of<WorkspaceViewModel>(context).baseData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workspace"),
        backgroundColor: Colors.transparent,
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          projectData.data != null
          ? Expanded(
              child: ListView.builder(
                itemCount: projectData.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Text(projectData.data![index].name),
                  );
                }
              )
          )
          : const Expanded(child: Center(
                child: Text('No Data'),
          )),
          if (projectData.errorMessage != null)
            Expanded(child: Center(
              child: Text(projectData.errorMessage!),
            ))
        ],
      ),
    );
  }
}
