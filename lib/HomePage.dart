import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Custom_Action_bar.dart';
import 'package:project/imageswipe.dart';
import 'ProductPage.dart';
import 'package:project/constants.dart';

class HomePage extends StatelessWidget {
  final CollectionReference _productRef = FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Stack(
        children: [
          FutureBuilder <QuerySnapshot>(
          future: _productRef.get(),
      builder:(context,snapshot){
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done) {
          return ListView(
            padding: EdgeInsets.only(
              top: 108.0,
              bottom: 12.0,
            ),
            children: snapshot.data.docs.map((document) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder:(context)=> Productpage(productId: document.id,),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: 250.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                    child: Stack(
                      children: [
                        Container(
                          height:350.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              "${document.data()['image'][0]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  document.data()['Name'] ?? 'Product Name',
                                style: Constants.regularHeading,),
                                Text(
                                  document.data()['Name']??"\$${document.data()['price']}" ?? 'Price',
                                     style: TextStyle(
                                  fontSize: 18.0,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w600
                                ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                ),
              );
            }).toList(),
          );

        }


       //loding ScrollIncrementType.page
       return Scaffold(
        body: Center(
       child: CircularProgressIndicator(),
    ),
    );
    }

          ),
         customactionBar(
           title: "Home",
           hasBackArrow:false,
         ),

        ],
      ),
    );
  }
}
