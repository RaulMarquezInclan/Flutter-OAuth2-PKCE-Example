import 'package:flutter/material.dart';

buildDrawer(BuildContext context) {
    return ClipPath(
      clipper: MenuClipper(),
      child: Container(
          padding: EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
            color: Colors.blue[700],
            boxShadow: [BoxShadow(color: Colors.black45)]
          ),
          width: 300.0,
          height: double.maxFinite,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Container(
                height: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue[200], Colors.blue[700]]
                  )
                ),
                child: CircleAvatar(
                  radius: 40,
                  child: Text('PLA', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[200])),
                ),
              ),
              SizedBox(height: 30.0),
              _buildRow(context, Icons.person_pin, "Your profile", "/profilepage"),
              _buildDivider(),
              _buildRow(context, Icons.phone_iphone, "Products", "/productspage"),
              _buildDivider(),
              _buildRow(context, Icons.info_outline, "Auth Info", "/authinfopage"),
              _buildDivider(),              
            ],
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: Colors.blue[200],
  );
}

  Widget _buildRow(BuildContext context, icon, String title, String namedRoute) {
  final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

  return FlatButton(
    onPressed: () {
      Navigator.pushNamed(context, namedRoute);
    },
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(children: [
      Icon(icon, color: Colors.blue[200]),
      SizedBox(width: 10.0),
      Text(
        title,
        style: tStyle,
      ),
    ]),
  );
}

class MenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width-40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height/2);
    path.quadraticBezierTo(
        size.width, size.height - (size.height / 4), size.width-40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}