import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderWidget1 extends StatelessWidget {
  const OrderWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
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
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12),
            itemBuilder: (context, index) {
              final productsData = snapshot.data!.docs[index].get('items');
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    child: Image.network(productsData['productImage']),
                  ),
                  Text('Name:  ' + productsData['productName'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      )),
                  Text('Price:  ' + productsData['price'].toString() + ' EGP',
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
