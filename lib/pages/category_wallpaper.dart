import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_application/models/wall_paper_model.dart';
import 'package:wallpaper_application/network_handler/Network_Handler.dart';
import 'package:wallpaper_application/pages/wallpaper.dart';
import 'package:wallpaper_application/views/single_wallpaper_item.dart';

class Category_Wallpaper extends StatefulWidget {
  final String category_name;

  const Category_Wallpaper({Key key, @required this.category_name})
      : super(key: key);

  @override
  _Category_WallpaperState createState() => _Category_WallpaperState();
}

class _Category_WallpaperState extends State<Category_Wallpaper> {
  NetworkHandler _networkHandler = NetworkHandler();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category_name),
      ),
      body: Container(
        child: FutureBuilder(
          future: _networkHandler.getWallpapers(
              "/v1/search?query=${widget.category_name}&per_page=100&page=1"),
          builder: (BuildContext context,
              AsyncSnapshot<List<WallpaperModel>> snapshot) {
            if (snapshot.hasData) {
              List<WallpaperModel> wallpapers = snapshot.data;
              print(wallpapers.length);
              return Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: wallpapers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .7,
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 2 : 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Wallpaper(
                              wallpaper_url: wallpapers[index].src.portrait,
                            ),
                          ),
                        );
                      },
                      child: Single_Wallpaper_Item(
                        wallpaper: wallpapers[index],
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
