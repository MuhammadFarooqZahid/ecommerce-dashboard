import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/core/utils/show_toast_message.dart';
import 'package:ecommerce_dashboard/features/dashboard/models/category_model.dart';
import 'package:ecommerce_dashboard/features/dashboard/repository/category_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';

class CategoryController extends ChangeNotifier {
  // constructor
  CategoryController({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  // variable
  bool _isLoading = false;
  Uint8List? _pickedCategoryImage;

  // getters
  bool get isLoading => _isLoading;
  Uint8List? get pickedCategoryImage => _pickedCategoryImage;

  _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  _setImage(Uint8List image) {
    _pickedCategoryImage = image;
    notifyListeners();
  }

  // create category
  Future<void> createCategory(CategoryModel categoryModel) async {
    try {
      _setLoading(true);
      await categoryRepository.createCatagory(categoryModel);
    } on FirebaseException catch (e) {
      showToastMessage(message: e.message.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// fetching categories
  /// returning categories in case of successfull respose other wise show toast message
  Future<void> fetchCategories() async {}

  /// select and returning animage incase if it is not null
  void pickImage() async {
    try {
      final image = await ImagePickerWeb.getImageAsBytes();
      if (image != null) {
        _setImage(image);
      } else {
        showToastMessage(message: "No image selected");
      }
    } catch (e) {
      showToastMessage(message: e.toString());
    }
  }
}

// <-------------providers--------------->
final categoryControllerProvider = ChangeNotifierProvider.autoDispose((ref) {
  return CategoryController(
    categoryRepository: ref.read(categoryRepositoryProvider),
  );
});
