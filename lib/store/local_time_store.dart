import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalTimeStore extends ChangeNotifier {
  static final LocalTimeStore _instance = LocalTimeStore._internal();

  factory LocalTimeStore() => _instance;

  LocalTimeStore._internal();

  static const String _kKeyFixedTimeZone = 'local_time_fixed_tz';

  SharedPreferences? _prefs;

  /// If set, this string will be used as the app's fixed time zone identifier.
  /// Example values: 'UTC', 'Asia/Shanghai', 'America/Los_Angeles'.
  String? _fixedTimeZone;

  String? get fixedTimeZone => _fixedTimeZone;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _fixedTimeZone = _prefs?.getString(_kKeyFixedTimeZone);
    notifyListeners();
  }

  Future<void> setFixedTimeZone(String? tz) async {
    _fixedTimeZone = tz;
    if (tz == null || tz.isEmpty) {
      await _prefs?.remove(_kKeyFixedTimeZone);
    } else {
      await _prefs?.setString(_kKeyFixedTimeZone, tz);
    }
    notifyListeners();
  }
}
