import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}


class _OrderWidgetState extends State<OrderWidget> {
  var Orders=<Map>[];
  List<OrderFetch> items = [];

  // void initState() {
  //   super.initState();
  //   getOrders();
  // }
  //
  // void getOrders() async {
  //
  //   await FirebaseFirestore.instance
  //       .collection('Orders')
  //       .get()
  //       .then((querySnapshot) async {
  //     for (var docSnapshot in querySnapshot.docs) {
  //       setState(() {
  //           Data = docSnapshot.data();
  //       });
  //     }
  //   });
  // }

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
            itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, mainAxisSpacing: 12, crossAxisSpacing: 12),
            itemBuilder: (context, index) {
              items.add(OrderFetch(
                Orders[0]['price'],
                Orders[0]['productId'].toString(),
                Orders[0]['productName'].toString(),
                Orders[0]['productImage'].toString(),
                Orders[0]['quantity'],
                Orders[0]['status'].toString(),
              ));
              print("this is items of $items");
              print("this is orders of $Orders");

              // return Column(
              //   children: [
              //     Text('Id:  ' + OrderData['orderId'],
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 15,
              //         )),
              //     Container(
              //       height: 200,
              //       width: 150,
              //       child: Image.network(OrderData['productImage']),
              //     ),
              //     Text('Name:  ' + OrderData['name'],
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 15,
              //         )),
              //     Text('Price:  ' + OrderData['price'].toString() + ' EGP',
              //         style: TextStyle(
              //             fontWeight: FontWeight.w700,
              //             fontSize: 15,
              //             color: Colors.green)),
              //   ],
              // );
            });
      },
    );
  }
}

class OrderFetch {
  int price;
  String productId;
  String productName;
  String productImage;
  int quantity;
  String status;

  OrderFetch(this.price, this.productId, this.productImage, this.productName, this.quantity,this.status);
}