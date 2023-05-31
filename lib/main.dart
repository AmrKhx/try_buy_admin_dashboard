import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/orders_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/prodcuts_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/reports_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/vendors_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/widgets/header_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyC-st3MqxGK0x_grWvGP8FI9qhnWrpTXoU",
              appId: "1:549324820186:web:58da1abff4b2c7608f9fe3",
              messagingSenderId: "549324820186",
              projectId: "try-and-buy-36392",
              storageBucket: "try-and-buy-36392.appspot.com",
            )
          : null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardScreen();
    } else if (currentPage == DrawerSections.vendors) {
      container = CategoryScreen();
    } else if (currentPage == DrawerSections.products) {
      container = ProductsScreen();
    } else if (currentPage == DrawerSections.orders) {
      container = OrdersScreen();
    } else if (currentPage == DrawerSections.reports) {
      container = ReportsScreen();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 145, 238),
        title: Text("Try & Buy"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Category", Icons.category_outlined,
              currentPage == DrawerSections.vendors ? true : false),
          menuItem(3, "Products", Icons.shopping_bag_rounded,
              currentPage == DrawerSections.products ? true : false),
          menuItem(4, "Orders", Icons.production_quantity_limits,
              currentPage == DrawerSections.orders ? true : false),
          Divider(),
          menuItem(5, "Reports", Icons.report_problem_sharp,
              currentPage == DrawerSections.reports ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.vendors;
            } else if (id == 3) {
              currentPage = DrawerSections.products;
            } else if (id == 4) {
              currentPage = DrawerSections.orders;
            } else if (id == 5) {
              currentPage = DrawerSections.reports;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  events,
  notes,
  vendors,
  products,
  orders,
  reports,
}
