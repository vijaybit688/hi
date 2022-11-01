import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:click2chat/data/urls_of_wallpaper.dart';
import 'package:click2chat/functions/toastMessage.dart';
import 'package:click2chat/functions/wallpaper_setter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

ReceivePort _receivePort = ReceivePort();
int progress = 0;

class Wallpapers extends StatefulWidget {
  Wallpapers({Key? key}) : super(key: key);

  @override
  State<Wallpapers> createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CachedNetworkImage(
                  fit: BoxFit.fill,
                  errorWidget: (a, b, c) {
                    return const Center(
                        child: Text(
                      "Please check Internet Connection",
                      style: TextStyle(fontSize: 24),
                    ));
                  },
                  placeholder: (context, url) {
                    return const SpinKitDoubleBounce(
                      color: Colors.pinkAccent,
                      size: 100,
                    );
                  },
                  height: MediaQuery.of(context).size.width * 1.5,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: urlList[index]),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () async {
                        // Image url

                        var cachedimage = await DefaultCacheManager()
                            .getSingleFile(urlList[index]); //image file

                        int location = WallpaperManagerFlutter
                            .HOME_SCREEN; //Choose screen type

                        WallpaperManagerFlutter().setwallpaperfromFile(
                            cachedimage,
                            location); // Wrap with try catch for error management.
                        toastMessage("Wallpaper Applied To Home Screen");
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8, right: 8),
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(8)),
                        height: 50,
                        child: const Center(
                            child: Text(
                          "Home Screen",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        )),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () async {
                        var cachedimage = await DefaultCacheManager()
                            .getSingleFile(urlList[index]); //image file

                        int location = WallpaperManagerFlutter
                            .LOCK_SCREEN; //Choose screen type

                        WallpaperManagerFlutter().setwallpaperfromFile(
                            cachedimage,
                            location); // Wrap with try catch for error management.
                        toastMessage("Wallpaper Applied To Lock Screen");

                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8, right: 8),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "Lock Screen",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        )),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        List fileName = urlList[index].split("/");
                        String name = fileName.last;
                        downloadTask(context, name, urlList[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8, right: 8),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  static downloadingCallback1(id, status, progress) {
    ///Looking up for a send port
    var sendPort = IsolateNameServer.lookupPortByName("downloading1");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading1");

    ///Listening for the data is comming other isolataes
    // _receivePort1.listen((message) {
    //   setState(() {
    //     progress = message[2];
    //   });
    //
    //   //  print(progress);
    // });

    FlutterDownloader.registerCallback(downloadingCallback1);
  }
  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloading1');
    super.dispose();
  }

}
