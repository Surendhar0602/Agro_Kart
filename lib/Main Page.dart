import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:project/cartpage.dart';
import 'package:project/searchpage.dart';
import 'horizontal_listview.dart';
import 'products.dart';

class MainPage extends StatefulWidget {
  final bool hascart;
  MainPage({this.hascart});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final CollectionReference _userID = FirebaseFirestore.instance.collection(
      "users");
  final User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {

  Widget image_carousel = new
    SizedBox(
        height: 200.0,
        width: 350.0,
        child: Carousel(
          images: [
            NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
            NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
            ExactAssetImage("assets/images/LaunchImage.jpg")
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.lightGreenAccent,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.purple.withOpacity(0.5),
          borderRadius: true,

    ),
  );

    return Scaffold(
      appBar: new AppBar(
        elevation: 1,
        backgroundColor: Colors.red,
        title: Text('E Commerece'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder:(context)=> SearchTab(),
                ));
              }),
          Container(
            width: 42.0,
            height: 42.0,


            alignment: Alignment.center,

            child: StreamBuilder(
              stream: _userID.doc(_user.uid).collection("cart").snapshots(),
              builder: (context, snapshot) {
                int _totalitem = 0;
                if (snapshot.connectionState == ConnectionState.active) {
                  List _documents = snapshot.data.docs;
                  _totalitem = _documents.length;
                }

                return Badge(
                  badgeColor: Colors.green,
                  badgeContent: Text("$_totalitem" ?? "0",
                    style: TextStyle(color: Colors.white),
                  ),

                  child: IconButton(
                    icon: Icon(Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder:(context)=> CartPage(),
                      ));
                    },
                  ),

                );

              },
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
                accountName: Text('SS'),
                accountEmail: Text('ss@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.red
            ),
            ),

//            body

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
            ),
          ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Categoris'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('favorite'),
                leading: Icon(Icons.favorite),
              ),
            ),


            Divider(),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.blue,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.green),
              ),
            ),
          ],
        ),
      ),

      body: new ListView(
        children: <Widget>[
          //image carousel begins here
          image_carousel,
SizedBox(height: 10.0,),
          //padding widget
          new Padding(padding: const EdgeInsets.all(8.0),
          child: new Text('Categories',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),),

          //Horizontal list view begins here
          HorizontalList(),
          SizedBox(height: 10.0,),
          //padding widget
         Padding(padding: const EdgeInsets.all(20.0),
            child: new Text('Recent products',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),

         ),

          //grid view
          Container(
            height: 320.0,
            child: Products(),
          )
        ],
      ),
    );
  }
}
