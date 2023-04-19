import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodboard_application/screens/recipe_body.dart';
import 'package:foodboard_application/screens/recipe_info_screen.dart';
import 'package:foodboard_application/widgets/big_text.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

var id;

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> inputData() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    setState(() {
      id = uid; // <-- The value you want to retrieve.
    });
  }

  final _reference = FirebaseFirestore.instance.collection('recipeDetails');

  // late Stream<QuerySnapshot> _streams;

  @override
  void initState() {
    super.initState();
    inputData();
    // _streams = _reference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("id: $id");
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "Favorites",
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Wrap(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(id)
                          .collection('favoriteList')
                          .get(),
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
                                  'recipeImage': e['recipeImage'],
                                  'recipeRating': e['recipeRating'],
                                  'recipeTime': e['recipeTime'],
                                  'recipeID': e['recipeID'],
                                  'ingredientList': e['ingredientList'],
                                  'directionList': e['directionList'],
                                })
                            .toList();

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, index) {
                            final homeDB = items[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RecipeFavorite(model: items[index])),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 10),
                                width: MediaQuery.of(context).size.width,
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
                                    image: NetworkImage(homeDB['recipeImage']),
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
                                          homeDB['recipeName'],
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
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.all(10),
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
                                                  homeDB['recipeRating'],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.all(10),
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
                                                  homeDB['recipeTime'],
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
                  const SizedBox(
                    height: 320,
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
