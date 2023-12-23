import 'package:shared_preferences/shared_preferences.dart';

// this chechboxhandler is used in section_screeen.dart to keep ui seperate from logic
class CheckboxHandler {
  final SharedPreferences prefs;
  final Function(bool) updateProgress;

  CheckboxHandler({required this.prefs, required this.updateProgress});

  void handleCheckboxChange(int index, bool? value) {
    updateProgress(value!);
    prefs.setBool('section$index', value);
  }
}
