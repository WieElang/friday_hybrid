import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/ui/issues/details/viewModel/issue_detail_view_model.dart';
import 'package:friday_hybrid/ui/issues/form/viewModel/issue_form_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../data/local/schemas.dart';

class IssueFormScreen extends StatefulWidget {
  final Issue issue;
  const IssueFormScreen({super.key, required this.issue});

  @override
  State<IssueFormScreen> createState() => _IssueFormScreenState();
}

class _IssueFormScreenState extends State<IssueFormScreen> {
  IssueStatus? selectedStatus;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    selectedStatus = IssueStatus.getStatus(widget.issue.statusValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: const Text("Edit Issue"),
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
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text("Status"),
                          const SizedBox(height: 4),
                          Card(
                            child: DropdownMenu<IssueStatus>(
                              initialSelection: selectedStatus,
                              dropdownMenuEntries: IssueStatus.values.map<DropdownMenuEntry<IssueStatus>>((IssueStatus value) {
                                return DropdownMenuEntry<IssueStatus>(
                                    value: value,
                                    label: value.displayName
                                );
                              }).toList(),
                              onSelected: (IssueStatus? value) {
                                setState(() {
                                  if (value != null) {
                                    selectedStatus = value;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
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
                            Provider.of<IssueFormViewModel>(context, listen: false).edit(widget.issue.id, selectedStatus!.value).then((value) => {
                              if (value != null) {
                                if (value.data != null) {
                                  Navigator.pop(context),
                                  Provider.of<IssueDetailViewModel>(context, listen: false).getIssue(widget.issue.id)
                                } else if (value.errorMessage != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(value.errorMessage ?? 'Something wrong'),
                                  ))
                                }
                              }
                            });
                          },
                          child: const Text(
                            "Edit Issue",
                            style: TextStyle(
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
