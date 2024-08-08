import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:ecommerce_dashboard/core/firebase_helper.dart';
import 'package:ecommerce_dashboard/models/product_model.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(
    firestore: ref.read(firestoreProvider),
    storage: ref.read(storageProvider),
  ),
);

class ProductRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  const ProductRepository({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage;

  Future<void> uploadProduct(Product product) async {
    const String productCollection = "products";
    try {
      await _firestore
          .collection(productCollection)
          .doc(product.id)
          .set(product.toJson());
    } catch (e) {
      log("firestore Error: ${e.toString()}");
    }
  }

  Future<List<String>> uploadImages(List<Uint8List> images) async {
    final id = const Uuid().v1();
    final List<String> imageUrls = [];
    try {
      for (int i = 0; i < images.length; i++) {
        final path = "product/$id/img$i";
        TaskSnapshot snapShot =
            await _storage.ref().child(path).putData(images[i]);
        final downloadUrl = await snapShot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      log("storage error: ${e.toString()}");
    }
    return imageUrls;
  }
}
