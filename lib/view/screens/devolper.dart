import 'package:flutter/material.dart';

const colorx = Colors.black54;

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: colorx, title: Text("Developer")),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "Developer",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: colorx),
              ),
              const SizedBox(height: 40),
              DeveloperInfo(
                title: "Designed and Developed by",
                name: "Mr Mubeen Bhutta",
                color: colorx,
              ),
              const SizedBox(height: 20),
              ContactInfo(
                title: "Email",
                info: "codecafe.pk@gmail.com",
                icon: Icons.email,
                color: colorx,
              ),
              const SizedBox(height: 10),
              ContactInfo(
                title: "Facebook",
                info: "facebook.com/CodeCafe.pk",
                icon: Icons.facebook,
                color: colorx,
              ),
              const SizedBox(height: 10),
              ContactInfo(
                title: "Instagram",
                info: "@mubeenlcky",
                icon: Icons.link, // Using the link icon for Instagram
                color: colorx,
              ),
              const SizedBox(height: 10),
              ContactInfo(
                title: "WhatsApp",
                info: "+92 316 6702669",
                icon: Icons.phone,
                color: colorx,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeveloperInfo extends StatelessWidget {
  final String title;
  final String name;
  final Color color;

  const DeveloperInfo({
    required this.title,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, color: color),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}

class ContactInfo extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;
  final Color color;

  const ContactInfo({
    required this.title,
    required this.info,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 5),
            Text(
              info,
              style: TextStyle(fontSize: 18, color: color),
            ),
          ],
        ),
      ],
    );
  }
}
