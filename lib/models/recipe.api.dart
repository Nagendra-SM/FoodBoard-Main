import 'dart:convert';
import 'package:foodboard_application/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list-similarities', {
      "limit": "18",
      "start": "0",
      "id": "15-Minute-Baked-Salmon-with-Lemon-9029477",
      "apiFeedType": "moreFrom",
      "authorId": "Yummly"
    });

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "845cd1c8e6mshba57400bba37059p11d76cjsn162db569e9d5",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
