import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Custom_Action_bar.dart';
import 'package:project/Quantity.dart';
import 'package:project/constants.dart';
import 'package:project/firebaseservices.dart';
import 'package:project/imageswipe.dart';
import 'package:project/savedpage.dart';

class Productpage extends StatefulWidget {
 final String productId;
 Productpage({this.productId});
  @override
  _ProductpageState createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  Firebaseservices _firebaseservices = Firebaseservices();


  User _user = FirebaseAuth.instance.currentUser;
  String _selectedproduct = "0";

  Future _addtocart(){
  return _firebaseservices.userID.doc(_user.uid).collection("cart").doc(widget.productId).set(
    {
      "Quantity":_selectedproduct
    }
  );
}

  Future _addtosave(){
    return _firebaseservices.userID.doc(_user.uid).collection("Saved").doc(widget.productId).set(
        {
          "Quantity":_selectedproduct
        }
    );
  }

final SnackBar _snackBar = SnackBar(content: Text("Product added to the cart"),);
  final SnackBar _save = SnackBar(content: Text("Product added to the Saved Page"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseservices.productID.doc(widget.productId).get(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              if(snapshot.connectionState == ConnectionState.done){
               Map<String, dynamic> documentData = snapshot.data.data();

             //list of length
               List imageList = documentData['image'];
               List productquantity = documentData['quantity'];
              return ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Imageswipe(imageList:imageList,),
                  Padding(
                    padding: const EdgeInsets.only(
                  top: 24.0,
                      left: 24.0,
                      right: 24.0,
                      bottom: 4.0,

                  ),
                    child: Text(
                      "\Name : ${documentData['Name']}"??"Product Name",
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "\$"
                          "${documentData['price']}"??"Price",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "\Description:\n${documentData['description']}"??"Description",
                      style: TextStyle(
                        fontSize: 16.0,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "Quality : 1",
                      style: Constants.regularHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "Quantity",
                      style: Constants.regularHeading,
                    ),
                  ),
                  quantity(
                    productquantity: productquantity,
                    onSelected: (quantity){
                      _selectedproduct = quantity;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Expanded(

                          child: GestureDetector(
                            onTap:()async {
                              await _addtosave();
                              Scaffold.of(context).showSnackBar(_save);

                            },

                            child: Container(
                              height:65.0,
                              decoration:BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
              ),
                              alignment:Alignment.center,
                              child: Text("Buy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(

                          child: GestureDetector(
                            onTap:()async {
                              await _addtocart();
                              Scaffold.of(context).showSnackBar(_snackBar);

              },
                            child: Container(
                              height:65.0,
                              margin: EdgeInsets.only(
                                left: 16.0,
                              ),
                              decoration:BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("Add to cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }


          ),
            customactionBar(
            hasBackArrow: true,
            hastitle: false,
              hasBackground: false,
              hascart: false,
          )
        ],
      ),
    );
  }
}
