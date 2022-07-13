import 'package:flutter/material.dart';
import 'package:jaycar_mobile_app/main.dart';

bool _darkModeEnabled = true;

// Define a custom Form widget.
class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  _Settings createState() => _Settings();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _Settings extends State<Settings> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                height: 60.0,
              ),
              Text(
                'SETTINGS',
                style: TextStyle(),
              ),
              Text(
                'Made By Blake McCullough',
                style: TextStyle(),
              ),
              Text(
                'Discord - Spoiled_Kitten#4911',
                style: TextStyle(),
              ),
              Text(
                'https://github.com/Blake-McCullough/',
                style: TextStyle(),
              ),
              Text(
                'privblakemccullough@protonmail.com',
                style: TextStyle(),
              ),
              Text(
                'This is the alpha release :)',
                style: TextStyle(),
              ),
              Text(
                'Found a bug or have a recommendation?',
                style: TextStyle(),
              ),
              Text(
                'Message me on discord!',
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
