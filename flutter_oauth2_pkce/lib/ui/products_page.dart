import 'package:flutter/material.dart';
import 'package:flutter_oauth2_pkce/api_services.dart';
import 'package:flutter_oauth2_pkce/ui/header/header.dart';
import 'package:flutter_oauth2_pkce/globals.dart' as globals;
import 'package:flutter_oauth2_pkce/ui/products_listview.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 60, 84, 1),
      body: Builder(
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Header('Products', onTitlePress: () async {
                    await APIServices.getProducts();
                    if (globals.productsFetch) {
                      setState(() {});
                      Scaffold.of(ctx).showSnackBar(SnackBar(
                        content: Text('Successfully retreived products from .NET Core backend'),
                      ));                  
                    } else {
                      Scaffold.of(ctx).showSnackBar(SnackBar(
                        content: Text('Unable to retreive products from .NET Core backend'),
                      ));
                    }
                  },),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ProductsListBody()
                  ),
                ],
              ),
            ),
          );
        }),
    );
  }
}

class ProductsListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var listHeight = MediaQuery.of(context).size.height * 0.48;

    return SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 16,),
        Text(
          globals.onlineUser.name,
          style: textTheme.headline5.copyWith(color: Colors.white, fontSize: 32),
        ),
        Container(height: 24,),

        Container(
          padding: EdgeInsets.all(0),
          child: ProductsListView(),
          height: listHeight,
        )

      ],
    ),
    );
  }
}