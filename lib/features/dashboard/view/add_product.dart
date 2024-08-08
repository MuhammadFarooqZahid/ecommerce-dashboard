import 'dart:developer';
import 'dart:typed_data';

import 'package:ecommerce_dashboard/features/dashboard/controller/product_controller.dart';
import 'package:ecommerce_dashboard/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController discrountController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  final images = <Uint8List>[];
  final categories = <String>[];
  final tags = <String>[];
  final formKey = GlobalKey<FormState>();

  Future<void> selectProdutImages() async {
    List<Uint8List>? pickedImages =
        await ImagePickerWeb.getMultiImagesAsBytes();
    try {
      if (pickedImages!.isNotEmpty) {
        images.addAll(pickedImages);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  uploadProduct() async {
    final controller = ref.read(productControllerProvider.notifier).state;
    final String productId = const Uuid().v1();

    final imageUrls = await controller.uploadImages(
      context,
      images,
    );
    await controller.uploadProduct(
      //ignore: use_build_context_synchronously
      context,
      Product(
        id: productId,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        discount: double.parse(discrountController.text.trim()),
        images: imageUrls,
        categories: categories,
        isFeatured: true,
        stockQuantity: 10,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text("Add Product"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FilledButton.icon(
              onPressed: () {
                uploadProduct();
              },
              icon: const Icon(Icons.upload),
              label: const Text("Upload Product"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColoredBox(
            color: Colors.white,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Wrap(
                              runSpacing: 10,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: images.isNotEmpty
                                      ? Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: List.generate(
                                            images.length,
                                            (index) => ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Stack(
                                                children: [
                                                  ColoredBox(
                                                    color: Colors.grey.shade100,
                                                    child: SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.memory(
                                                        images[index],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: -5,
                                                    right: -5,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        images.removeAt(index);
                                                        setState(() {});
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    onTap: () async {
                                      await selectProdutImages();
                                      setState(() {});
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ColoredBox(
                                        color: Colors.grey.shade100,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(text: "+ "),
                                                TextSpan(text: "Add Images"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Product Name *",
                                  style: style.headlineMedium,
                                ),
                                TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "e.g. Nike shoes",
                                    ),
                                    // TODO: handle validation
                                    validator: (value) => null),
                                Text(
                                  "Description *",
                                  style: style.headlineMedium,
                                ),
                                TextFormField(
                                    controller: descriptionController,
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                      hintText: "Add description here...",
                                    ),
                                    // TODO: handle validation
                                    validator: (value) => null),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Wrap(
                              runSpacing: 10,
                              children: [
                                Text(
                                  "Price *",
                                  style: style.headlineMedium,
                                ),
                                TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "e.g. 5.00\$",
                                      suffixIcon:
                                          Icon(Icons.attach_money_rounded),
                                    ),
                                    // TODO: handle validation
                                    validator: (value) => null),
                                Text(
                                  "Category *",
                                  style: style.headlineMedium,
                                ),
                                Wrap(
                                  runSpacing: 10,
                                  spacing: 10,
                                  children: [
                                    DropdownButtonFormField(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        elevation: 1,
                                        borderRadius: BorderRadius.circular(12),
                                        items: const [
                                          DropdownMenuItem(
                                            value: "data",
                                            child: Text("data"),
                                          ),
                                          DropdownMenuItem(
                                            value: "data1",
                                            child: Text("data1"),
                                          ),
                                          DropdownMenuItem(
                                            value: "data2",
                                            child: Text("data2"),
                                          ),
                                          DropdownMenuItem(
                                            value: "data3",
                                            child: Text("data3"),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            if (value != null) {
                                              categories.add(value);
                                            }
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "Select Categories...",
                                        ),
                                        // TODO: handle validation
                                        validator: (value) => null),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: List.generate(
                                        categories.length,
                                        (index) => Chip(
                                          label: Text(
                                            categories[index],
                                          ),
                                          onDeleted: () {
                                            categories.removeAt(index);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Quantity *",
                                  style: style.headlineMedium,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: "Available Quantity e.g 10",
                                  ),
                                  // TODO: handle validation
                                  validator: (value) => null,
                                ),
                                Text(
                                  "Discount",
                                  style: style.headlineMedium,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: "e.g 10",
                                  ),
                                ),
                                Text(
                                  "Tags",
                                  style: style.headlineMedium,
                                ),
                                TextFormField(
                                  controller: tagController,
                                  decoration: const InputDecoration(
                                    hintText: "Tags(Press enter to add tag)",
                                  ),
                                  onFieldSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      tags.add(tagController.text
                                          .toLowerCase()
                                          .trim());
                                      tagController.clear();

                                      setState(() {});
                                    }
                                  },
                                ),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                    tags.length,
                                    (index) => Chip(
                                      label: Text(
                                        tags[index],
                                      ),
                                      onDeleted: () {
                                        tags.removeAt(index);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
