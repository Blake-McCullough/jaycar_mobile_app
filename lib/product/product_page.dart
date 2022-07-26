import 'package:flutter/material.dart';

import 'package:jaycar_mobile_app/product/product_http.dart';

//CREATES THE SearchResults CRAP
class Product_Results extends StatefulWidget {
  final String productCode;
  const Product_Results({Key? key, required this.productCode})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Product_ResultsState createState() => _Product_ResultsState();
}

// ignore: camel_case_types
class _Product_ResultsState extends State<Product_Results> {
  late Future<Map<String, dynamic>> parJson =
      getProductInfo(widget.productCode);
  bool description = true;
  bool specifications = false;
  var message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.productCode)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: parJson,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(physics: const BouncingScrollPhysics(), children: [
              Container(
                margin: const EdgeInsets.all(20),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(snapshot.data!["Image"]),
                      fit: BoxFit.fill),
                ),
              ),
              Column(children: [
                Text(snapshot.data!["Title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25)),
                Column(children: [
                  // ignore: prefer_interpolation_to_compose_strings
                  Text("\$" + snapshot.data!["Price"],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const Text("Bulk Pricing:",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(2.0),
                    child: Table(
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          for (var x in snapshot.data!["PriceBreaks"])
                            TableRow(children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
                                child: Text(x["VolumePriceQuantity"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
                                child: Text(
                                  x["VolumePriceAmount"],
                                ),
                              ),
                            ]),
                        ]),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: description
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).backgroundColor,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  description = true;
                                  specifications = false;
                                },
                              );
                            },
                            child: Text('Description',
                                style: TextStyle(
                                  color: specifications
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).backgroundColor,
                                ))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: specifications
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).backgroundColor,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  description = false;
                                  specifications = true;
                                },
                              );
                            },
                            child: Text('Specifications',
                                style: TextStyle(
                                  color: specifications
                                      ? Theme.of(context).backgroundColor
                                      : Theme.of(context).primaryColor,
                                ))),
                      ]),

                  specifications
                      ? Column(children: [
                          for (var i in snapshot.data!["Specifications"])
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Column(children: [
                                  Text(i["Title"],
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Container(
                                      padding: const EdgeInsets.all(2.0),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(1)),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 204, 204, 204))),
                                      child: Column(
                                        children: [
                                          for (var x in i["Data"])
                                            Container(
                                              color: Colors.white,
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Table(
                                                border: TableBorder.all(
                                                    color: Colors.black),
                                                children: [
                                                  TableRow(children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 4, 4, 4),
                                                      child: Text(x["Title"],
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      14)),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 4, 4, 4),
                                                      child: Text(
                                                        x["Value"],
                                                      ),
                                                    ),
                                                  ])
                                                ],
                                              ),
                                            )
                                        ],
                                      ))
                                ]))
                        ])
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 12),
                          child: Row(children: [
                            Flexible(
                              child: Text(
                                snapshot.data!['Description']
                                    .toString()
                                    .replaceAll("*", "\n*"),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(fontSize: 15),
                              ),
                            )
                          ])),
                ])
              ])
            ]);
          } else if (snapshot.hasError) {
            print(snapshot.stackTrace);
            print(snapshot.error.toString());
            return const Center(
              child: Text(
                'an error occured :awkward:',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
