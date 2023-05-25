import 'package:flutter/material.dart';
import 'package:try_buy_admin_dashboard/views/screens/side_bar_screens/widgets/reports_widget.dart';

class ReportsScreen extends StatelessWidget {
  static const String routeName = '\reports';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Reports',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ReportsWidget()
        ],
      ),
    );
  }
}
