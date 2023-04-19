import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:foodboard_application/screens/recipe_body.dart';
import 'package:foodboard_application/widgets/big_text.dart';

class searchPage extends StatefulWidget {
  final List chipname;

  searchPage({
    Key? key,
    required this.chipname,
  }) : super(key: key);
  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController textEditingController = TextEditingController();
  final _reference = FirebaseFirestore.instance.collection('recipeDetails');
  String search = '';

  late Stream<QuerySnapshot> _streams;

  @override
  void initState() {
    super.initState();

    _streams = _reference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("FoodBoard",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Wrap(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 1.4, color: Colors.white70, style: BorderStyle.solid),
            ),
            padding: const EdgeInsets.fromLTRB(18, 0.0, 20, 18),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: size.width / 8.5,
                        width: size.width / 1.17,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 231, 231, 226)),
                        child: TextField(
                          onChanged: (String value) {
                            setState(() {
                              search = value.toString();
                            });
                          },
                          controller: textEditingController,
                          //autofocus: true,
                          autocorrect: true,
                          maxLines: 1,
                          obscureText: false,
                          textCapitalization: TextCapitalization.words,
                          //keyboardType: TextInputType.streetAddress,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          cursorColor: const Color.fromARGB(255, 86, 85, 82),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 86, 85, 82)),
                            ),
                            hintText: "Search...",
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 86, 85, 82),
                                fontSize: 15),
                            hintMaxLines: 1,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 86, 85, 82),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width / 33),
                    ],
                  ),
                ]),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                      stream: _streams,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }

                        QuerySnapshot querySnapshot = snapshot.data;
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;

                        List<Map<String, dynamic>> items = documents
                            .map((e) => {
                                  'recipeName': e['recipeName'],
                                  'recipeRating': e['recipeRating'],
                                  'recipeTime': e['recipeTime'],
                                  'recipeImage': e['recipeImage'],
                                  'recipeType': e['recipeType'],
                                  'ingredientList': e['ingredientList'],
                                  'directionList': e['directionList'],
                                  'Filters': e['Filters'],
                                })
                            .toList();

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, index) {
                            final modelDB = items[index];
                            if (textEditingController.text.isEmpty) {
                              if (widget.chipname.isNotEmpty) {
                                if (widget.chipname
                                        .toString()
                                        .contains(modelDB['Filters']['0']) ||
                                    widget.chipname.toString().contains(
                                            modelDB['Filters']['1']) &&
                                        widget.chipname.toString().contains(
                                            modelDB['Filters']['2'])) {
                                  return Column(children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecipeBodyFirebase(
                                                      model: items[index])),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: size.width / 3.7,
                                                    width: size.width / 3.3,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                '${modelDB["recipeImage"]}')),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  SizedBox(
                                                    width: size.width / 20,
                                                  ),
                                                  SizedBox(
                                                    height: size.width / 3.7,
                                                    width: size.width / 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          '${modelDB["recipeName"]}',
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  size.width /
                                                                      17,
                                                              width:
                                                                  size.width /
                                                                      6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                //color: Colors.amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    width: 1.5),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    size:
                                                                        size.width /
                                                                            24,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    '${modelDB["recipeRating"]}',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            86,
                                                                            85,
                                                                            82),
                                                                        fontSize:
                                                                            13),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      29,
                                                            ),
                                                            Container(
                                                              height:
                                                                  size.width /
                                                                      17,
                                                              width:
                                                                  size.width /
                                                                      3.4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    width: 1.7),
                                                              ),
                                                              child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .watch_later,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    size:
                                                                        size.width /
                                                                            24,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    '${modelDB["recipeTime"]}',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            86,
                                                                            85,
                                                                            82),
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ]);
                                } else {
                                  return const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                                }
                              } else if (widget.chipname.isEmpty) {
                                return Column(children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeBodyFirebase(
                                                    model: items[index])),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: size.width / 3.7,
                                                  width: size.width / 3.3,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              '${items[index]["recipeImage"]}')),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                SizedBox(
                                                  width: size.width / 20,
                                                ),
                                                SizedBox(
                                                  height: size.width / 3.7,
                                                  width: size.width / 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        '${items[index]["recipeName"]}',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height:
                                                                size.width / 17,
                                                            width:
                                                                size.width / 6,
                                                            decoration:
                                                                BoxDecoration(
                                                              //color: Colors.amber,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      86,
                                                                      85,
                                                                      82),
                                                                  width: 1.5),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      86,
                                                                      85,
                                                                      82),
                                                                  size:
                                                                      size.width /
                                                                          24,
                                                                ),
                                                                const SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  '${items[index]["recipeRating"]}',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          86,
                                                                          85,
                                                                          82),
                                                                      fontSize:
                                                                          13),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                size.width / 29,
                                                          ),
                                                          Container(
                                                            height:
                                                                size.width / 17,
                                                            width: size.width /
                                                                3.4,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      86,
                                                                      85,
                                                                      82),
                                                                  width: 1.7),
                                                            ),
                                                            child: Wrap(
                                                              alignment:
                                                                  WrapAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .watch_later,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      86,
                                                                      85,
                                                                      82),
                                                                  size:
                                                                      size.width /
                                                                          24,
                                                                ),
                                                                const SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  '${items[index]["recipeTime"]}',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          86,
                                                                          85,
                                                                          82),
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                ]);
                              }
                            } else {
                              if (items[index]["recipeName"]
                                  .toLowerCase()
                                  .contains(textEditingController.text
                                      .toLowerCase())) {
                                return Column(children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeBodyFirebase(
                                                    model: items[index])),
                                      );
                                    },
                                    child: SingleChildScrollView(
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: size.width / 3.7,
                                                    width: size.width / 3.3,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                '${items[index]["recipeImage"]}')),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  SizedBox(
                                                    width: size.width / 20,
                                                  ),
                                                  SizedBox(
                                                    height: size.width / 3.7,
                                                    width: size.width / 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          '${items[index]["recipeName"]}',
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  size.width /
                                                                      17,
                                                              width:
                                                                  size.width /
                                                                      6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                //color: Colors.amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    width: 1.5),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    size:
                                                                        size.width /
                                                                            24,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    '${items[index]["recipeRating"]}',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            86,
                                                                            85,
                                                                            82),
                                                                        fontSize:
                                                                            13),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      29,
                                                            ),
                                                            Container(
                                                              height:
                                                                  size.width /
                                                                      17,
                                                              width:
                                                                  size.width /
                                                                      3.4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    width: 1.7),
                                                              ),
                                                              child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .watch_later,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        86,
                                                                        85,
                                                                        82),
                                                                    size:
                                                                        size.width /
                                                                            24,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    '${items[index]["recipeTime"]}',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            86,
                                                                            85,
                                                                            82),
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ]);
                              } else {
                                return const SizedBox(
                                  height: 0,
                                  width: 0,
                                );
                              }
                            }
                          },
                        );
                      }),
                  const SizedBox(
                    height: 170,
                  )
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
