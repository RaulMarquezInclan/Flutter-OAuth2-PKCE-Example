import 'dart:convert';
import 'package:crypto/crypto.dart';

class Utils {

  static String generateCodeChallenge(String codeVerifier) {
    var bytes = utf8.encode(codeVerifier);
    var digest = sha256.convert(bytes);
    var codeChallenge = base64UrlEncode(digest.bytes);

    if (codeChallenge.endsWith('=')) {
      codeChallenge = codeChallenge.substring(0, codeChallenge.length - 1);
    }

    return codeChallenge;
  }

}