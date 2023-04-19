class Recipe {
  final String? name;
  final String images;
  final double? rating;
  final String? totalTime;
  final String? discription;
  final List? instructions;
  final List? ingredients;
  final String? types;
  final String? uploadedBy;

  Recipe({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
    required this.discription,
    required this.instructions,
    required this.ingredients,
    required this.types,
    required this.uploadedBy,
  });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
      name: json['details']['name'] as String,
      images: json['details']['images'][0]['hostedLargeUrl'] as String,
      rating: json['details']['rating'] as double,
      totalTime: json['details']['totalTime'] as String,
      discription: json['description']['text'] as String,
      instructions: json['preparationSteps'] as List,
      ingredients: json['ingredientLines'] as List,
      types: json['tags']['course'][0]['display-name'] as String,
      uploadedBy: json['details']['displayName'] as String,
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime, discription: $discription,instructions: $instructions,ingredients: $ingredients,types: $types}';
  }
}
