import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oauth2_pkce/api_services.dart';
import 'package:flutter_oauth2_pkce/globals.dart' as globals;

class AuthInfoPage extends StatefulWidget {
  AuthInfoPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AuthInfoPageState createState() => _AuthInfoPageState();
}

class _AuthInfoPageState extends State<AuthInfoPage> {
  
  @override
  Widget build(BuildContext context) {
    var titleColor = Colors.white60;
    var uriColor = Colors.yellow;
    var paramColor = Colors.cyan[50];

    TextStyle _paramTextStyle() {
      return TextStyle(color: paramColor);
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 60, 84, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 70,),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Get New Token'),
                            onPressed: () async {
                              await APIServices.loginWithOktaPKCE();
                              setState(() { });
                            }
                          ),
                        Container(height: 24,),
                      ],)
                    ),

                    Text('Authorize URL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: titleColor),),
                    Text(globals.authorizeUrl, style: TextStyle(color: uriColor),),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Query Parameters', style: TextStyle(fontSize: 18, color: paramColor),),
                          Text('response_type: ${globals.responseType}', style: _paramTextStyle(),),
                          Text('client_id: ${globals.clientId}', style: _paramTextStyle(),),
                          Text('redirect_uri: ${globals.redirectUri}', style: _paramTextStyle(),),
                          Text('scope: ${globals.scopes}', style: _paramTextStyle(),),
                          Text('code_challenge: ${globals.codeChallenge}', style: _paramTextStyle(),),
                          Text('code_challenge_method: ${globals.codeChallengeMethod}', style: _paramTextStyle(),),
                          Text('state: ${globals.state}', style: _paramTextStyle(),),
                        ],
                      ),
                    ),

                    Container(height: 24,),

                    Text('Token URL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: titleColor),),
                    Text(globals.tokenUrl, style: TextStyle(color: uriColor),),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Query Parameters', style: TextStyle(fontSize: 18, color: paramColor),),
                          Text('client_id: ${globals.clientId}', style: _paramTextStyle(),),
                          Text('redirect_uri: ${globals.redirectUri}', style: _paramTextStyle(),),
                          Text('grant_type: ${globals.grantType}', style: _paramTextStyle(),),
                          Text('code: ${globals.authCode}', style: _paramTextStyle(),),
                          Text('code_verifier: ${globals.codeVerifier}', style: _paramTextStyle(),),
                        ],
                      ),
                    ),

                    Container(height: 24,),

                    Text('Authorization Code', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: titleColor),),
                    globals.authCode == null ? Icon(Icons.do_not_disturb_alt, color: Colors.white30,) : 
                    Text(globals.authCode, style: TextStyle(color: Colors.blue),),
                    Container(height: 24,),

                    Text('Access Token (JWT)', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: titleColor),),
                    globals.accessToken == null ? Icon(Icons.do_not_disturb_alt, color: Colors.white30,) : 
                    Text(globals.accessToken, style: TextStyle(color: Colors.green),),
                    Container(height: 24,),

                    Text('Decoded Access Token (JSON)', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: titleColor),),
                    globals.jsonAccessToken == null ? Icon(Icons.do_not_disturb_alt, color: Colors.white30,) : 
                    Text(globals.jsonAccessToken, style: TextStyle(color: Colors.amber, fontSize: 12),),

                  ],
                ),
              ),
            ),
          ),
            
          Positioned(
            top: 48.0,
            left: 4.0,
            child: BackButton(color: Colors.white),
          ),
        ],
      ),
    );
  }
}