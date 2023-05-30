import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/orders_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/prodcuts_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/reports_screen.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();
  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;

      case VendorsScreen.routeName:
        setState(() {
          _selectedItem = VendorsScreen();
        });
        break;

      case ProductsScreen.routeName:
        setState(() {
          _selectedItem = ProductsScreen();
        });
        break;
      case OrdersScreen.routeName:
        setState(() {
          _selectedItem = OrdersScreen();
        });
        break;
      case ReportsScreen.routeName:
        setState(() {
          _selectedItem = ReportsScreen();
        });
        break;
    }
  }

  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 251, 121, 0),
        title: Text(
          'Managment',
          selectionColor: Color.fromARGB(255, 251, 121, 0),
        ),
      ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Products',
            route: ProductsScreen.routeName,
            icon: Icons.shop,
          ),
          AdminMenuItem(
            title: 'Vendors',
            icon: CupertinoIcons.person_3_fill,
            route: VendorsScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Orders',
            icon: Icons.shopping_cart,
            route: OrdersScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.routeName,
            icon: CupertinoIcons.collections_solid,
          ),
          AdminMenuItem(
            title: 'Reports',
            route: ReportsScreen.routeName,
            icon: Icons.report,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: const Center(
            child: Text(
              'Main Menu',
              style: TextStyle(
                color: Color.fromARGB(255, 251, 121, 0),
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: const Center(
            child: Text(
              'Try & Buy Store Panel',
              style: TextStyle(
                color: Color.fromARGB(255, 251, 121, 0),
              ),
            ),
          ),
        ),
      ),
      body: _selectedItem,
    );
  }
}
