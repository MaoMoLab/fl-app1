import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/pages/low_admin/widgets/editable_user_old_service_card.dart';
import 'package:fl_app1/pages/low_admin/widgets/editable_user_v2_info_card.dart';
import 'package:fl_app1/utils/auth/auth_export.dart';
import 'package:flutter/material.dart';

class UserV2Page extends StatefulWidget {
  final int userId;

  const UserV2Page({super.key, required this.userId});

  @override
  State<UserV2Page> createState() => _UserV2PageState();
}

class _UserV2PageState extends State<UserV2Page> {
  late final RestClient _restClient = createAuthenticatedClient();

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
          (results[0]
                  as WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse)
              .result;
      _userOldServiceData =
          (results[1]
                  as WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse)
              .result;
    });
  }

  Future<bool> _updateUserV2Field(String field, dynamic value) async {
    WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch body;

    switch (field) {
      case 'email':
        body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
          email: value as String,
        );
        break;
      case 'userName':
        body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
          userName: value as String,
        );
        break;
      case 'isEnable':
        body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
          isEnable: value as bool,
        );
        break;
      case 'telegramId':
        body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
          telegramId: value as int?,
        );
        break;
      case 'isEmailVerify':
        body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
          isEmailVerify: value as bool,
        );
        break;
      case 'userAccountExpireIn':
        final localTime = value as DateTime;
        final utcTime = localTime.toUtc();
        print('📅 本地时间: $localTime (isUtc: ${localTime.isUtc})');
        print('📅 UTC时间: $utcTime (isUtc: ${utcTime.isUtc})');
        body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
          userAccountExpireIn: utcTime,
        );
        break;
      default:
        return false;
    }

    final response = await _restClient.fallback
        .patchUserV2ApiV2LowAdminApiUserV2UserIdPatch(
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
    WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch body;

    switch (field) {
      case 'ssUploadSize':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          ssUploadSize: value as int,
        );
        break;
      case 'ssDownloadSize':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          ssDownloadSize: value as int,
        );
        break;
      case 'ssBandwidthTotalSize':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          ssBandwidthTotalSize: value as int,
        );
        break;
      case 'ssBandwidthYesterdayUsedSize':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          ssBandwidthYesterdayUsedSize: value as int,
        );
        break;
      case 'userLevel':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          userLevel: value as int,
        );
        break;
      case 'userLevelExpireIn':
        final localTime = value as DateTime;
        final utcTime = localTime.toUtc();
        print('📅 本地时间: $localTime (isUtc: ${localTime.isUtc})');
        print('📅 UTC时间: $utcTime (isUtc: ${utcTime.isUtc})');
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          userLevelExpireIn: utcTime,
        );
        break;
      case 'nodeSpeedLimit':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          nodeSpeedLimit: value as int?,
        );
        break;
      case 'nodeConnector':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          nodeConnector: value as int,
        );
        break;
      case 'autoResetDay':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          autoResetDay: value as int,
        );
        break;
      case 'autoResetBandwidth':
        body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
          autoResetBandwidth: value as num,
        );
        break;
      default:
        return false;
    }

    final response = await _restClient.fallback
        .patchUserOldServiceApiV2LowAdminApiUserOldServiceUserIdPatch(
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
