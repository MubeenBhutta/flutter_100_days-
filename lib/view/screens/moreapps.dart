import 'package:flutter/material.dart';

final stylex = TextStyle(fontSize: 12, color: Colors.black);
const colorx = Colors.black54;

class MoreApps extends StatelessWidget {
  const MoreApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorx,
        title: Text("More Apps"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text("More Apps", style: TextStyle(fontSize: 24, color: colorx)),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Wait for our upcoming apps! \n We are working tirelessly.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: colorx),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
