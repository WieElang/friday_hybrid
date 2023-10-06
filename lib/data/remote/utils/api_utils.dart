import 'dart:convert';

import 'package:friday_hybrid/core/session.dart';
import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiUtils {
  static dynamic createGetRequest(String url, {Map<String, dynamic>? params, bool isUseToken = false}) async {
    final uri = Uri.http(ApiConstants.baseUrl, url, params);

    String authorization;
    if (isUseToken) {
      authorization = "token ${ApiConstants.apiToken}";
    } else {
      String? sessionKey = await Session.getSessionKey();
      if (sessionKey == null || sessionKey.isEmpty) {
        authorization = "session";
      } else {
        authorization = "session $sessionKey";
      }
    }
    return await http.get(uri,
      headers: {"Authorization": authorization}
    );
  }

  static createPostRequest(String url, {Map? data, bool isUseToken = false}) async {
    final uri = Uri.http(ApiConstants.baseUrl, url, null);
    String? body;
    if (data != null) {
      body = json.encode(data);
    }

    String authorization;
    if (isUseToken) {
      authorization = "token ${ApiConstants.apiToken}";
    } else {
      String? sessionKey = await Session.getSessionKey();
      if (sessionKey == null || sessionKey.isEmpty) {
        authorization = "session";
      } else {
        authorization = "session $sessionKey";
      }
    }
    return await http.post(uri,
        headers: {"Content-Type": "application/json", "Authorization": authorization},
        body: body
    );
  }
}