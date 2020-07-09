import 'package:flutter/material.dart';
import 'package:flutter_oauth2_pkce/api_services.dart';
import 'package:flutter_oauth2_pkce/ui/drawer.dart';
import 'package:flutter_oauth2_pkce/globals.dart' as globals;

class ProductListingsHome extends StatefulWidget {
  @override
  _ProductListingsHomeState createState() => _ProductListingsHomeState();
}

class _ProductListingsHomeState extends State<ProductListingsHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool get wantKeepAlive => true;  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      
      body: Builder(
        builder: (BuildContext ctx) {
          return Container(
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/gadgets_background.png"),
              fit: BoxFit.cover,
              ),
            ),
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text('Product Listings App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            blurRadius: 10.0,
                            color: Colors.blue,
                            offset: Offset(8.0, 5.0),
                            ),
                        ], ),),
                      ),
                    ),
                    Container(height: 24,),
                    globals.accessToken != null ? _authenticatedButton() : LoginButton(
                      onPressed: () async {
                        await APIServices.loginWithOktaPKCE();
                        if (globals.accessToken != null) {
                          setState(() { });
                          Scaffold.of(ctx).showSnackBar(SnackBar(
                            content: Text('Successfully logged In'),
                          ));
                        }
                      },
                    )
                ],
              ),
          );
        }
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  LoginButton({
    this.onPressed
  });

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(60.0),
        child: MaterialButton(
          minWidth: 140.0,
          height: 48,
          color: Colors.blueAccent,
          textColor: Colors.white70,
          onPressed: () async {
            await onPressed();
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Text('Login With Okta', style: TextStyle(fontSize: 24)),
          ) 
        ),
      );
  }
}

Widget _authenticatedButton() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(60.0),
    child: MaterialButton(
      height: 48,
      color: Colors.green,
      textColor: Colors.white,
      onPressed: () => {},
      child: Container(
        padding: EdgeInsets.all(0),
        child: Text('Authenticated!', style: TextStyle(fontSize: 24))
      ) 
    ),
  );
}