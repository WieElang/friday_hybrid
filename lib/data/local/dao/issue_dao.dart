import 'package:friday_hybrid/data/local/dao/issue_activity_dao.dart';
import 'package:friday_hybrid/data/local/dao/issue_checklist_dao.dart';
import 'package:friday_hybrid/data/local/dao/project_dao.dart';
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

  static Issue? getById(Realm realm, int id) {
    return realm.query<Issue>('id == $id').firstOrNull;
  }

  static RealmResults<Issue> getByProject(Realm realm, int projectId) {
    return realm.query<Issue>('project.id == $projectId');
  }

  static void fromApiModels(IssueListApiModel issueListApiModel) {
    final realm = realmInstance;

    List<int> issueIds = [];
    List<int> projectIds = [];
    for (final issueApiModel in issueListApiModel.issues) {
      issueIds.add(issueApiModel.id);
      projectIds.add(issueApiModel.projectId);
    }

    final existingIssues = getByIds(realm, issueIds);
    Map<int, Issue> existingIssueMapping = { for (var issue in existingIssues) issue.id : issue };

    final existingProjects = ProjectDao.getByIds(realm, projectIds);
    Map<int, Project> existingProjectMapping = { for (var project in existingProjects) project.id : project };

    realm.writeAsync(() {
      for (final issueApiModel in issueListApiModel.issues) {
        final existingIssue = existingIssueMapping[issueApiModel.id];
        final existingProject = existingProjectMapping[issueApiModel.projectId];
        if (existingIssue != null) {
          _updateFromApiModel(existingIssue, issueApiModel, existingProject);
        } else {
          realm.add(_createFromApiModel(issueApiModel, existingProject));
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

  static void fromApiModel(IssueApiModel issueApiModel) {
    final realm = realmInstance;

    realm.writeAsync(() {
      final existingIssue = IssueDao.getById(realm, issueApiModel.id);
      final existingProject = ProjectDao.getById(realm, issueApiModel.projectId);

      if (existingIssue != null) {
        _updateFromApiModel(existingIssue, issueApiModel, existingProject);
      } else {
        realm.add(_createFromApiModel(issueApiModel, existingProject));
      }

      if (issueApiModel.checklists != null) {
        IssueChecklistDao.fromApiModels(issueApiModel.checklists!);
      }

      if (issueApiModel.activities != null) {
        IssueActivityDao.fromApiModels(issueApiModel.activities!);
      }
    });
  }

  static Issue _createFromApiModel(IssueApiModel issueApiModel, Project? project) => Issue(
      issueApiModel.id,
      issueApiModel.creatorName,
      issueApiModel.title,
      description: issueApiModel.description,
      link: issueApiModel.link,
      issueApiModel.status,
      issueApiModel.priority,
      deadlineDate: DateUtils.getDateTimeFromString(issueApiModel.deadlineDate),
      DateUtils.getDateTimeFromString(issueApiModel.created)!,
      project: project
  );

  static Issue _updateFromApiModel(Issue existingIssue, IssueApiModel issueApiModel, Project? project) {
    existingIssue.id = issueApiModel.id;
    existingIssue.creatorName = issueApiModel.creatorName;
    existingIssue.title = issueApiModel.title;
    existingIssue.description = issueApiModel.description;
    existingIssue.link = issueApiModel.link;
    existingIssue.statusValue = issueApiModel.status;
    existingIssue.priorityValue = issueApiModel.priority;
    existingIssue.deadlineDate = DateUtils.getDateTimeFromString(issueApiModel.deadlineDate);
    existingIssue.created = DateUtils.getDateTimeFromString(issueApiModel.created)!;
    existingIssue.project = project;
    return existingIssue;
  }
}