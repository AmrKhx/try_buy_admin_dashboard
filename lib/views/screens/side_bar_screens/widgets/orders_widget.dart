import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('Orders').snapshots();

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

        return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, mainAxisSpacing: 12, crossAxisSpacing: 12),
            itemBuilder: (context, index) {
              final productsData = snapshot.data!.docs[index];
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    child: Image.network(productsData['productImage']),
                  ),
                  Text('Name:  ' + productsData['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      )),
                  Text('Price:  ' + productsData['price'].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.green)),
                ],
              );
            });
      },
    );
  }
}
