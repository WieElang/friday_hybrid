import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/home/viewModel/home_view_model.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/local/schemas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();

    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      Provider.of<HomeViewModel>(context, listen: false).getProjects();
    }
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
                      return Card(
                        child: Text(projectData.data![index].name)
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
                    if (projectData.errorMessage != null)
                      Text(projectData.errorMessage!),
                    if (projectData.exception is SessionException)
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
    );
  }
}
