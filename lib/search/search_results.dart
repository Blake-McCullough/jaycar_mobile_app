import 'package:flutter/material.dart';
import 'package:jaycar_mobile_app/search/search_http.dart';

class Search_Results extends StatefulWidget {
  final String searchQuery;
  final String pageNumber;
  const Search_Results({
    Key? key,
    required this.pageNumber,
    required this.searchQuery,
  }) : super(key: key);

  @override
  _Search_ResultsState createState() => _Search_ResultsState();
}

class _Search_ResultsState extends State<Search_Results> {
  late Future<Map<String, dynamic>> parJson =
      getSearchQuery(widget.searchQuery, widget.pageNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: parJson,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var itemCount = snapshot.data!["results"].length;
            var size = MediaQuery.of(context).size;

            /*24 is for notification bar on Android*/
            final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
            final double itemWidth = size.width / 2;
            return GridView.count(
                childAspectRatio: (itemWidth / itemHeight),
                crossAxisCount: 2,
                children: List.generate(itemCount, (index) {
                  return Padding(
                    padding: index == snapshot.data!["results"].length - 1
                        ? const EdgeInsets.fromLTRB(8, 12, 8, 12)
                        : const EdgeInsets.only(
                            bottom: 4, left: 4, right: 4, top: 4),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(Radius.zero),
                          border: Border.all(
                              color: const Color.fromARGB(255, 204, 204, 204))),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data!["results"]
                                      [index]['ImageURL']),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Column(
                            children: [
                              Text(snapshot.data!["results"][index]['Title'],
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Row(children: [
                                const Text("CAT.NO:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 92, 94, 92))),
                                Text(snapshot.data!["results"][index]['Code'],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 74, 68, 68),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                              ]),
                              Text(
                                snapshot.data!["results"][index]['Price'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }));
          } else if (snapshot.hasError) {
            print(snapshot.stackTrace);
            print(snapshot.error.toString());
            return const Center(
              child: Text('an error occured :awkward:'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
