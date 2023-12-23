import 'dart:convert';

import 'package:al_flutter/model/my_constants.dart';
import 'package:al_flutter/view/menu_screen.dart';
import 'package:al_flutter/view/section_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:al_flutter/viewmodel/main_screen_viewmodel.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<String> sectionTitles = [];
  late List<List<String>> subsectionTopics = [];
  List<DateTime> sectionCompletionDates = [];
  Map<int, bool>? isMySectionCompleted;
  late SharedPreferences prefs;

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadCheckboxState();
  }

  void loadCheckboxState() {
    setState(() {
      isMySectionCompleted = Map.fromIterable(
        List.generate(sectionTitles.length, (index) => index),
        key: (index) => index,
        value: (index) {
          return prefs.getBool('section$index') ?? false;
        },
      );
    });
  }

  List<bool> isSectionCompleted = List.generate(11, (index) => false);
// list of section
// list of subsection

  late Map<String, dynamic> jsonData;
  late DateTime startDate = DateTime(2023, 12, 22);

  Future<void> fetchJsonData() async {
    var response = await http.get(Uri.parse(MyConstants.apiBaseUrl));
    var responseBody = response.bodyBytes;

    setState(() {
      jsonData = json.decode(utf8.decode(responseBody.toList()));
    });

    sectionTitles = List<String>.from(jsonData['sectionTitles']);
    subsectionTopics = List<List<String>>.from(jsonData['subsectionTopics']
        .map((dynamic list) => List<String>.from(list.cast<String>())));
    isSectionCompleted = List.generate(sectionTitles.length, (index) => false);
    sectionCompletionDates = List.generate(
      sectionTitles.length,
      (index) => DateTime(2023, 12, 22),
    );

    initializeSharedPreferences();
  }

  late MainScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MainScreenViewModel(updateState: () {
      setState(() {});
    });
    _viewModel.fetchStartDate();
    fetchJsonData();
    if (sectionTitles.length != 0) {
      initializeSharedPreferences();
    }
  }

  @override
  Widget build(BuildContext context) {
    double overallProgress = MainScreenViewModel.calculateOverallProgress(
        subsectionTopics, isMySectionCompleted);
    int daysCompleted = MainScreenViewModel.calculateDaysCompleted();
    MyConstants constant = MyConstants();
    constant.sectionTitles;
    constant.subsectionTopics;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 100 Days Challenge'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              );
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: (sectionTitles.length == 0)
          ? Center(
              child: Column(
                children: [
                  Text("offline", style: TextStyle(fontSize: 30)),
                  TextButton(
                    onPressed: () {
                      sectionTitles = constant.sectionTitles;
                      subsectionTopics = constant.subsectionTopics;
                      isSectionCompleted =
                          List.generate(sectionTitles.length, (index) => false);
                      initializeSharedPreferences();
                      setState(() {});
                    },
                    child: Text("Load Offline Data"),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 223, 223),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Overall Progress: ${overallProgress.toStringAsFixed(2)}%',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 74),
                          Text(
                            'Day $daysCompleted / 100',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      LinearProgressIndicator(
                        minHeight: 10,
                        value: overallProgress / 100,
                        backgroundColor: Color.fromARGB(255, 255, 250, 250),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: sectionTitles.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (isMySectionCompleted![index] ?? false)
                              ? const Color.fromARGB(255, 228, 177, 38)
                              : Colors.grey[300],
                        ),
                        child: TextButton(
                          onPressed: () {
                            if ((index == 0)) {
                              if (true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SectionScreen(
                                      sectionNumber: index + 1,
                                      sectionTitle: sectionTitles[index],
                                      subsectionTopics: subsectionTopics[index],
                                      updateProgress: (value) {
                                        setState(() {
                                          isSectionCompleted[index] = value;
                                          if (value) {
                                            prefs.setBool(
                                                'section$index', value);
                                          } else {
                                            prefs.setBool(
                                                'section$index', value);
                                          }
                                        });

                                        loadCheckboxState();
                                      },
                                    ),
                                  ),
                                );
                              }
                            } else {
                              if ((isMySectionCompleted![index - 1] ?? false)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SectionScreen(
                                      sectionNumber: index + 1,
                                      sectionTitle: sectionTitles[index],
                                      subsectionTopics: subsectionTopics[index],
                                      updateProgress: (value) {
                                        setState(() {
                                          isSectionCompleted[index] = value;
                                          if (value) {
                                            prefs.setBool(
                                                'section$index', value);
                                          } else {
                                            prefs.setBool(
                                                'section$index', value);
                                          }
                                        });

                                        loadCheckboxState();
                                      },
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Section ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: isSectionCompleted[index]
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    sectionTitles[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSectionCompleted[index]
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              if (index != 0 &&
                                  !(isMySectionCompleted![index - 1] ?? false))
                                Positioned(
                                  top: 3,
                                  bottom: 5,
                                  left: 0,
                                  right: 0,
                                  child: Opacity(
                                    opacity: 0.25,
                                    child: Icon(
                                      Icons.lock,
                                      size: 100,
                                      color: const Color.fromARGB(
                                          255, 232, 35, 21),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      MainScreenViewModel.clearAll(
                        context,
                        isSectionCompleted,
                        subsectionTopics,
                        (List<bool> isSectionCompleted,
                            List<List<String>> subsectionTopics) {
                          // Your clearAll logic goes here

                          // Reset overall progress variables
                          isMySectionCompleted = Map.fromIterable(
                            List.generate(
                                sectionTitles.length, (index) => index),
                            key: (index) => index,
                            value: (index) => false,
                          );

                          // Reset section completion dates
                          sectionCompletionDates = List.generate(
                            sectionTitles.length,
                            (index) => DateTime(2023, 12, 22),
                          );

                          // Clear checkboxes
                          prefs.clear();

                          // Update the state
                          setState(() {
                            // Update isSectionCompleted, subsectionTopics, and other relevant variables
                            isSectionCompleted =
                                List.generate(11, (index) => false);
                            subsectionTopics = List.generate(
                              11,
                              (index) => List<String>.empty(growable: true),
                            );
                          });
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: Color.fromARGB(255, 100, 99, 99)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
