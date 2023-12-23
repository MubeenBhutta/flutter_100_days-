import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

const colorx = Colors.black54;

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: colorx, title: const Text("Contact Us")),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "Contact Us",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: colorx),
              ),
              const SizedBox(height: 50),
              ContactInfo(
                title: "Email",
                info: "codecafe.pk@gmail.com",
                icon: Icons.email,
                color: colorx,
              ),
              const SizedBox(height: 20),
              ContactInfo(
                title: "WhatsApp",
                info: "+92 3166702669",
                icon: Icons.phone,
                color: colorx,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  ElevatedLink(
                    uri: Uri.parse(
                        'https://api.whatsapp.com/send?phone=923166702669&text=Contact%20App%20developer'),
                    label: 'WhatsApp!!',
                    style: ElevatedButton.styleFrom(shadowColor: Colors.green),
                  ),
                  const SizedBox(width: 50),
                  ElevatedLink(
                    uri: Uri.parse('https://www.codecafe.com'),
                    label: 'Website!!',
                    style: ElevatedButton.styleFrom(shadowColor: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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

class ElevatedLink extends StatelessWidget {
  final Uri uri;
  final String label;
  final ButtonStyle style;

  const ElevatedLink({
    required this.uri,
    required this.label,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: uri,
      builder: (_, followLink) {
        return ElevatedButton(
          onPressed: followLink,
          style: style,
          child: Text(
            label,
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(255, 103, 99, 99)),
          ),
        );
      },
    );
  }
}
