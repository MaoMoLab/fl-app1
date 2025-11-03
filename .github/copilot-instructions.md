尽量不要使用try来包装无意义的报错，
代码最大化用最精简的方法来实现功能
不要修改项目的/lib/api下的所有代码，该目录下的代码均为自动生成代码
在调用api类似使用下面

```dart
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart';

final body = WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel(
  email: _emailController.text.trim(),
  password: _passwordController.text,
  captchaKey: _fixedCaptchaKey,
  tiago2CapToken: _captchaToken!,
  isRememberMe: _rememberMe,
  twoFaCode: _twoFaController.text.isEmpty
      ? null
      : _twoFaController.text.trim(),
);
```

以下代码调用是最大扣分项

```dart
response = await
dio.get
('/test?id=12&name=dio
'
);
```