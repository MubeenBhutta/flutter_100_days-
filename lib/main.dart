import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 100 Days Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> sectionTitles = [
    'Flutter Basics',
    'UI Development',
    'UI Development Advanced',
    'API Integration',
    'Local Data and Testing',
    'E-commerce App',
    'Advanced Topics Part 1',
    'Advanced Topics Part 2',
    'Review and Refinement',
    'Final Touches and Deployment',
  ];

  final List<List<String>> subsectionTopics = [
    [
      'Learn Widgets and Basic Concepts',
      'Dive into State Management',
      'Explore Git for Version Control'
    ],
    [
      'Implement Provider for State Management',
      'Understand MVVM Architecture',
      'Create a Custom Cart 🛒 and Implement Notifications'
    ],
    [
      'Implement Notification Animation',
      'Learn Responsive Design in Flutter',
      'Explore Internationalization and Localization, Focus on Error Handling and Debugging'
    ],
    [
      'Grasp API Fundamentals',
      'Perform REST API Integration',
      'Integrate Firebase for Real-time Data and Authentication'
    ],
    [
      'Implement Sqflite for Local Data Storage',
      'Dive into Unit Testing and Integration Testing',
      'Work on Specialized App Development - Chat App'
    ],
    [
      'Continue E-commerce App Development',
      'Advanced E-commerce Features',
      'Implement Augmented Reality (AR) Integration if applicable'
    ],
    [
      'Explore Dependency Injection in Flutter',
      'Set up a CI/CD Pipeline',
      'Understand Flutter Design Patterns'
    ],
    [
      'Focus on Accessibility in Flutter Apps',
      'Performance Monitoring and Optimization',
      'Learn Cloud Hosting for Deploying Your Flutter App'
    ],
    [
      'Review and Refine Your Flutter App',
      'Address any Weaknesses, Optimize Code, and Test Thoroughly'
    ],
    [
      'Apply Final Touches to Your Flutter App',
      'Deploy Your Flutter App using Cloud Hosting and Monitor Performance'
    ],
  ];

  late List<bool> isSectionCompleted = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    double overallProgress = calculateOverallProgress();
    Future<int> daysCompleted = calculateDaysCompleted();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 100 Days Challenge'),
        actions: [],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color.fromARGB(255, 224, 223, 223),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Overall Progress: ${overallProgress.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 19),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    FutureBuilder<int>(
                      future: daysCompleted,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          int completedDays = snapshot.data ?? 0;
                          return Text(
                            'Day $completedDays / 100',
                            style: TextStyle(fontSize: 19),
                          );
                        }
                      },
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 224, 223, 223),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
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
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Section ${index + 1}'),
                        SizedBox(height: 10),
                        Text(sectionTitles[index], textAlign: TextAlign.center),
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
                _clearAll();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Color.fromARGB(255, 100, 99, 99)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 250, 18, 18),
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

  Future<int> calculateDaysCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the start date is already stored in preferences
    String? storedStartDate = prefs.getString('startDate');

    // If not stored, set the start date to the current date and store it
    DateTime startDate;
    if (storedStartDate == null) {
      startDate = DateTime.now();
      prefs.setString('startDate', startDate.toIso8601String());
    } else {
      startDate = DateTime.parse(storedStartDate);
    }

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference in days
    int daysDifference = currentDate.difference(startDate).inDays;

    // Ensure that the progress is capped at 100 days
    return daysDifference < 100 ? daysDifference : 100;
  }

  double calculateOverallProgress() {
    int totalSubsections = 0;
    int completedSubsections = 0;

    for (int i = 0; i < isSectionCompleted.length; i++) {
      totalSubsections += subsectionTopics[i].length;
      if (isSectionCompleted[i]) {
        completedSubsections += subsectionTopics[i].length;
      }
    }

    return totalSubsections > 0
        ? (completedSubsections / totalSubsections) * 100
        : 0;
  }

  void _clearAll() {
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
                setState(() {
                  isSectionCompleted = List.generate(10, (index) => false);
                });

                clearCheckboxStates();

                Navigator.of(context).pop();
              },
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void clearCheckboxStates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int sectionNumber = 1; sectionNumber <= 10; sectionNumber++) {
      for (int index = 0;
          index < subsectionTopics[sectionNumber - 1].length;
          index++) {
        prefs.remove('section$sectionNumber$index');
      }
    }
  }
}

class SectionScreen extends StatefulWidget {
  final int sectionNumber;
  final String sectionTitle;
  final List<String> subsectionTopics;
  final Function(bool) updateProgress;

  SectionScreen({
    required this.sectionNumber,
    required this.sectionTitle,
    required this.subsectionTopics,
    required this.updateProgress,
  });

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  Map<int, bool>? isSubsectionCompleted;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadCheckboxState();
  }

  void loadCheckboxState() {
    setState(() {
      isSubsectionCompleted = Map.fromIterable(
        List.generate(widget.subsectionTopics.length, (index) => index),
        key: (index) => index,
        value: (index) =>
            prefs.getBool('section${widget.sectionNumber}$index') ?? false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSubsectionCompleted == null) {
      // Add a loading indicator or handle the case where isSubsectionCompleted is still null
      return CircularProgressIndicator();
    }

    double subsectionProgress =
        isSubsectionCompleted!.values.where((completed) => completed).length /
            widget.subsectionTopics.length *
            100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Section ${widget.sectionNumber}: ${widget.sectionTitle}'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              children: [
                Text(
                  'Subsection Progress: ${subsectionProgress.toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: subsectionProgress / 100,
                  backgroundColor: Colors.grey[300],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.subsectionTopics.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 234, 231, 231),
                  ),
                  child: ListTile(
                    title: Text(
                      'Day${(widget.sectionNumber - 1) * 10 + index * 3 + 1} - ${(widget.sectionNumber - 1) * 10 + index * 3 + 3}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 228, 177, 38),
                      ),
                    ),
                    subtitle: Text(
                      widget.subsectionTopics[index],
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Checkbox(
                      value: isSubsectionCompleted![index]!,
                      onChanged: (value) {
                        _handleCheckboxChange(index, value);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleCheckboxChange(int index, bool? value) {
    setState(() {
      isSubsectionCompleted![index] = value!;
      prefs.setBool('section${widget.sectionNumber}$index', value);
      widget.updateProgress(
          isSubsectionCompleted!.values.every((completed) => completed));
    });
  }
}
