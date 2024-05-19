import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';
import 'package:friday_hybrid/data/remote/services/issue_api_service.dart';

import '../../../../data/remote/api_response.dart';


class IssueFormViewModel with ChangeNotifier {
  Future<ApiResponse<IssueApiModel>?> edit(int issueId, int status) async {
    return await IssueApiService.editStatus(issueId, status);
  }
}
