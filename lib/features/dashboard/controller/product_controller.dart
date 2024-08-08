import 'dart:developer';
import 'dart:typed_data';

import 'package:ecommerce_dashboard/core/utils/show_toast_message.dart';
import 'package:ecommerce_dashboard/features/dashboard/repository/product_repository.dart';
import 'package:ecommerce_dashboard/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productControllerProvider = StateProvider((ref) =>
    ProductController(productRepository: ref.read(productRepositoryProvider)));

class ProductController {
  final ProductRepository _productRepository;
  ProductController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  Future<void> uploadProduct(BuildContext context, Product product) async {
    try {
      _productRepository.uploadProduct(product);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<String>> uploadImages(
      BuildContext context, List<Uint8List> images) async {
    try {
      final imagesUrl = await _productRepository.uploadImages(
        images,
      );
      return imagesUrl;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showToastMessage(message: e.toString());
      log(e.toString());
      return [];
    }
  }
}
