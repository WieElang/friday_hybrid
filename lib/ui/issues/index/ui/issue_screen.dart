import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/ui/issues/details/ui/issue_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';
import '../../../../data/remote/utils/api_response_utils.dart';
import '../../../login/ui/login_screen.dart';
import '../../form/ui/issue_form_screen.dart';
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

  void _onEditIssue(Issue issue) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IssueFormScreen(issue: issue))
    );
  }

  @override
  Widget build(BuildContext context) {
    BaseData<List<Issue>> issueData = Provider.of<IssueViewModel>(context).baseData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Issues",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600
            )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Column(
              children: [
                issueData.data != null
                    ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListView.builder(
                          itemCount: issueData.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final issue = issueData.data![index];
                            return InkWell(
                              onTap: () => _onSelectedIssue(issue),
                              onLongPress: () => _onEditIssue(issue),
                              child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TaskStatus.getStatus(issue.statusValue)?.displayName ?? "-",
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          issue.title,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            );
                          }
                      ),
                    ))
                    : const Center(child: Text('No Data')),
              ],
            ),
          ),
          Flexible(
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
        ],
      ),
    );
  }
}
