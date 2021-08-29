import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_application/network_handler/Network_Handler.dart';
import 'package:wallpaper_application/pages/category_wallpaper.dart';
import 'package:wallpaper_application/pages/search_wallpaper.dart';
import 'package:wallpaper_application/views/single_category_item.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key key}) : super(key: key);

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  NetworkHandler _networkHandler = NetworkHandler();
  List category_data = new List();
  Future<String> load_category_data() async {
    var json_text =
        await rootBundle.loadString('assets/data/category_data.json');
    setState(() {
      category_data = jsonDecode(json_text);
    });
  }

  TextEditingController search_text = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.load_category_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper Application"),
        elevation: 0.0,
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(left: 10, right: 10, top: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 22),
                        controller: search_text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                Search_Wallpaper(search_text: search_text.text),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.search,
                        size: 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemCount: category_data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(category_data[index]['category_name']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Category_Wallpaper(
                            category_name: category_data[index]
                                ['category_name'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Single_Category_Item(
                        category_image: category_data[index]['category_image'],
                        category_name: category_data[index]['category_name'],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
