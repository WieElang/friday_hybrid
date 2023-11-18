import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/issues/details/viewModel/issue_detail_view_model.dart';
import 'package:friday_hybrid/ui/issues/form/ui/issue_form_screen.dart';
import 'package:friday_hybrid/ui/login/ui/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:friday_hybrid/utils/date_utils.dart' as utils;
import '../../../../utils/display_utils.dart';

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

  void _onEditIssue() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IssueFormScreen(issue: widget.issue))
    );
  }

  void _onCheckEditTask(int checklistId) {
    Provider.of<IssueDetailViewModel>(context, listen: false).editChecklist(checklistId).then((value) => {
      Provider.of<IssueDetailViewModel>(context, listen: false).getIssue(widget.issue.id)
    });
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
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: false,
                    floating: true,
                    snap: true,
                    expandedHeight: 0.0,
                    forceElevated: innerBoxIsScrolled,
                    actions: [
                      IconButton(
                          onPressed: () => _onEditIssue(),
                          icon: const Icon(Icons.edit,
                            color: Colors.orange,
                          )
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: Column(
              children: <Widget>[
                Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(issueData.data?.project?.name ?? "Project",
                                style: const TextStyle(
                                    fontSize: 12.0
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(issueData.data?.title ?? "-",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  if (issueData.data != null && issueData.data!.link != null && issueData.data!.link!.isNotEmpty)
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () => DisplayUtils.launchURL(issueData.data!.link!),
                                        icon: const Icon(Icons.open_in_new,
                                          size: 20.0,
                                          color: Colors.blue,
                                        )
                                    )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Card(
                                    color: Colors.orangeAccent,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.remove,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(IssuePriority.getPriority(issueData.data?.priorityValue ?? 0)?.displayName ?? "-",
                                            style: const TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Card(
                                    color: const Color(0xFF363232),
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: const BorderSide(
                                          color: Color(0xFFC7D6FF),
                                          width: 1.0
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                      child: Text(IssueStatus.getStatus(issueData.data?.statusValue ?? 0)?.displayName ?? "-",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  const Text("Created on",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(utils.DateUtils.formatToDisplayString(issueData.data?.created ?? DateTime.now()),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  const Text("Due on",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(utils.DateUtils.formatToDisplayString(issueData.data?.deadlineDate ?? DateTime.now()),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(thickness: 1, color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Issue Detail",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(issueData.data?.description ?? "-")
                            ],
                          ),
                        ),
                        if (checklists.isNotEmpty)
                          Flexible(
                            child: Column(
                              children: [
                                const Divider(thickness: 1, color: Colors.grey),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Checklists",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Flexible(
                                          child: ListView.builder(
                                              itemCount: activities.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                IssueChecklist checklist = checklists[index];
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                          checkColor: Colors.white,
                                                          activeColor: Colors.green,
                                                          visualDensity: VisualDensity.compact,
                                                          value: checklist.isChecked,
                                                          onChanged: (bool? isChecked) => _onCheckEditTask(checklist.id)
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Text(checklist.name ?? "-",
                                                        style: const TextStyle(fontSize: 14),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (activities.isNotEmpty)
                          Flexible(
                            child: Column(
                              children: [
                                const Divider(thickness: 1, color: Colors.grey),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Activities",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Flexible(
                                          child: ListView.builder(
                                              itemCount: activities.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                IssueActivity activity = activities[index];
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(utils.DateUtils.formatToDisplayString(activity.created, format: "dd MMM yyyy, hh.mm"),
                                                        style: const TextStyle(fontSize: 12),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(activity.message ?? "-",
                                                        style: const TextStyle(fontSize: 14),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text("Changes by ${activity.userName ?? "-"}",
                                                        style: const TextStyle(fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
