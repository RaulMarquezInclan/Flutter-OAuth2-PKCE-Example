library flutter_oauth2_pkce.globals;
import 'package:flutter_oauth2_pkce/Models/user.dart';
import 'package:flutter_oauth2_pkce/Models/products.dart';
import 'dart:core';

// PKCE Flow variables
String clientId = '0oaeqlypy2lB7Bv1b4x6';
String customUriScheme = 'domain.company.pkce';
String issuer = 'https://dev-371167.okta.com';
String authorizePath = '/oauth2/default/v1/authorize';
String authorizeUrl = '$issuer$authorizePath';
String redirectUri = '$customUriScheme:/callback';
String tokenUrl = '$issuer/oauth2/default/v1/token';
String userInfoUrl = '$issuer/oauth2/default/v1/userinfo';
String productsUrl = 'http://10.0.2.2:5000/api/Product';
String revokeUrl = '$issuer/oauth2/default/v1/revoke';
List<String> scopesList = [
                           'openid', 
                           'email', 
                           'profile', 
                           'phone', 
                           'address', 
                           'products',
                           ];
String scopes = scopesList.join(' ');
String codeChallengeMethod = 'S256';
String grantType = 'authorization_code';
String responseType = 'code';
String codeVerifier;
String codeChallenge;
String authCode;
String accessToken;
String jsonAccessToken;
String idToken;
String state;
String fullAuthurl;

// Control variables
bool onlineUserFetch = false;
User onlineUser = User(name: '', email: '', website: '', phoneNumber: '', address: '', pictureUrl: '');

bool productsFetch = false;
List<Product> productsList = List<Product>();


