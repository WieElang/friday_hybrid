import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/repository/issue_repository.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';


class IssueViewModel with ChangeNotifier {
  BaseData<List<Issue>> _baseData = BaseData(null, null, exception: null);

  BaseData<List<Issue>> get baseData {
    return _baseData;
  }

  void getIssues() async {
    _baseData = await IssueRepository().getAllData();
    notifyListeners();
  }
}
