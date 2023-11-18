import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/home/viewModel/home_view_model.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:friday_hybrid/ui/tasks/index/ui/task_screen.dart';
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
    Provider.of<HomeViewModel>(context, listen: false).getUser();
    Provider.of<HomeViewModel>(context, listen: false).getProjects();
  }

  void _onSelectedProject(Project project) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskScreen(project: project))
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<HomeViewModel>(context).user;
    BaseData<List<Project>> projectData = Provider.of<HomeViewModel>(context).baseData;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Row(
                    children: [
                      const Text("Hi, ", style: TextStyle(fontSize: 14.0)),
                      Text(
                        "${user?.name ?? "Guest"}!",
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.orange
                        ),
                      )
                    ],
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
                    projectData.data != null
                        ? Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Projects",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text("${projectData.data?.length ?? 0} active projects",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 14.0),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: projectData.data!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        Project project = projectData.data![index];
                                        return InkWell(
                                          onTap: () => _onSelectedProject(project),
                                          child: Card(
                                              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                              color: const Color(0xFF363232),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                                                child: Text(project.name),
                                              )
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                              child: Text('No Data'),
                            ),
                        ),
                  ],
                ),
              ),
              if (projectData.errorMessage != null || projectData.exception is SessionException)
                Flexible(
                  child: Center(
                    child: Column(
                      children: [
                        if (projectData.errorMessage != null)
                          Text(projectData.errorMessage!),
                        if (projectData.exception is SessionException)
                          ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginScreen())
                                ).then((value) => {
                                  Provider.of<HomeViewModel>(context, listen: false).getProjects()
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
        ),
      ),
    );
  }
}
