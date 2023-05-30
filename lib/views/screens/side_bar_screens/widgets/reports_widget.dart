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
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final productsData = snapshot.data!.docs[index];
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height:MediaQuery.of(context).size.height/ 3,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        color: const Color(0xFFFAFAFA),
                        border: Border.all(
                            color: const Color(0xFF001C55), width: 2.0)),
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Name:  ' + productsData['Name'],
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF001C55)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'PhoneNumber :   ' + productsData['PhoneNumber'],
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF001C55)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Email:   ' + productsData['Email'],
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF001C55)),
                        ),
                        Text(
                          'Description:  ' + productsData['Description'],
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF001C55)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
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

//
// Column(
// children: [
// Text('Name:  ' + productsData['Name'],
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 30,
// )),
// Text('PhoneNumber :   ' + productsData['PhoneNumber'],
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 30,
// )),
// Text('Email:   ' + productsData['Email'],
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 35,
// )),
// Text('Description:  ' + productsData['Description'],
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 30,
// )),
// Divider(),
// ],
// );
