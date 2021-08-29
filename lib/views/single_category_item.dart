import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Single_Category_Item extends StatefulWidget {
  final String category_image, category_name;

  const Single_Category_Item(
      {Key key, @required this.category_image, @required this.category_name})
      : super(key: key);

  @override
  _Single_Category_ItemState createState() => _Single_Category_ItemState();
}

class _Single_Category_ItemState extends State<Single_Category_Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  widget.category_image,
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: 150,
          ),
          Container(
            height: 150,
            child: Center(
              child: Text(
                widget.category_name,
                style: GoogleFonts.podkova(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
