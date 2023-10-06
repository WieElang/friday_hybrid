import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/ui/home/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/local/schemas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).getProjects();
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Project>> projectData = Provider.of<HomeViewModel>(context).baseData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
                    return Text(projectData.data![index].name);
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
