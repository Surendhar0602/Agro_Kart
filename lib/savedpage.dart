import 'package:project/ProductPage.dart';
import 'package:project/constants.dart';
import 'firebaseservices.dart';
import 'Custom_Action_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {

  final Firebaseservices _firebaseServices = Firebaseservices();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Saved Page',style: Constants.boldHeading,
              textAlign: TextAlign.center,
            ),
          ),
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: (){
            //  Navigator.of(context).pop();
            },
          ),

        ),



        body: Container(


        child: Stack(
            children: [


        FutureBuilder<QuerySnapshot>(
          future: _firebaseServices.userID.doc(_firebaseServices.getuserId())
              .collection("Saved")
              .get(),



          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),

              );
            }

            // Collection Data ready to display
            if (snapshot.connectionState == ConnectionState.done) {
              // Display the data inside a list view
              return ListView(
                padding: EdgeInsets.only(

                  bottom: 12.0,
                ),
                children: snapshot.data.docs.map((document) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Productpage(
                              productId: document.id,
                            ),
                          ));
                    },
                    child: FutureBuilder(
                      future: _firebaseServices.productID
                          .doc(document.id)
                          .get(),
                      builder: (context, productSnap) {
                        if (productSnap.hasError) {
                          return Container(
                            child: Center(
                              child: Text("${productSnap.error}"),
                            ),
                          );
                        }

                        if (productSnap.connectionState ==
                            ConnectionState.done) {
                          Map _productMap = productSnap.data.data();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 24.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      "${_productMap['image'][0]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_productMap['Name']}",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                        ),
                                        child: Text(
                                          "\$${_productMap['price']}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Theme.of(context)
                                                  .accentColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        "Quantity - ${document.data()['Quantity']}",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            }

            // Loading State
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),

        ],
    ),
    ),
      );
  }
}