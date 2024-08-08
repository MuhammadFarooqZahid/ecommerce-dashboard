// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  final String name;
  final DateTime createdAt;
  final String image;

  const CategoryModel({
    required this.name,
    required this.createdAt,
    required this.image,
  });

  CategoryModel copyWith({
    String? name,
    DateTime? createdAt,
    String? image,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(name: $name, createdAt: $createdAt, image: $image)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.createdAt == createdAt &&
      other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ createdAt.hashCode ^ image.hashCode;
}
