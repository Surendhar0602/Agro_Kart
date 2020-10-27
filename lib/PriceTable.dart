import 'package:flutter/material.dart';
import 'package:project/constants.dart';

/// This Widget is the main application widget.
class Tables extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorials',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Price Table',
              style: Constants.boldHeading,
              textAlign: TextAlign.center,

            ),
          ),


        ),
        body: Table(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class Table extends StatelessWidget {
  Table({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0
      ),
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(

            label: Text(
              'Name',
              style: Constants.boldHeading,
            ),
          ),
          DataColumn(
            label: Text(
              'Quantity',
              style: Constants.boldHeading
            ),
          ),
          DataColumn(
            label: Text(
              'Price',
              style: Constants.boldHeading
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Rice',style: Constants.regularDarkText,)),
              DataCell(Text('1 Kg')),
              DataCell(Text('\$50')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Wheat',style: Constants.regularDarkText,)),
              DataCell(Text('1 Kg')),
              DataCell(Text('\$25')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Sugar',style: Constants.regularDarkText,)),
              DataCell(Text('1 Kg')),
              DataCell(Text('\$40')),
            ],
          ),
        ],
      ),
    );
  }
}