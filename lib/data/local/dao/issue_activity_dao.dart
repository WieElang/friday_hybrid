import 'package:friday_hybrid/data/local/dao/issue_dao.dart';
import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';
import 'package:realm/realm.dart';

import '../../../utils/date_utils.dart';
import '../realm_database_helper.dart';
import '../schemas.dart';

class IssueActivityDao {
  static RealmResults<IssueActivity> getAll(Realm realm) {
    return realm.all<IssueActivity>();
  }

  static RealmResults<IssueActivity> getByIds(Realm realm, List<int> ids) {
    return realm.query<IssueActivity>('id IN {${ids.join(", ")}}');
  }

  static void fromApiModels(IssueActivityListApiModel issueActivityListApiModel) {
    final realm = realmInstance;

    List<int> activityIds = [];
    List<int> issueIds = [];
    for (final issueActivityApiModel in issueActivityListApiModel.activities) {
      activityIds.add(issueActivityApiModel.id);
      issueIds.add(issueActivityApiModel.issueId);
    }

    final existingActivities = getByIds(realm, activityIds);
    Map<int, IssueActivity> existingActivityMapping = { for (var activity in existingActivities) activity.id: activity };

    final existingIssues = IssueDao.getByIds(realm, issueIds);
    Map<int, Issue> existingIssueMapping = { for (var issue in existingIssues) issue.id : issue };

    realm.writeAsync(() {
      for (final issueActivityApiModel in issueActivityListApiModel.activities) {
        final existingActivity = existingActivityMapping[issueActivityApiModel.id];
        final existingIssue = existingIssueMapping[issueActivityApiModel.issueId];
        if (existingActivity != null) {
          _updateFromApiModel(existingActivity, issueActivityApiModel, existingIssue);
        } else {
          realm.add(_createFromApiModel(issueActivityApiModel, existingIssue));
        }
      }
    });
  }

  static IssueActivity _createFromApiModel(IssueActivityApiModel issueActivityApiModel, Issue? issue) {
    return IssueActivity(
        issueActivityApiModel.id,
        issueActivityApiModel.userName,
        message: issueActivityApiModel.message,
        DateUtils.getDateTimeFromString(issueActivityApiModel.created)!,
        issue: issue
    );
  }

  static IssueActivity _updateFromApiModel(IssueActivity existingActivity, IssueActivityApiModel issueActivityApiModel, Issue? issue) {
    existingActivity.id = issueActivityApiModel.id;
    existingActivity.message = issueActivityApiModel.message;
    existingActivity.userName = issueActivityApiModel.userName;
    existingActivity.created = DateUtils.getDateTimeFromString(issueActivityApiModel.created)!;
    existingActivity.issue = issue;
    return existingActivity;
  }
}