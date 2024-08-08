import 'package:ecommerce_dashboard/core/images_path.dart';
import 'package:ecommerce_dashboard/features/dashboard/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Categories extends ConsumerWidget {
  const   Categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text("Manage Catgories"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FilledButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const CategoryDialogue(),
                );
              },
              icon: const Icon(Icons.category),
              label: const Text("Add Categoy"),
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
                width: double.infinity,
                height: double.infinity,
                // if there is no category in the data base(Firestore) then show this image
                // otherwise fetch categories from the firebase and show them instead of emptyillustration
                child: Center(
                  child: Image.asset(
                    Images.emptybox,
                    height: 100,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class CategoryDialogue extends ConsumerStatefulWidget {
  const CategoryDialogue({super.key});

  @override
  ConsumerState<CategoryDialogue> createState() => _CategoryDialogueState();
}

class _CategoryDialogueState extends ConsumerState<CategoryDialogue> {
  late TextEditingController categoryTextController;

  @override
  void initState() {
    categoryTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        ref.watch(categoryControllerProvider);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Category"), // dialogue title
            IconButton(
              // close button
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              /// upload category(Category Model)
            },
            child: const Text("Add Category"),
          ),
        ],
        surfaceTintColor: Colors.white,
        content: SizedBox(
          height: 200,
          width: 600,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        categoryController.pickImage(); // select image
                      },
                      child: categoryController.pickedCategoryImage == null
                          ? const Icon(Icons.cloud_upload)
                          : Image.memory(
                              categoryController.pickedCategoryImage!),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: categoryTextController,
                  decoration: const InputDecoration(
                    hintText: "Name this category",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
