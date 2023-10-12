import 'package:blog_app/utils/constains/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class  SaveAccount {
  String? _email;
  String? _pass;
  bool? _isCheckedSave;
  late SharedPreferences _preferences;
  static SaveAccount _instance = SaveAccount._internal();

  factory SaveAccount(){
    _instance ??= SaveAccount._internal();
    return _instance!;
  }

  SaveAccount._internal(){
    init();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _email = await _preferences.getString(StringConst.SAVE_EMAIL);
    _pass = await _preferences.getString(StringConst.SAVE_PASS);
    _isCheckedSave = await _preferences.getBool(StringConst.SAVE_ISCHECKED);
    print(toString());
  }

  void save(String email, String pass, bool isChecked) async {
    await _preferences.setString(StringConst.SAVE_EMAIL, email);
    await _preferences.setString(StringConst.SAVE_PASS, pass);
    await _preferences.setBool(StringConst.SAVE_ISCHECKED, isChecked);
  }

  void clear() {
    _preferences.clear();
  }

  Future<SaveAccount> loadAccount() async {
    final saveAccount = SaveAccount();
    await saveAccount.init();
    return saveAccount;
  }

  String get email => _email ?? "";

  String get pass => _pass ?? "";

  bool get isCheckedSave => _isCheckedSave ?? false;

  @override
  String toString() {
    // TODO: implement toString
    return "info1252: ${_email} - ${_pass} - ${_isCheckedSave}";
  }
}