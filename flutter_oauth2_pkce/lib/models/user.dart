import 'dart:convert';
import 'package:meta/meta.dart';

class User {
  User({
    @required this.name,
    @required this.email,
    @required this.website,
    @required this.phoneNumber,
    @required this.address,
    @required this.pictureUrl,
  });

  String name;
  String email;
  String website;
  String phoneNumber;
  String address;
  String pictureUrl;

  User.fromJson(String json) {
    Map<String, dynamic> userMap = jsonDecode(json);
    this.name = userMap['name'];
    this.email = userMap['email'];
    this.website = userMap['website'];
    this.phoneNumber = userMap['phone_number'];
    this.address = _fullAddress(userMap);
    this.pictureUrl = userMap['picture'];
  }

  String _fullAddress(Map<String, dynamic> userMap) {
    String fullAddress = userMap['address']['street_address'] + ', ' + 
                  userMap['address']['locality'] + ', ' + 
                  userMap['address']['region'] + ', ' + 
                  userMap['address']['postal_code'] + ', ' + 
                  userMap['address']['country'];
    return fullAddress;
  }

}


