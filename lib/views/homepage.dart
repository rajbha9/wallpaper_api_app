import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:wallpaper_api_app/helper/api_helper.dart';
import '../models/photo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    await APIHelper.apiHelper.fetchphotos().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'asset/img/1.jpg',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: GlassmorphicContainer(
              alignment: Alignment.center,
              blur: 10,
              height: MediaQuery.of(context).size.height / 3.5,
              width: double.infinity,
              borderRadius: 100,
              border: 0.1,
              linearGradient: LinearGradient(
                colors: [
                  Colors.black87.withOpacity(0.5),
                  Colors.orange.withOpacity(0.3),
                  Colors.black87.withOpacity(0.1),
                ],
                stops: const [
                  0.2,
                  0.8,
                  1,
                ],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.withOpacity(0.5),
                  Colors.orange.withOpacity(0.1),
                ],
              ),
              child: Text(
                'Wallpager App',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              )),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: GlassmorphicContainer(
                  alignment: Alignment.center,
                  blur: 10,
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  borderRadius: 20,
                  border: 0.1,
                  linearGradient: LinearGradient(
                    colors: [
                      Colors.black87.withOpacity(0.5),
                      Colors.black87.withOpacity(0.1),
                    ],
                    stops: const [
                      0.2,
                      1,
                    ],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.5),
                      const Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      onChanged: (val) async {
                        await APIHelper.apiHelper
                            .fetchphotos(val)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                        hintText: "Search",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 10,
                child: FutureBuilder(
                  future: APIHelper.apiHelper.fetchphotos(),
                  builder: (context, snapshot) {
                    List<Photo>? data;

                    (snapshot.hasError)
                        ? print(snapshot.error)
                        : snapshot.hasData
                            ? data = snapshot.data as List<Photo>?
                            : const CircularProgressIndicator();

                    return (data == null)
                        ? Container()
                        : GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 3 / 4),
                            children: data
                                .map(
                                  (e) => Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                          image: NetworkImage(e.photo),
                                          fit: BoxFit.cover),
                                    ),
                                    alignment: Alignment.bottomRight,
                                    child: FloatingActionButton(
                                      mini: true,
                                      onPressed: () async {
                                        await AsyncWallpaper.setWallpaper(
                                          url: e.photo,
                                          wallpaperLocation:
                                              AsyncWallpaper.BOTH_SCREENS,
                                        );
                                      },
                                      child: const Icon(Icons.wallpaper),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
