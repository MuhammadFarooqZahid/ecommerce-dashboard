import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/core/firebase_helper.dart';
import 'package:ecommerce_dashboard/features/dashboard/models/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider(
  (ref) => CategoryRepository(
    firebaseFirestore: ref.read(firestoreProvider),
  ),
);

class CategoryRepository {
  final FirebaseFirestore _firebaseFirestore;

  const CategoryRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  /// create a category
  Future<void> createCatagory(CategoryModel categoryModel) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc()
          .set(categoryModel.toMap());
    } on FirebaseException catch (e) {
      log("Firebase Exception: ${e.toString()}");
    } catch (e) {
      log("Exception while updating category: ${e.toString()}");
      rethrow;
    }
  }
}
