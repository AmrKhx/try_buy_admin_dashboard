import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsWidget extends StatelessWidget {
  const ReportsWidget({super.key});

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
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final productsData = snapshot.data!.docs[index];
              return Column(
                children: [
                  Text('Name:  ' + productsData['Name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                      )),
                  Text('PhoneNumber :   ' + productsData['PhoneNumber'],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                      )),
                  Text('Email:   ' + productsData['Email'],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 35,
                      )),
                  Text('Description:  ' + productsData['Description'],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                      )),
                  Divider(),
                ],
              );
            });
      },
    );
  }
}
