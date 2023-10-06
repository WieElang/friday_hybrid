import 'package:friday_hybrid/data/local/dao/task_dao.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:realm/realm.dart';

import '../../../utils/date_utils.dart';
import '../realm_database_helper.dart';
import '../schemas.dart';

class CommentDao {
  static RealmResults<Comment> getAll(Realm realm) {
    return realm.all<Comment>();
  }

  static RealmResults<Comment> getByIds(Realm realm, List<int> ids) {
    return realm.query<Comment>('id IN {${ids.join(", ")}}');
  }

  static void fromApiModels(CommentListApiModel commentListApiModel) {
    final realm = realmInstance;

    List<int> commentIds = [];
    List<int> taskIds = [];
    for (final commentApiModel in commentListApiModel.comments) {
      commentIds.add(commentApiModel.id);
      taskIds.add(commentApiModel.taskId);
    }

    final existingComments = getByIds(realm, commentIds);
    Map<int, Comment> existingCommentMapping = { for (var comment in existingComments) comment.id: comment };

    final existingTasks = TaskDao.getByIds(realm, taskIds);
    Map<int, Task> existingTaskMapping = { for (var task in existingTasks) task.id : task };

    realm.writeAsync(() {
      for (final commentApiModel in commentListApiModel.comments) {
        final existingComment = existingCommentMapping[commentApiModel.id];
        final existingTask = existingTaskMapping[commentApiModel.taskId];
        if (existingComment != null) {
          _updateFromApiModel(existingComment, commentApiModel, existingTask);
        } else {
          realm.add(_createFromApiModel(commentApiModel, existingTask));
        }
      }
    });
  }

  static Comment _createFromApiModel(CommentApiModel commentApiModel, Task? task) {
    return Comment(
        commentApiModel.id,
        commentApiModel.userName,
        commentApiModel.message,
        DateUtils.getDateTimeFromString(commentApiModel.created),
        task: task
    );
  }

  static Comment _updateFromApiModel(Comment existingComment, CommentApiModel commentApiModel, Task? task) {
    existingComment.id = commentApiModel.id;
    existingComment.userName = commentApiModel.userName;
    existingComment.message = commentApiModel.message;
    existingComment.created = DateUtils.getDateTimeFromString(commentApiModel.created);
    existingComment.task = task;
    return existingComment;
  }
}