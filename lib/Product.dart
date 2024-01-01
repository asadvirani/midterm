import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'Product_Model.dart';
// Future means global function
//First we hit the url and saved response in final response
// If reponse is correct, decode the body, convert file into json
// then take each object one by one, map into Users model and save in the list
// Future<List<Products>> fetchUser() async {
//   final response =
//       await http.get(Uri.parse("https://dummyjson.com/products"));
//       print(response.statusCode);

//   if (response.statusCode == 200) {
//     List<dynamic> _parsedListJson = jsonDecode(response.body);
//     List<Products> _itemList = List<Products>.from(
//         _parsedListJson.map<Products>((dynamic i) => Products.fromJson(i)));
//     return _itemList;
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

Future<List<Products>> fetchUser() async {
  final response = await http.get(Uri.parse("https://dummyjson.com/products"));
  print(response.statusCode);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List<dynamic> productsJson = jsonData["products"];

    if (productsJson is List) {
      List<Products> itemList = productsJson
          .map<Products>((dynamic i) => Products.fromJson(i))
          .toList();
      return itemList;
    } else {
      throw Exception('Failed to load products');
    }
  } else {
    throw Exception('Failed to load products');
  }
}

class ProductUi extends StatefulWidget {
  const ProductUi({super.key});

  @override
  State<ProductUi> createState() => _ProductUiState();
}

class _ProductUiState extends State<ProductUi> {
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Products',
          textAlign: TextAlign.center,
        )),
        body: Center(
          child: FutureBuilder<List<Products>>(
              future: fetchUser(),
              // snapshot have the data coming from the function fetchUser()
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // If the Future is still running, show a CircularProgressIndicator
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, i) {
                        var item = snapshot.data![i];
                        return Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Image.network(
                                    item.thumbnail,
                                    fit: BoxFit.fill,
                                    height: 200,
                                  ))
                                  // Text("price ${item.category}"),
                                  // Text("id ${item.id}"),
                                  // Expanded(
                                  //   child: Text(
                                  //     "price ${item.title}",
                                  //   ),
                                  // )
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item.title}\t\t\t",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "${item.price} USD",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Card(
                                              child: Column(children: [
                                                Row(
                                                  children: [
  //                                                    item.map<>((item) => Image.network(
  //   item.thumbnail,
  //   fit: BoxFit.fill,
  //   height: 200,
  // )).toList(),

                                                    Expanded(
                                                        child: Image.network(
                                                      item.thumbnail,
                                                      fit: BoxFit.fill,
                                                      height: 200,
                                                    )),
                                                    
                                                    Expanded(
                                                        child: Image.network(
                                                      item.thumbnail,
                                                      fit: BoxFit.fill,
                                                      height: 200,
                                                    )),
                                                  ],
                                                ),
                                                SizedBox(height: 30),
                                                Row(children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${item.title}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ]),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${item.description}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\$${item.price}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        Text(
                                                          "${item.rating}",
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "${item.discountPercentage}%",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons.discount,
                                                          color:
                                                              Colors.blueAccent,
                                                        )
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ]),
                                            );
                                          });
                                    },
                                    icon:
                                        const Icon(Icons.remove_red_eye_sharp),
                                    // Icon(Icons.remove_red_eye_sharp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item.description}",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                        //                             ListTile(
                        //   title: Text(
                        //     item.title,
                        //   ),
                        //   subtitle: Text("price ${item.userId * 10}"),
                        //   trailing: Text("ID: ${item.id}"),
                        // );
                      });
                } else {
                  return Text("No data");
                }
              }),
        ));
  }
}
