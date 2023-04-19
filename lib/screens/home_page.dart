import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodboard_application/data/filter_chips_home.dart';
import 'package:foodboard_application/models/recipe.api.dart';
import 'package:foodboard_application/models/recipe.dart';
import 'package:foodboard_application/screens/recipe_body.dart';
import 'package:foodboard_application/screens/recipe_info.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodboard_application/models/filter_chips_home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  String search = '';

  final _reference = FirebaseFirestore.instance.collection('recipeDetails');

  List<Recipe>? _recipes;
  late Stream<QuerySnapshot> _streams;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    inputData();
    _streams = _reference.snapshots();
    getRecipes();
    _handleLocationPermission();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  var loggedInUser;

  Future<void> inputData() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        loggedInUser = data?['username']; // <-- The value you want to retrieve.
      });
      // Call setState if needed.
    }
  }

  List<FilterChipsHomeData> filterChipsHome = FilterChipsHome.all;

  List filterData = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Wrap(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 1.4,
                    color: Colors.white70,
                    style: BorderStyle.solid),
              ),
              padding: const EdgeInsets.fromLTRB(18, 0.0, 20, 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome, $loggedInUser',
                            style: GoogleFonts.nunito(
                              color: const Color.fromARGB(255, 39, 204, 45),
                              fontWeight: FontWeight.w800,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "What you want to cook today?",
                            style: GoogleFonts.nunito(
                              color: const Color.fromARGB(255, 86, 86, 86),
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              runSpacing: 4,
                              spacing: 2,
                              children: filterChipsHome
                                  .map((filterChip) => FilterChip(
                                        label: Text(filterChip.label),
                                        labelStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                        backgroundColor: filterChip.color,
                                        onSelected: (isSelected) =>
                                            setState(() {
                                          if (isSelected) {
                                            if (!filterData
                                                .contains(filterChip.label)) {
                                              filterData.add(filterChip.label);
                                            }
                                          } else {
                                            if (filterData
                                                .contains(filterChip.label)) {
                                              filterData.removeWhere(
                                                  (element) =>
                                                      element ==
                                                      filterChip.label);
                                            }
                                          }

                                          filterChipsHome =
                                              filterChipsHome.map((otherChip) {
                                            return filterChip == otherChip
                                                ? otherChip.copy(
                                                    isSelected: isSelected)
                                                : otherChip;
                                          }).toList();
                                        }),
                                        selected: filterChip.isSelected,
                                        selectedColor: const Color.fromARGB(
                                            255, 46, 81, 47),
                                        showCheckmark: false,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ]),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 200,
                      child: FutureBuilder(
                          future: getRecipes(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _recipes!.length,
                              itemBuilder: (BuildContext context, index) {
                                final recipe = _recipes![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecipeInfo(
                                                recipe: recipe,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 22, vertical: 10),
                                    width: 280,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.6),
                                          offset: const Offset(
                                            0.0,
                                            10.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: -6.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.30),
                                          BlendMode.multiply,
                                        ),
                                        image: NetworkImage(recipe.images),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Text(
                                              recipe.name!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                        Align(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 60,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                          255, 186, 173, 173)
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 7),
                                                    Text(
                                                      recipe.rating!.toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                          255, 186, 173, 173)
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.schedule,
                                                      color: Colors.yellow,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 7),
                                                    Text(
                                                      recipe.totalTime!,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          alignment: Alignment.bottomLeft,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                          stream: _streams,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
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
                                      'authorName': e['authorName'],
                                      'recipeType': e['recipeType'],
                                      'ingredientList': e['ingredientList'],
                                      'directionList': e['directionList'],
                                      'Filters': e['Filters'],
                                    })
                                .toList();

                            return ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, index) {
                                final homeDB = items[index];
                                if (textEditingController.text.isEmpty) {
                                  if (filterData.isNotEmpty) {
                                    if (filterData
                                        .toString()
                                        .contains(homeDB['Filters']['0'])) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 18.0),
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) =>
                                                      RecipeBodyFirebase(
                                                          model:
                                                              items[index]))),
                                          child: Material(
                                            elevation: 3,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            child: Container(
                                              height: size.height / 2.48,
                                              width: size.width / 1.1,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: size.height / 4,
                                                    width: size.width / 1.1,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(18),
                                                        topRight:
                                                            Radius.circular(18),
                                                      ),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              homeDB[
                                                                  'recipeImage']),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: size.height / 14,
                                                    width: size.width / 1.2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          homeDB['recipeName'],
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Container(
                                                          height:
                                                              size.height / 25,
                                                          width: size.width / 6,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.green,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child:
                                                                Row(children: [
                                                              const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .yellow,
                                                                size: 18,
                                                              ),
                                                              const SizedBox(
                                                                  width: 7),
                                                              Text(
                                                                homeDB[
                                                                    'recipeRating'],
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ]),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width / 1.2,
                                                    child: Text(
                                                      "Uploaded by ${homeDB['authorName']}",
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Container(
                                                    width: size.width / 1.2,
                                                    child: Row(children: [
                                                      const Icon(Icons.timer,
                                                          color: Colors.green),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        homeDB['recipeTime'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(
                                        height: 0,
                                        width: 0,
                                      );
                                    }
                                  } else if (filterData.isEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 20.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RecipeBodyFirebase(
                                                        model: items[index]))),
                                        child: Material(
                                          elevation: 3,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Container(
                                            height: size.height / 2.48,
                                            width: size.width / 1.1,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: size.height / 4,
                                                  width: size.width / 1.1,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(18),
                                                      topRight:
                                                          Radius.circular(18),
                                                    ),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            homeDB[
                                                                'recipeImage']),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height / 14,
                                                  width: size.width / 1.2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        homeDB['recipeName'],
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Container(
                                                        height:
                                                            size.height / 25,
                                                        width: size.width / 6,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.green,
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Row(children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                                width: 7),
                                                            Text(
                                                              homeDB[
                                                                  'recipeRating'],
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width / 1.2,
                                                  child: Text(
                                                    "Uploaded by ${homeDB['authorName']}",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  width: size.width / 1.2,
                                                  child: Row(children: [
                                                    const Icon(Icons.timer,
                                                        color: Colors.green),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      homeDB['recipeTime'],
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  if (items[index]["recipeName"]
                                      .toLowerCase()
                                      .contains(textEditingController.text
                                          .toLowerCase())) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 20.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RecipeBodyFirebase(
                                                        model: items[index]))),
                                        child: Material(
                                          elevation: 3,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Container(
                                            height: size.height / 2.48,
                                            width: size.width / 1.1,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: size.height / 4,
                                                  width: size.width / 1.1,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(18),
                                                      topRight:
                                                          Radius.circular(18),
                                                    ),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            homeDB[
                                                                'recipeImage']),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height / 14,
                                                  width: size.width / 1.2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        homeDB['recipeName'],
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Container(
                                                        height:
                                                            size.height / 25,
                                                        width: size.width / 6,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.green,
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Row(children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                                width: 7),
                                                            Text(
                                                              homeDB[
                                                                  'recipeRating'],
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .yellow,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width / 1.2,
                                                  child: Text(
                                                    "Uploaded by ${homeDB['authorName']}",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  width: size.width / 1.2,
                                                  child: Row(children: [
                                                    const Icon(Icons.timer,
                                                        color: Colors.green),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      homeDB['recipeTime'],
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
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
                        height: 320,
                      )
                    ]),
                  ),
                ]))
          ]),
        ),
      ),
    );
  }
}
