import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';

class UserService {
  UserService._();

  static final UserService _instance = UserService._();

  factory UserService() => _instance;

  late final RestClient _restClient = createAuthenticatedClient();

  /// Fetch batch user infos for [userIds].
  ///
  /// Returns a map keyed by userId (int) to UserInfo. If the API returns
  /// string keys, they will be parsed to int when possible and ignored on parse error.
  ///
  /// Note: this method will not swallow exceptions; callers should handle
  /// network/auth errors according to app-wide conventions.
  Future<Map<int, UserInfo>> fetchBatchUserInfos(List<int> userIds) async {
    final body = GetUsernamesRequest(userIds: userIds);
    final resp = await _restClient.fallback
        .getBatchUserInfosApiV2LowAdminApiUserV2BatchUserInfosPost(body: body);

    final Map<int, UserInfo> result = <int, UserInfo>{};

    if (resp.isSuccess == true && resp.result != null) {
      resp.result!.forEach((key, value) {
        try {
          final intKey = int.parse(key);
          result[intKey] = value;
        } catch (_) {
          // ignore keys that cannot be parsed to int
        }
      });
    }

    return result;
  }

  /// Compute Gravatar URL for [email]. Returns null if [email] is null or empty.
  ///
  /// Uses MD5 of trimmed lower-cased email and returns a URL with size [size]
  /// and default identicon.
  String? gravatarUrlForEmail(String? email, {int size = 80}) {
    if (email == null) return null;
    final trimmed = email.trim().toLowerCase();
    if (trimmed.isEmpty) return null;

    final bytes = utf8.encode(trimmed);
    final digest = md5.convert(bytes).toString();
    return 'https://www.gravatar.com/avatar/$digest?s=$size&d=identicon';
  }
}
