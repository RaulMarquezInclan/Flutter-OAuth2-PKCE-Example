import 'package:flutter_oauth2_pkce/globals.dart' as globals;
import 'package:flutter_oauth2_pkce/Models/products.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_oauth2_pkce/Models/user.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_oauth2_pkce/Utils.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class APIServices {

  static HttpClient httpClient = HttpClient();

  static loginWithOktaPKCE() async {
    try {

      // Generate the code verifier and challenge
      String codeVerifier = randomAlphaNumeric(44);
      String codeChallenge = Utils.generateCodeChallenge(codeVerifier);
      String state = randomAlphaNumeric(16);
      String issuerHost = Uri.parse(globals.issuer).host;
      
      // Generate the authorization url
      final authUrl = Uri.https(issuerHost, globals.authorizePath, {
        'response_type': globals.responseType,
        'client_id': globals.clientId,
        'redirect_uri': globals.redirectUri,
        'scope': globals.scopes,
        'code_challenge': codeChallenge,
        'code_challenge_method': globals.codeChallengeMethod,
        'state': state,
      }).toString();

      // Present the login dialog to the user
      final result = await FlutterWebAuth.authenticate(url: authUrl, callbackUrlScheme: globals.customUriScheme);

      // Extract authorization code from redirect url
      final authCode = Uri.parse(result).queryParameters['code'];

      // Use auhtorization code to get an access token
      final response = await http.post(globals.tokenUrl, body: {
        'client_id': globals.clientId,
        'redirect_uri': globals.redirectUri,
        'grant_type': globals.grantType,
        'code': authCode,
        'code_verifier': codeVerifier,
      });

      // Get the access token from the response
      final accessToken = jsonDecode(response.body)['access_token'] as String;
      final idToken = jsonDecode(response.body)['id_token'] as String;

      globals.codeVerifier = codeVerifier;
      globals.codeChallenge = codeChallenge;
      globals.authCode = authCode;
      globals.accessToken = accessToken;
      globals.idToken = idToken;
      globals.jsonAccessToken = prettyJson(Jwt.parseJwt(globals.accessToken), indent: 2);
      globals.state = state;
      globals.fullAuthurl = authUrl;

    } catch (e) {
      print(e.toString());
    }
  }

  static Future getUser() async {
    if (globals.accessToken != null) {
      var request = await httpClient.postUrl(Uri.parse(globals.userInfoUrl));
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ${globals.accessToken}');
      var response = await request.close();
    
      await for (var contents in response.transform(Utf8Decoder())) {
        var resp = json.decode(contents);
        globals.onlineUserFetch = resp['name'] != null;
        if (globals.onlineUserFetch) {
          globals.onlineUser = User.fromJson(contents);
        }
        print(contents);
      }
    }
  }
  
  static getProducts() async {
    try {
      String url = 'http://10.0.2.2:5000/api/Products?client_id=${globals.clientId}';
      Uri uri = Uri.parse(url);
      HttpClient client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 3);
      var request = await client.getUrl(uri);
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ${globals.accessToken}');
      var response = await request.close();

      await for (var contents in response.transform(Utf8Decoder())) {
        var resp = json.decode(contents);
        globals.productsFetch = resp['success'];
        var prodsMap = resp['products'];
        print(prodsMap.toString());
        globals.productsList = List<Product>.from(prodsMap.map((i) => Product.fromJson(i)));
      }
    } catch(e) {
      print(e.toString());
    }
  }
}
