import 'package:friday_hybrid/data/local/dao/issue_activity_dao.dart';
import 'package:friday_hybrid/data/local/dao/issue_checklist_dao.dart';
import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';
import 'package:realm/realm.dart';

import '../../../utils/date_utils.dart';
import '../realm_database_helper.dart';
import '../schemas.dart';

class IssueDao {
  static RealmResults<Issue> getAll(Realm realm) {
    return realm.all<Issue>();
  }

  static RealmResults<Issue> getByIds(Realm realm, List<int> ids) {
    return realm.query<Issue>('id IN {${ids.join(", ")}}');
  }

  static void fromApiModels(IssueListApiModel issueListApiModel) {
    final realm = realmInstance;

    List<int> issueIds = [];
    for (final issueApiModel in issueListApiModel.issues) {
      issueIds.add(issueApiModel.id);
    }

    final existingIssues = getByIds(realm, issueIds);
    Map<int, Issue> existingIssueMapping = { for (var issue in existingIssues) issue.id : issue };
    realm.writeAsync(() {
      for (final issueApiModel in issueListApiModel.issues) {
        final existingIssue = existingIssueMapping[issueApiModel.id];
        if (existingIssue != null) {
          _updateFromApiModel(existingIssue, issueApiModel);
        } else {
          realm.add(_createFromApiModel(issueApiModel));
        }

        if (issueApiModel.checklists != null) {
          IssueChecklistDao.fromApiModels(issueApiModel.checklists!);
        }

        if (issueApiModel.activities != null) {
          IssueActivityDao.fromApiModels(issueApiModel.activities!);
        }
      }
    });
  }

  static Issue _createFromApiModel(IssueApiModel issueApiModel) => Issue(
      issueApiModel.id,
      issueApiModel.creatorName,
      issueApiModel.title,
      issueApiModel.description,
      issueApiModel.link,
      issueApiModel.status,
      issueApiModel.priority,
      DateUtils.getDateTimeFromString(issueApiModel.deadlineDate),
      DateUtils.getDateTimeFromString(issueApiModel.created)
  );

  static Issue _updateFromApiModel(Issue existingIssue, IssueApiModel issueApiModel) {
    existingIssue.id = issueApiModel.id;
    existingIssue.creatorName = issueApiModel.creatorName;
    existingIssue.title = issueApiModel.title;
    existingIssue.description = issueApiModel.description;
    existingIssue.link = issueApiModel.link;
    existingIssue.statusValue = issueApiModel.status;
    existingIssue.priorityValue = issueApiModel.priority;
    existingIssue.deadlineDate = DateUtils.getDateTimeFromString(issueApiModel.deadlineDate);
    existingIssue.created = DateUtils.getDateTimeFromString(issueApiModel.created);
    return existingIssue;
  }
}