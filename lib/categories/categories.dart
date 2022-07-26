import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jaycar_mobile_app/product/product_page.dart';

class Categories_Results extends StatefulWidget {
  final String searchQuery;
  final String pageNumber;
  const Categories_Results({
    Key? key,
    required this.searchQuery,
    required this.pageNumber,
  }) : super(key: key);
  @override
  _Categories_ResultsState createState() => _Categories_ResultsState();
}

class _Categories_ResultsState extends State<Categories_Results> {
  late bool _hasMore;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _defaultPhotosPerPageCount = 20;
  late List<Photo> _photos;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 0;
    _error = false;
    _loading = true;
    _photos = [];
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    if (_photos.isEmpty) {
      if (_loading) {
        return Center(
            child: const Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
          child: InkWell(
            onTap: () => setState(
              () {
                _loading = true;
                _error = false;
                fetchPhotos();
              },
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Error while loading photos, tap to try agin"),
            ),
          ),
        );
      }
    } else {
      return ListView.builder(
        itemCount: _photos.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _photos.length - _nextPageThreshold) {
            fetchPhotos();
          }
          if (index == _photos.length) {
            if (_error) {
              return Center(
                child: InkWell(
                  onTap: () => setState(
                    () {
                      _loading = true;
                      _error = false;
                      fetchPhotos();
                    },
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          final Photo photo = _photos[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Product_Results(
                            productCode: photo.Code,
                          )),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(Radius.zero),
                          border: Border.all(
                              color: const Color.fromARGB(255, 204, 204, 204))),
                      child: Column(children: [
                        Container(
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: photo.makerHub
                                ? const Color.fromRGBO(24, 101, 157, 1)
                                : photo.clearance
                                    ? const Color.fromRGBO(218, 101, 0, 1)
                                    : photo.discontinued
                                        ? const Color.fromRGBO(105, 37, 127, 1)
                                        : photo.specialOrder
                                            ? const Color.fromRGBO(255, 0, 0, 1)
                                            : Theme.of(context).backgroundColor,
                          ),
                          child: Center(
                            child: Text(
                                photo.makerHub
                                    ? 'MAKER HUB AND ONLINE ONLY'
                                    : photo.clearance
                                        ? 'clearance'
                                        : photo.discontinued
                                            ? 'Discontinued'
                                            : photo.specialOrder
                                                ? 'Special'
                                                : '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Color.fromRGBO(241, 238, 239, 1))),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          width: 90,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(photo.thumbnailUrl),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            Text(photo.title,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color.fromRGBO(12, 37, 76, 1))),
                            Row(children: [
                              const Text("CAT.NO:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 92, 94, 92))),
                              Text(photo.Code,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 74, 68, 68),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))
                            ]),
                            Text(
                              photo.price,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )
                      ]))));
        },
      );
    }
    return Container();
  }

  Future<void> fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.20.14/cat?key=magickey&search=hobbiesgadgets&page=$_pageNumber"));
      List<Photo> fetchedPhotos =
          Photo.parseList(json.decode(response.body)['results']);
      setState(
        () {
          _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;
          _loading = false;
          _pageNumber = _pageNumber + 1;
          _photos.addAll(fetchedPhotos);
        },
      );
    } catch (e) {
      setState(
        () {
          _loading = false;
          _error = true;
        },
      );
    }
  }
}

class Photo {
  final String title;
  final String thumbnailUrl;
  final String price;
  // ignore: non_constant_identifier_names
  final String Code;
  final bool makerHub;
  final bool clearance;
  final bool discontinued;
  final bool specialOrder;
  Photo(
    this.title,
    this.thumbnailUrl,
    this.Code,
    this.makerHub,
    this.clearance,
    this.discontinued,
    this.specialOrder,
    this.price,
  );

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        json["Title"],
        json["ImageURL"],
        json["Code"],
        json["makerHub"],
        json['clearance'],
        json['discontinued'],
        json['specialOrder'],
        json['Price']);
  }

  static List<Photo> parseList(List<dynamic> list) {
    return list.map((i) => Photo.fromJson(i)).toList();
  }
}
