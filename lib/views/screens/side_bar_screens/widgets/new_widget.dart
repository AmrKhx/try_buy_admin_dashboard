import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderWidget1 extends StatefulWidget {
  const OrderWidget1({super.key});

  @override
  State<OrderWidget1> createState() => _OrderWidget1State();
}

class _OrderWidget1State extends State<OrderWidget1> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .once()
        .then((snapshot) {
      setState(() {
        var value = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
        print("this is${value}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<QuerySnapshot>(
      future: getPastOrders("Bb2oEoTBC7M0xQETctOkqy6LFEg2"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }
        if (snapshot.hasData) {
          var orders = snapshot.data!.docs;
          print(orders);
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final orderData = orders[index].data() as Map<String, dynamic>;
                print('xxxxxxxxxxxxxxx${orderData['items'].length}');

                return Card(
                  elevation: 2.0,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFFF6900)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFFFF6900)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${orderData['status']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: orderData['items'].length,
                            itemBuilder: (context, index) {
                              final product = orderData['items'][index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[200]!,
                                            blurRadius: 2.0,
                                            offset: Offset(0.0, 2.0),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          product['productImage'] ??
                                              'Product image not available',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['productName'] ??
                                              'Product name not available',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          '\$${product['price'].toString()} ',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          'Quantity: ${product['quantity'].toString()} ',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Date:',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${orderData['total'].toString()}',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text('No past orders found'),
          );
        }
      },
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPastOrders(String userId) async {
    final ordersCollection = FirebaseFirestore.instance.collection('Orders');
    final pastOrdersQuery = ordersCollection
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(20);
    final pastOrders = await pastOrdersQuery.get();

    return pastOrders;
  }
}
