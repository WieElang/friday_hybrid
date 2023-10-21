import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/ui/issues/details/ui/issue_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';
import '../../../../data/remote/utils/api_response_utils.dart';
import '../../../login/ui/login_screen.dart';
import '../viewModel/issue_view_model.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<IssueViewModel>(context, listen: false).getIssues();
  }

  void _onSelectedIssue(Issue issue) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IssueDetailScreen(issue: issue))
    );
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
                    return InkWell(
                      onTap: () => _onSelectedIssue(issue),
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(issue.title),
                                const SizedBox(height: 4.0),
                                Text("Status: ${IssueStatus.getStatus(issue.statusValue)?.displayName ?? "-"}"),
                                const SizedBox(height: 4.0),
                                Text("Priority: ${IssuePriority.getPriority(issue.priorityValue)?.displayName ?? "-"}"),
                                const SizedBox(height: 12.0),
                                Text(issue.deadlineDate.toString())
                              ],
                            ),
                          )
                      ),
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
                              ).then((value) => {
                                Provider.of<IssueViewModel>(context, listen: false).getIssues()
                              })
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
