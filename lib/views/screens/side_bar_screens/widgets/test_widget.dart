import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}


class _OrderWidgetState extends State<OrderWidget> {
  var Orders=<Map> [];
  List mainItems = [];
  List items =<Map> [];


  void initState() {
      super.initState();
      getOrder();
  }

  void getOrder() async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        Orders.add(doc.data() as Map);
      }
      mainItems = Orders[0]['items'];
      print(mainItems);
      print(mainItems.length);
    });
  }

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
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, mainAxisSpacing: 12, crossAxisSpacing: 12),
            itemBuilder: (context, index) {

                  return Column(
                    children: [
                      Text('Id:  ' + Orders[index]['orderId'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          )),
                      Container(
                        height: 200,
                        width: 150,
                        child: Image.network(mainItems[index]['productImage']),
                      ),
                      Text('Name:  ' + mainItems[index]['productName'],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          )),
                      Text('Price:  ' + mainItems[index]['price'].toString() + ' EGP',
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

// class OrderFetch {
//   int price;
//   String productId;
//   String productName;
//   String productImage;
//   int quantity;
//   String status;
//
//   OrderFetch(this.price, this.productId, this.productImage, this.productName, this.quantity,this.status);
// }