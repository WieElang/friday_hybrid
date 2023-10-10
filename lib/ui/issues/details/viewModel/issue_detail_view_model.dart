import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/local/dao/issue_activity_dao.dart';
import 'package:friday_hybrid/data/local/dao/issue_checklist_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/repository/issue_repository.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';


class IssueDetailViewModel with ChangeNotifier {
  BaseData<Issue> _issueData = BaseData(null, null, exception: null);
  BaseData<Issue> get issueData {
    return _issueData;
  }

  List<IssueActivity> _activities = [];
  List<IssueActivity> get activities {
    return _activities;
  }

  List<IssueChecklist> _checklists = [];
  List<IssueChecklist> get checklists {
    return _checklists;
  }

  void getIssue(int issueId) async {
    _issueData = await IssueRepository().getIssue(issueId);
    if (_issueData.data != null) {
      final realm = realmInstance;
      final issue = _issueData.data!;
      final issueChecklists = IssueChecklistDao.getByIssue(realm, issue.id);
      _checklists = issueChecklists.toList();

      final issueActivities = IssueActivityDao.getByIssue(realm, issue.id);
      _activities = issueActivities.toList();
    } else {
      _checklists = [];
      _activities = [];
    }
    notifyListeners();
  }
}
