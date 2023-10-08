import 'package:flutter/material.dart';
import 'package:friday_hybrid/ui/issues/viewModel/issue_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/base_data.dart';
import '../../../data/local/schemas.dart';
import '../../../data/remote/utils/api_response_utils.dart';
import '../../login/ui/login_screen.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    Provider.of<IssueViewModel>(context, listen: false).getIssues();
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
      Provider.of<IssueViewModel>(context, listen: false).getIssues();
    }
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Issue>> issueData = Provider.of<IssueViewModel>(context).baseData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Issues"),
        backgroundColor: Colors.transparent,
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          issueData.data != null
              ? Expanded(
              child: ListView.builder(
                  itemCount: issueData.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final issue = issueData.data![index];
                    return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(issue.title),
                            Text(issue.statusValue.toString()),
                            Text(issue.deadlineDate.toString())
                          ],
                        )
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
                      if (issueData.errorMessage != null)
                        Text(issueData.errorMessage!),
                      if (issueData.exception is SessionException)
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
