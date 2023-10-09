import 'dart:convert';

import 'package:friday_hybrid/core/session.dart';
import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiUtils {
  static dynamic createGetRequest(String url, {Map<String, dynamic>? params, bool isUseToken = false}) async {
    Map<String, dynamic> paramsData = params ?? {};
    if (isUseToken) {
      paramsData['token'] = ApiConstants.apiToken;
    } else {
      String? sessionKey = await Session.getSessionKey();
      if (sessionKey != null && sessionKey.isNotEmpty) {
        paramsData['session_key'] = sessionKey;
      }
    }

    final uri = Uri.http(ApiConstants.baseUrl, url, paramsData.map((key, value) => MapEntry(key, value.toString())));
    return await http.get(uri);
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