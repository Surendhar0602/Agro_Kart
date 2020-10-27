import 'package:flutter/material.dart';
import 'package:project/HomePage.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Rice",
      "picture": "https://firebasestorage.googleapis.com/v0/b/deptcs-1dca6.appspot.com/o/rice.jpeg?alt=media&token=d5a0fc45-b6dd-49db-8d55-22fe2ce3b46d",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Wheat",
      "picture": "https://firebasestorage.googleapis.com/v0/b/deptcs-1dca6.appspot.com/o/wheat.jpeg?alt=media&token=de8f0c35-0746-4daf-9162-f7174a6c91e7",
      "old_price": 100,
      "price": 50,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_pricture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
     }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder:(context)=> HomePage(  ),
                ));

              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                        leading: Text(

                          prod_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          "\$$prod_price",
                          style: TextStyle(
                              color: Colors.red,fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "\$$prod_old_price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                             ),
                        ),
                    ),
                  ),
                  child: Image.network(
                    prod_pricture,
                    fit: BoxFit.cover,
                  ),

              ),
            ),
          )),
    );
  }
}

