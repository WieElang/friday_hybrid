import 'package:friday_hybrid/data/local/dao/issue_dao.dart';
import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';
import 'package:realm/realm.dart';

import '../realm_database_helper.dart';
import '../schemas.dart';

class IssueChecklistDao {
  static RealmResults<IssueChecklist> getAll(Realm realm) {
    return realm.all<IssueChecklist>();
  }

  static RealmResults<IssueChecklist> getByIds(Realm realm, List<int> ids) {
    return realm.query<IssueChecklist>('id IN {${ids.join(", ")}}');
  }

  static void fromApiModels(IssueChecklistListApiModel issueChecklistListApiModel) {
    final realm = realmInstance;

    List<int> checklistIds = [];
    List<int> issueIds = [];
    for (final issueChecklistApiModel in issueChecklistListApiModel.checklists) {
      checklistIds.add(issueChecklistApiModel.id);
      issueIds.add(issueChecklistApiModel.issueId);
    }

    final existingChecklists = getByIds(realm, checklistIds);
    Map<int, IssueChecklist> existingChecklistMapping = { for (var checklist in existingChecklists) checklist.id: checklist };

    final existingIssues = IssueDao.getByIds(realm, issueIds);
    Map<int, Issue> existingIssueMapping = { for (var issue in existingIssues) issue.id : issue };

    realm.writeAsync(() {
      for (final issueChecklistApiModel in issueChecklistListApiModel.checklists) {
        final existingChecklist = existingChecklistMapping[issueChecklistApiModel.id];
        final existingIssue = existingIssueMapping[issueChecklistApiModel.issueId];
        if (existingChecklist != null) {
          _updateFromApiModel(existingChecklist, issueChecklistApiModel, existingIssue);
        } else {
          realm.add(_createFromApiModel(issueChecklistApiModel, existingIssue));
        }
      }
    });
  }

  static IssueChecklist _createFromApiModel(IssueChecklistApiModel issueChecklistApiModel, Issue? issue) {
    return IssueChecklist(
        issueChecklistApiModel.id,
        issueChecklistApiModel.name,
        issueChecklistApiModel.description,
        issueChecklistApiModel.isChecked,
        issue: issue
    );
  }

  static IssueChecklist _updateFromApiModel(IssueChecklist existingChecklist, IssueChecklistApiModel issueChecklistApiModel, Issue? issue) {
    existingChecklist.id = issueChecklistApiModel.id;
    existingChecklist.name = issueChecklistApiModel.name;
    existingChecklist.description = issueChecklistApiModel.description;
    existingChecklist.isChecked = issueChecklistApiModel.isChecked;
    existingChecklist.issue = issue;
    return existingChecklist;
  }
}