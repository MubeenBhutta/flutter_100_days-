import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenViewModel {
  static double calculateOverallProgress(List<List<String>> subsectionTopics,
      Map<int, bool>? isMySectionCompleted) {
    // Ensure isMySectionCompleted is not null before accessing its length
    if (isMySectionCompleted == null) {
      return 0.0; // or handle it according to your logic
    }

    int totalSubsections = 0;
    int completedSubsections = 0;

    for (int i = 0; i < isMySectionCompleted.length; i++) {
      totalSubsections += subsectionTopics[i].length;
      if (isMySectionCompleted[i]!) {
        completedSubsections += subsectionTopics[i].length;
      }
    }

    return totalSubsections > 0
        ? (completedSubsections / totalSubsections) * 100
        : 0;
  }

  static int calculateDaysCompleted() {
    DateTime startDate = DateTime(2023, 12, 13); // Replace with your start date
    DateTime currentDate = DateTime.now();

    int daysDifference = currentDate.difference(startDate).inDays;

    return daysDifference < 100 ? daysDifference : 100;
  }

  static void clearAll(
    BuildContext context,
    List<bool> isSectionCompleted,
    List<List<String>> subsectionTopics,
    Function(List<bool> isSectionCompleted, List<List<String>> subsectionTopics)
        clearAllCallback,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear All'),
          content: Text('Are you sure you want to clear all progress?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                clearAllCallback(isSectionCompleted, subsectionTopics);
                Navigator.of(context).pop();
              },
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  static void clearCheckboxStates(List<List<String>> subsectionTopics) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int sectionNumber = 1; sectionNumber <= 10; sectionNumber++) {
      for (int index = 0;
          index < subsectionTopics[sectionNumber - 1].length;
          index++) {
        prefs.remove('section$sectionNumber$index');
      }
    }
  }

  MainScreenViewModel({required this.updateState}) {
    startDate = DateTime.now();
  }
  late SharedPreferences prefs;
  late Function updateState;
  late DateTime startDate;
  Future<void> fetchStartDate() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('start_date')) {
      String? storedStartDateString = prefs.getString('start_date');
      if (storedStartDateString != null) {
        DateTime storedStartDate = DateTime.parse(storedStartDateString);
        startDate = storedStartDate;
      }
    } else {
      DateTime initialStartDate = DateTime.now();
      prefs.setString('start_date', initialStartDate.toIso8601String());
      startDate = initialStartDate;
    }

    // Notify the calling class about the state change
    updateState();
  }
}
