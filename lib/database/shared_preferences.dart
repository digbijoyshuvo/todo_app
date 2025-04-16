import 'package:shared_preferences/shared_preferences.dart';

class UserSavedData{
  static SharedPreferences? preferences;

    //Initialize shared preferences
    static Future init()async{
      preferences = await SharedPreferences.getInstance();
    }

    // Save Email
    static saveEmail(String email)async{
      return await preferences?.setString('email',email);
    }

    // read email
    static String? get getEmail => preferences?.getString('email');

}