import 'package:al_flutter/view/screens/aboutus.dart';
import 'package:al_flutter/view/screens/contact.dart';
import 'package:al_flutter/view/screens/devolper.dart';
import 'package:al_flutter/view/screens/moreapps.dart';
import 'package:al_flutter/view/screens/policy.dart';
import 'package:al_flutter/view/screens/refrence.dart';
import 'package:flutter/material.dart';

const color1 = Color.fromARGB(255, 52, 50, 50);
const color2 = Colors.grey;
List<Widget> children1 = [
  CustomCard1(text: "About us"),
  CustomCard1(
    text: "Reference",
  ),
  CustomCard1(
    text: "Privacy policy",
  ),
  CustomCard1(
    text: "Contact us",
  ),
  CustomCard1(
    text: "Devolpers",
  ),
  CustomCard1(
    text: "More Apps",
  ),
];

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu_outlined,
            color: Color.fromARGB(255, 7, 7, 7),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: children1.length,
          itemBuilder: (context, index) {
            return children1[index];
          },
        ),
      ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  final String text;
  const AnimatedCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 1100),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: CustomCard1(text: text),
    );
  }
}

class CustomCard1 extends StatelessWidget {
  final String text;

  CustomCard1({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color1,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 24, 23, 23).withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 7,
              offset: Offset(1, 3)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: InkWell(
          onTap: () {
            _navigateToScreen(context, text);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(255, 174, 88, 38),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 3.0, color: color2),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String text) {
    switch (text) {
      case "About us":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutPage()));
        break;
      case "Reference":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Reference()));
        break;
      case "Privacy policy":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Policy()));
        break;
      case "Contact us":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactPage()));
        break;
      case "Devolpers":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DeveloperPage()));
        break;
      case "More Apps":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MoreApps()));
        break;
      default:
        break;
    }
  }
}
