import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    try {
      prefs = await SharedPreferences.getInstance();
      loadCheckboxState();
    } catch (e) {
      // Handle the exception, show an error, or log it based on your needs
      print('Error initializing SharedPreferences: $e');
    }
  }

  void loadCheckboxState() {
    // ignore: unnecessary_null_comparison
    if (prefs == null) {
      // Handle the case where prefs is null, you might want to show an error
      // or return early
      return;
    }

    setState(() {
      isSubsectionCompleted = Map.fromIterable(
        List.generate(widget.subsectionTopics.length, (index) => index),
        key: (index) => index,
        value: (index) {
          print('section${widget.sectionNumber}$index');

          return prefs.getBool('section${widget.sectionNumber}$index') ?? false;
        },
      );
    });
    print('isSubsectionCompleted ${isSubsectionCompleted}');
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
      print("${'section${widget.sectionNumber}$index'}");
      widget.updateProgress(
          isSubsectionCompleted!.values.every((completed) => completed));
    });
  }
}
