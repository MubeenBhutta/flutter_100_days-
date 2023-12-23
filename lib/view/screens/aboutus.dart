import 'package:flutter/material.dart';

const colorx = Colors.black54;

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorx,
          title: const Text(
            "About Us",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "About Us",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorx),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to the about page of the app!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'First of all, thank you for taking the time to download and use the app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'This project has been a personal effort and a labor of love, and I am thrilled to share it with you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'I created this app with the goal of providing a simple, intuitive, and useful tool for anyone who needs it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'It is completely free to use, and there are no affiliate links or ads within the app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'I believe that technology should be accessible to everyone, and that is why I decided to make this app available for free.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'I also believe in transparency, so if you have any questions or concerns about the app, please don\'t hesitate to reach out to me.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'The app is designed to be your lifelong companion.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'I have put a lot of time and effort into making sure that it is easy to use and navigate, so I hope you find it helpful.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'If you enjoy using the app, please consider leaving a review on the Google Play Store.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Your feedback helps me to continue improving the app and providing the best possible experience for users.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Thank you again for choosing my app, and I hope it makes your life a little easier and more enjoyable.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: colorx),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
