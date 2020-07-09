import 'package:flutter/material.dart';
import 'package:flutter_oauth2_pkce/api_services.dart';
import 'package:flutter_oauth2_pkce/ui/header/header.dart';
import 'package:flutter_oauth2_pkce/globals.dart' as globals;

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  Header('Profile', onTitlePress: () async {
                    await APIServices.getUser();
                    if (globals.onlineUserFetch) {
                      setState(() {});
                      Scaffold.of(ctx).showSnackBar(SnackBar(
                        content: Text('Successfully retreived user from Okta'),
                      ));                  
                    } else {
                      Scaffold.of(ctx).showSnackBar(SnackBar(
                        content: Text('Unable to retreive user from Okta'),
                      ));
                    }
                  },),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ProfileBody(),
                  ),
                ],
              ),
            ),
          );
        }),
    );
  }
}


class ProfileBody extends StatelessWidget {

  Widget _buildInfo(TextTheme textTheme, IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
          size: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: textTheme.subtitle1.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoDetail(BuildContext context, TextTheme textTheme, String text) {
    var width = MediaQuery.of(context).size.width*0.82;
    return Row(
            children: <Widget>[
              Container(width: 24,),
              Container(
                width: width,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    textAlign: TextAlign.left,
                    style: textTheme.subtitle1.copyWith(color: Colors.white70,
                    fontSize: 24),),
                  ],
                )
              )
            ]
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

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
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: <Widget>[
          _buildInfo(textTheme, Icons.email, 'Email'),
          Container(height: 8,),
          _buildInfoDetail(context, textTheme, globals.onlineUser.email)
            ],
          )
        ),
        Container(height: 24,),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: <Widget>[
          _buildInfo(textTheme, Icons.language, 'Website'),
          Container(height: 8,),
          _buildInfoDetail(context, textTheme, globals.onlineUser.website)
            ],
          )
        ),
        Container(height: 24,),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: <Widget>[
          _buildInfo(textTheme, Icons.phone, 'Phone Number'),
          Container(height: 8,),
          _buildInfoDetail(context, textTheme, globals.onlineUser.phoneNumber)
            ],
          )
        ),
        Container(height: 24,),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: <Widget>[
          _buildInfo(textTheme, Icons.place, 'Address'),
          Container(height: 8,),
          _buildInfoDetail(context, textTheme, globals.onlineUser.address)
            ],
          )
        ),
      ],
    ),
    );
  }
}
