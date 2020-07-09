import 'package:flutter/material.dart';
import 'package:flutter_oauth2_pkce/ui/header/diagonally_cut_colored_image.dart';
import 'package:flutter_oauth2_pkce/globals.dart' as globals;

class Header extends StatefulWidget {
  Header(this.title, { this.onTitlePress });
  final String title;
  final Function onTitlePress;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  static const BACKGROUND_IMAGE = 'images/profile_header_background.png';

  Widget _titleButtonDis(
    Function getResource,
    BuildContext context, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white70,
    String title
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60.0),
      child: MaterialButton(
        minWidth: 140.0,
        height: 48,
        color: Colors.green,
        textColor: textColor,
        onPressed: () async {
          await widget.onTitlePress();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Text(title, style: TextStyle(fontSize: 32)),
        ) 
      ),
    );
  }  

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return DiagonallyCutColoredImage(
      Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: const Color.fromRGBO(31, 60, 84, .5),
      );
    }

  Widget _buildAvatar() {
    return Hero(
      tag: 'avatarTagHead',
      child: CircleAvatar(
        backgroundImage: globals.onlineUser.name == '' ? 
          null : NetworkImage(globals.onlineUser.pictureUrl),
        radius: 75.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);    
    return Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.3,
          child: Column(
            children: <Widget>[
              _buildAvatar(),
              Container(height: 24),
              _titleButtonDis(widget.onTitlePress, context, backgroundColor: theme.accentColor, textColor: Colors.white, title: widget.title),
            ],
          ),
        ),
        Positioned(
          top: 48.0,
          left: 4.0,
          child: BackButton(color: Colors.white),
        ),
      ],
    );
  }
}
