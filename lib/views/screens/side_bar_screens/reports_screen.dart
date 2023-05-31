import 'package:flutter/material.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/widgets/dashboard_widget.dart';

class ReportsScreen extends StatelessWidget {
  static const String routeName = '\reports';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Reports',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 29,
                color: Colors.red,
              ),
            ),
          ),
          DashboardWidget()
        ],
      ),
    );
  }
}
