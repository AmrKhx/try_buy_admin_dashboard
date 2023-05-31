import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('Reports').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final reportsdata = snapshot.data!.docs[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey.shade200),
                      columns: [
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Phone Number")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Description")),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(reportsdata['Name'])),
                          DataCell(Text(reportsdata['PhoneNumber'])),
                          DataCell(Text(reportsdata['Email'])),
                          DataCell(
                              Text(reportsdata['Description'], maxLines: 2)),
                        ]),
                      ]),
                  SizedBox(
                    height: 20,
                  )
                ],
              );
            });
      },
    );
  }
}
