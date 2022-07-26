// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jaycar_mobile_app/categories/categories.dart';

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
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GridView.count(
          physics: ScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Categories_Results(
                      pageNumber: '0',
                      searchQuery: 'power',
                    ),
                  ),
                );
              },
              child: Container(
                width: 172,
                height: 215,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.jaycar.com.au/medias/sys_master/root/9212801712158/9212801712158.png"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[200],
              child: const Text('Heed not the rabble'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[300],
              child: const Text('Sound of screams but the'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[400],
              child: const Text('Who scream'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[500],
              child: const Text('Revolution is coming...'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[600],
              child: const Text('Revolution, they...'),
            ),
          ],
        ));
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
