class Hotels {
  final String? NAME;
  final String PRICE;
  final String? CUSINE_CATEGORY;
  final String? CITY;
  final String? REGION;
  final String? LOGOURL;
  final String? URL;
  final String? TIMING;
  final String? RATING;

  Hotels({
    required this.NAME,
    required this.PRICE,
    required this.CUSINE_CATEGORY,
    required this.CITY,
    required this.REGION,
    required this.LOGOURL,
    required this.URL,
    required this.TIMING,
    required this.RATING,
  });

  factory Hotels.fromMap(Map<String, dynamic> json) {
    return Hotels(
      NAME: json['NAME'] as String,
      PRICE: json['PRICE'] as String,
      CUSINE_CATEGORY: json['CUSINE_CATEGORY'] as String,
      CITY: json['CITY'] as String,
      REGION: json['REGION'] as String,
      LOGOURL: json['LOGOURL'] as String,
      URL: json['URL'] as String,
      TIMING: json['TIMING'] as String,
      RATING: json['RATING'] as String,
    );
  }
}
