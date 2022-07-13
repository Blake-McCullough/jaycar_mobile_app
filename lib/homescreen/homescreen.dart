// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:jaycar_mobile_app/search/search_results.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

final myController = TextEditingController();

class _HomePageState extends State<HomePage> {
  bool typing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(),
      ),
      body: Center(
        child: Text("Your app content"),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search',
          suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                if (myController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search_Results(
                            pageNumber: '0', searchQuery: myController.text)),
                  );
                }
              }),
        ),
        controller: myController,
      ),
    );
  }
}
