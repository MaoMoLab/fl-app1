import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/pages/low_admin/widgets/editable_user_old_service_card.dart';
import 'package:fl_app1/pages/low_admin/widgets/editable_user_v2_info_card.dart';
import 'package:flutter/material.dart';

class UserV2Page extends StatefulWidget {
  final int userId;

  const UserV2Page({
    super.key,
    required this.userId,
  });

  @override
  State<UserV2Page> createState() => _UserV2PageState();
}

class _UserV2PageState extends State<UserV2Page> {
  final RestClient _restClient = RestClient(Dio(), baseUrl: kDefaultBaseUrl);

  bool _isLoading = false;
  AdminUserV? _userV2Data;
  AdminOldService? _userOldServiceData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final client = _restClient.fallback;

    final results = await Future.wait<dynamic>([
      client.getUserV2ByUserIdApiV2LowAdminApiUserV2UserIdGet(
        userId: widget.userId,
      ),
      client.getUserOldServiceApiV2LowAdminApiUserOldServiceUserIdGet(
        userId: widget.userId,
      ),
    ]);

    setState(() {
      _isLoading = false;
      _userV2Data =
          (results[0] as WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse)
              .result;
      _userOldServiceData =
          (results[1] as WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse)
              .result;
    });
  }

  Future<bool> _updateUserV2Field(String field, dynamic value) async {
    final client = _restClient.fallback;

    final body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
      email: field == 'email' ? value as String : null,
      userName: field == 'userName' ? value as String : null,
      isEnable: field == 'isEnable' ? value as bool : null,
      telegramId: field == 'telegramId' ? value as int? : null,
      isEmailVerify: field == 'isEmailVerify' ? value as bool : null,
      userAccountExpireIn:
      field == 'userAccountExpireIn' ? value as DateTime : null,
    );

    final response = await client.patchUserV2ApiV2LowAdminApiUserV2UserIdPatch(
      userId: widget.userId,
      body: body,
    );

    if (response.isSuccess == true) {
      await _loadUserData();
      return true;
    }
    return false;
  }

  Future<bool> _updateUserOldServiceField(String field, dynamic value) async {
    final client = _restClient.fallback;

    final currentData = _userOldServiceData;
    if (currentData == null) return false;

    final body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
      ssUploadSize: field == 'ssUploadSize'
          ? value as int
          : currentData.ssUploadSize,
      ssDownloadSize: field == 'ssDownloadSize'
          ? value as int
          : currentData.ssDownloadSize,
      ssBandwidthTotalSize: field == 'ssBandwidthTotalSize'
          ? value as int
          : currentData.ssBandwidthTotalSize,
      ssBandwidthYesterdayUsedSize: field == 'ssBandwidthYesterdayUsedSize'
          ? value as int
          : currentData.ssBandwidthYesterdayUsedSize,
      userLevel: field == 'userLevel' ? value as int : currentData.userLevel,
      userLevelExpireIn: field == 'userLevelExpireIn'
          ? value as DateTime
          : currentData.userLevelExpireIn,
      nodeSpeedLimit:
      field == 'nodeSpeedLimit' ? value as int? : currentData.nodeSpeedLimit,
      nodeConnector:
      field == 'nodeConnector' ? value as int : currentData.nodeConnector,
      autoResetDay:
      field == 'autoResetDay' ? value as int : currentData.autoResetDay,
      autoResetBandwidth: field == 'autoResetBandwidth'
          ? value as num
          : currentData.autoResetBandwidth,
    );

    final response =
    await client.patchUserOldServiceApiV2LowAdminApiUserOldServiceUserIdPatch(
      userId: widget.userId,
      body: body,
    );

    if (response.isSuccess == true) {
      await _loadUserData();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户信息 - ID: ${widget.userId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadUserData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red[700]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadUserData,
              child: const Text('重试'),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadUserData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            EditableUserV2InfoCard(
              userData: _userV2Data,
              onFieldUpdate: _updateUserV2Field,
            ),
            const SizedBox(height: 16),
            EditableUserOldServiceCard(
              serviceData: _userOldServiceData,
              onFieldUpdate: _updateUserOldServiceField,
            ),
          ],
        ),
      ),
    );
  }
}

