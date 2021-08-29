import 'package:flutter/material.dart';
import 'package:wallpaper_application/models/wall_paper_model.dart';
import 'package:wallpaper_application/network_handler/Network_Handler.dart';
import 'package:wallpaper_application/views/single_wallpaper_item.dart';

class Search_Wallpaper extends StatefulWidget {
  final String search_text;

  const Search_Wallpaper({Key key, @required this.search_text})
      : super(key: key);

  @override
  _Search_WallpaperState createState() => _Search_WallpaperState();
}

class _Search_WallpaperState extends State<Search_Wallpaper> {
  NetworkHandler _networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result for ${widget.search_text}"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _networkHandler.getWallpapers(
              "/v1/search?query=${widget.search_text}&per_page=100&page=1"),
          builder: (BuildContext context,
              AsyncSnapshot<List<WallpaperModel>> snapshot) {
            if (snapshot.hasData) {
              List<WallpaperModel> wallpapers = snapshot.data;
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
                    return Single_Wallpaper_Item(
                      wallpaper: wallpapers[index],
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
