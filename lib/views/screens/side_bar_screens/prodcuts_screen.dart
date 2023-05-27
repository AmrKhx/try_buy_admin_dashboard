import 'package:flutter/material.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/widgets/product_widget.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = '\Products';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),
            ),
          ),
          Divider(),
          ProductWidget()
        ],
      ),
    );
  }
}
