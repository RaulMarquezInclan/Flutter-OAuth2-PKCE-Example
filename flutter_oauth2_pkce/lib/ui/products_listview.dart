import 'package:flutter_oauth2_pkce/globals.dart' as globals;
import 'package:flutter/material.dart';

class ProductsListView extends StatefulWidget {
  @override
  _ProductsListViewState createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  @override
  Widget build(BuildContext context) {

    return !(globals.productsList.length > 0) ? emptyList() : ListView.builder (
      padding: EdgeInsets.all(0),
      itemCount: globals.productsList.length,
      itemBuilder: (BuildContext context, int index) {

      EdgeInsets _listItemMargins(int index) {
        return index == globals.productsList.length - 1 ? EdgeInsets.fromLTRB(0, 4, 0, 0) :
        (index == 0 ? 
        EdgeInsets.fromLTRB(0, 0, 0, 4) : 
        EdgeInsets.fromLTRB(0, 4, 0, 4));
      }

      TextStyle _textStyle() {
        return TextStyle(
          fontSize: 16
        );
      }

      return Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          border: Border.all(
            color: Colors.green.shade400,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        margin: _listItemMargins(index),
        padding: EdgeInsets.all(8),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${globals.productsList[index].name}', style: _textStyle(),),
                  Container(height: 8),
                  Text('Color: ${globals.productsList[index].color}', style: _textStyle(),),
                ],
              ),),
              Expanded(
                flex: 1,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Price: \$${globals.productsList[index].unitPrice.toString()}', style: _textStyle(),),
                  Container(height: 8),
                  Text('Available Qty: ${globals.productsList[index].availableQuantity.toString()}', style: _textStyle(),),
                ],
              ),)
            ],
          ),
          Container(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Category: ${globals.productsList[index].category}', style: _textStyle(),),
            ],
          )
        ],),
      );     
      }
    );
  }
}

Widget emptyList() {
  return Center(
    child: Text('List is empty',
      style: TextStyle(
        color: Colors.white54,
        fontSize: 24
      ),
    )
  );
}