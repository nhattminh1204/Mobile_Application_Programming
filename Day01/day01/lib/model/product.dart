class Rating {
  double rate;
  int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }
}

class Product {
  int id;
  String title;
  String description;
  String image;
  double price;
  String category;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: Rating.fromJson(json['rating'] ?? {'rate': 0, 'count': 0}),
    );
  }
}
