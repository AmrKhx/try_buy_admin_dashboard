import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/widgets/orders_widget.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '\Orders';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Orders',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          OrdersWidget()
        ],
      ),
    );
  }
}
