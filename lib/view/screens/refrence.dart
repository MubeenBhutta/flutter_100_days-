import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const colorx = Colors.black54;

class Reference extends StatefulWidget {
  @override
  State<Reference> createState() => _ReferenceState();
}

class _ReferenceState extends State<Reference> {
  List<String> _sources = [];

  Future<List<String>> _loadSources() async {
    List<String> sources = [];
    await rootBundle.loadString('assets/reference.txt').then((data) {
      sources = LineSplitter.split(data).toList();
    });
    return sources;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the sources (Processed in the background)
    List<String> sources = await _loadSources();

    // Notify the UI and display the sources
    setState(() {
      _sources = sources;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: colorx,
        title: Text("Reference"),
        elevation: 2.0, // Add elevation for a subtle shadow
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Reference",
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              "Explore trusted sources for learning:",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),
            for (String source in _sources) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      source,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
