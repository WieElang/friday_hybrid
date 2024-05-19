import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/local/dao/issue_activity_dao.dart';
import 'package:friday_hybrid/data/local/dao/issue_checklist_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/repository/issue_repository.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';
import '../../../../data/remote/api_response.dart';
import '../../../../data/remote/services/issue_api_service.dart';


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

  Future<ApiResponse<BaseStatusApiModel>?> editChecklist(int checklistId) async {
    return await IssueApiService.editChecklist(checklistId);
  }
}
