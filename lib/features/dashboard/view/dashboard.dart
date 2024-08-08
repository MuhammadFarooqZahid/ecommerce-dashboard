import 'package:ecommerce_dashboard/features/dashboard/view/add_product.dart';
import 'package:ecommerce_dashboard/features/dashboard/view/categories.dart';
import 'package:ecommerce_dashboard/widgets/dashboard_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Navigator(
          clipBehavior: Clip.antiAlias,
          onGenerateRoute: (settings) => CupertinoPageRoute(builder: (context) {
            return ColoredBox(
              color: Colors.grey.shade100,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  child: Wrap(
                    runSpacing: 8,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const AddProduct(),
                                ));
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add Product"),
                        ),
                      ),
                      DashboardItem(
                        icon: const Icon(Icons.add),
                        label: "Products",
                        subtitle:
                            "Manage, Products,Add new products, Edit products",
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const AddProduct (),
                              ));
                        },
                      ),
                      DashboardItem(
                        icon: const Icon(Icons.category),
                        label: "Categories",
                        subtitle:
                            "Add categories,Delete Categories,Edit Categories",
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const Categories(),
                              ));
                        },
                      ),
                      DashboardItem(
                        icon: const Icon(Icons.featured_video),
                        label: "Featured Product",
                        subtitle:
                            "Items to be appeard in the featured product section",
                        onTap: () {},
                      ),
                      DashboardItem(
                        icon: const Icon(CupertinoIcons.flame_fill),
                        label: "Hot Selling",
                        subtitle:
                            "Items to be appeard in the hot selling product section",
                        onTap: () {},
                      ),
                      DashboardItem(
                        icon: const Icon(Icons.discount),
                        label: "Sales",
                        subtitle: "Manage Sales,Start new Sale, End a Sale",
                        onTap: () {},
                      ),
                      DashboardItem(
                        icon: const Icon(Icons.view_carousel),
                        label: "Manage Highlights",
                        subtitle: "Items to be Appeared in the carousel",
                        onTap: () {},
                      ),
                      DashboardItem(
                        icon: const Icon(Icons.notifications_active),
                        label: "Notification",
                        subtitle: "Send and Manage Notifications",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
