import 'package:ecommerce_dashboard/features/dashboard/view/categories.dart';
import 'package:ecommerce_dashboard/features/dashboard/view/dashboard.dart';
import 'package:ecommerce_dashboard/features/messages/view/messgaes.dart';
import 'package:ecommerce_dashboard/features/notifications/view/notification.dart';
import 'package:ecommerce_dashboard/firebase_options.dart';
import 'package:ecommerce_dashboard/widgets/sidebar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce Dashboard',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            fontFamily: "Manrope",
            useMaterial3: true,
            listTileTheme: ListTileThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              selectedTileColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            )),
            chipTheme: ChipThemeData(
                backgroundColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none,
                )),
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.minPositive, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )),
        home: const SideBarView(
          tabs: [
            SideBarItem(
              label: "Analytics",
              icon: Icon(Icons.analytics),
            ),
            SideBarItem(
              label: "Dashboard",
              icon: Icon(Icons.widgets),
            ),
            SideBarItem(
              label: "Notifications",
              icon: Icon(Icons.notifications_active),
            ),
            SideBarItem(
              label: "Messages",
              icon: Icon(Icons.message),
            ),
          ],
          tabsView: [
            Categories(),
            // AddProduct(),
            DashboardScreen(),
            // AnalyticsScreen(),\
            NotificationScreen(),
            MessagesScreen(),
          ],
        ),
      ),
    );
  }
}
