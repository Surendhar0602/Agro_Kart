import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/HomePage.dart';
import 'package:project/ProductPage.dart';
import 'package:project/constants.dart';
import 'package:project/firebaseservices.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  Firebaseservices _firebaseservices = Firebaseservices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder <QuerySnapshot>(
              future: _firebaseservices.productID.get(),
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
                    scrollDirection: Axis.horizontal,

                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder:(context)=> HomePage(),
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

                            children: <Widget>[
                          "${document.data()['image'][0]}" ??  Category(
                                image_caption: 'Rice',
                                Imagenetwork: 'https://firebasestorage.googleapis.com/v0/b/deptcs-1dca6.appspot.com/o/rice.jpeg?alt=media&token=d5a0fc45-b6dd-49db-8d55-22fe2ce3b46d',

                              ),

                            Category(
                                Imagenetwork: 'https://firebasestorage.googleapis.com/v0/b/deptcs-1dca6.appspot.com/o/wheat.jpeg?alt=media&token=de8f0c35-0746-4daf-9162-f7174a6c91e7',
                                image_caption: 'Wheat',
                              ),

                              Category(
                                Imagenetwork: 'https://picsum.photos/250?image=9',
                                image_caption: 'Sugar',
                              ),

                              Category(
                                Imagenetwork: 'https://picsum.photos/250?image=9',
                                image_caption: 'Grains',

                              ),

                              Category(
                                Imagenetwork: '',
                                image_caption: 'Prices',
                              ),
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
        ],
      ),
      height: 80.0,



    );
  }
}

class Category extends StatelessWidget {
  final String Imagenetwork;
  final String image_caption;

  Category({this.Imagenetwork, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder:(context)=> HomePage( ),
          ));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title:Text(image_caption,
                style: new TextStyle(fontSize: 14.0,fontWeight: FontWeight.w600),
            ),

            subtitle: Container(
              child:Image.network(Imagenetwork,
                fit: BoxFit.fill,),
            )
          ),
        ),
      ),
    );
  }
}
