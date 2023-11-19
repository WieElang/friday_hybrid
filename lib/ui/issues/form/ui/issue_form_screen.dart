import 'package:flutter/material.dart';
import 'package:friday_hybrid/core/enums.dart';
import 'package:friday_hybrid/ui/issues/details/viewModel/issue_detail_view_model.dart';
import 'package:friday_hybrid/ui/issues/form/viewModel/issue_form_view_model.dart';
import 'package:friday_hybrid/utils/display_utils.dart';
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
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
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
              children: [
                Flexible(
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
                              Text(widget.issue.project?.name ?? "Project",
                                style: const TextStyle(
                                  fontSize: 12.0
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(widget.issue.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0
                                ),
                              ),
                              const SizedBox(height: 25),
                              const Text("Status"),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: double.infinity,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: selectedStatus,
                                        items: IssueStatus.values.map<DropdownMenuItem<IssueStatus>>((IssueStatus item) {
                                          return DropdownMenuItem<IssueStatus>(
                                              value: item,
                                              child: Text(item.displayName)
                                          );
                                        }).toList(),
                                        onChanged: (IssueStatus? value) {
                                          setState(() {
                                            if (value != null) {
                                              selectedStatus = value;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: double.infinity,
          height: 45.0,
          margin: const EdgeInsets.all(16.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )
              ),
              onPressed: () {
                Provider.of<IssueFormViewModel>(context, listen: false).edit(widget.issue.id, selectedStatus!.value).then((value) => {
                  if (value != null) {
                    if (value.data != null) {
                      Provider.of<IssueDetailViewModel>(context, listen: false).getIssue(widget.issue.id),
                      DisplayUtils.showAlert(context,
                          "Edit Issue",
                          "Issue edited successfully",
                          () => { Navigator.pop(context) }
                      )
                    } else if (value.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(value.errorMessage ?? 'Something wrong'),
                      ))
                    }
                  }
                });
              },
              child: const Text(
                "Edit",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14.0
                ),
              )
          ),
        ),
    );
  }
}
