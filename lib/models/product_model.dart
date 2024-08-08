class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final List<String> images;
  final List<String> categories;
  final bool isFeatured;
  // final int rating;
  final int stockQuantity;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.images,
    required this.categories,
    required this.isFeatured,
    // required this.rating,
    required this.stockQuantity,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      images: List<String>.from(json['images']),
      categories: List<String>.from(json['categories']),
      isFeatured: json['isFeatured'],
      // rating: json['rating'],
      stockQuantity: json['stockQuantity'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'images': images,
      'categories': categories,
      'isFeatured': isFeatured,
      // 'rating': rating,
      'stockQuantity': stockQuantity,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discount,
    List<String>? images,
    List<String>? categories,
    bool? isFeatured,
    // int? rating,
    int? stockQuantity,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      images: images ?? this.images,
      categories: categories ?? this.categories,
      isFeatured: isFeatured ?? this.isFeatured,
      // rating: rating ?? this.rating,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
