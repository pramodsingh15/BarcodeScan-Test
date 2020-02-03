import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper _sharedPreferencesHelper;
  SharedPreferences prefs;
  SharedPreferencesHelper._internal() {
    print("SharedPreferencesHelper intialize--");
  }

  static SharedPreferencesHelper getSharedPreferencesHelperInstance() {
    if (_sharedPreferencesHelper == null) {
      _sharedPreferencesHelper = SharedPreferencesHelper._internal();
    }
    return _sharedPreferencesHelper;
  }

  addStringToSF(String key, String value) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString(key, value);
  }

  Future<String> getStringFromSF(String key) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String strValue = prefs1.getString(key);
    return strValue;
  }

  addListStringToSF(String key, List<String> value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  Future<List<String>> getListString(String key) async {
    prefs = await SharedPreferences.getInstance();
    List<String> listString = prefs.getStringList(key);
    return listString;
  }

  getClearData() {
    prefs.clear();
  }
}
