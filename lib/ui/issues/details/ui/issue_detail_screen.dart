import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/issues/details/viewModel/issue_detail_view_model.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:provider/provider.dart';

class IssueDetailScreen extends StatefulWidget {
  final Issue issue;
  const IssueDetailScreen({super.key, required this.issue});

  @override
  State<IssueDetailScreen> createState() => _IssueDetailScreenState();
}

class _IssueDetailScreenState extends State<IssueDetailScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    Provider.of<IssueDetailViewModel>(context, listen: false).getIssue(widget.issue.id);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<IssueDetailViewModel>(context, listen: false).getIssue(widget.issue.id);
    }
  }

  void _onEditTask() {
    print('edit');
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => TaskFormScreen(project: widget.task.project!, task: widget.task))
    // );
  }

  void _onCheckEditTask(bool? isChecked) {
    print(isChecked.toString());
  }

  @override
  Widget build(BuildContext context) {
    BaseData<Issue> issueData = Provider.of<IssueDetailViewModel>(context).issueData;
    List<IssueChecklist> checklists = Provider.of<IssueDetailViewModel>(context).checklists;
    List<IssueActivity> activities = Provider.of<IssueDetailViewModel>(context).activities;

    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: const Text("Issue Detail"),
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
            body: Column(
              children: <Widget>[
                Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    issueData.data?.title ?? "-",
                                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Card(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                          child: Text(issueData.data?.statusValue.toString() ?? "-")
                                      )
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(issueData.data?.description ?? "-"),
                                  const SizedBox(height: 16.0),
                                  Text("Related Link: ${issueData.data?.link ?? "-"}"),
                                  const SizedBox(height: 24.0),
                                  Text("Created: ${issueData.data?.created.toString()}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (checklists.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 16.0),
                              const Text(
                                "Checklists",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: checklists.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      IssueChecklist checklist = checklists[index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                  value: false,
                                                  onChanged: (bool? isChecked) => _onCheckEditTask(isChecked)
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    checklist.name ?? "-",
                                                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 4.0),
                                                  Text(checklist.description ?? "-")
                                                ],
                                              )
                                            ],
                                          )
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        if (activities.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 16.0),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: activities.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      IssueActivity activity = activities[index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(activity.message ?? "-"),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                ),
                if (issueData.errorMessage != null)
                  Expanded(
                      child: Center(
                        child: Column(
                            children: [
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
                                )]),
                      )
                  )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onEditTask(),
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
