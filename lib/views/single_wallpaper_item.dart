import 'package:flutter/material.dart';
import 'package:wallpaper_application/models/wall_paper_model.dart';

class Single_Wallpaper_Item extends StatefulWidget {
  final WallpaperModel wallpaper;

  const Single_Wallpaper_Item({Key key, @required this.wallpaper})
      : super(key: key);

  @override
  _Single_Wallpaper_ItemState createState() => _Single_Wallpaper_ItemState();
}

class _Single_Wallpaper_ItemState extends State<Single_Wallpaper_Item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(widget.wallpaper.src.portrait),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
