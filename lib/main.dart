import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List musicList = [
    {
      "title": "What Makes You Beautiful",
      "artist": "One Direction",
      "album": "Up All Night",
      "cover": "https://pbs.twimg.com/media/EeB8o3NWkAUygGZ.jpg",
    },
    {
      "title": "What Makes You Beautiful",
      "artist": "One Direction",
      "album": "Up All Night",
      "cover": "https://pbs.twimg.com/media/EeB8o3NWkAUygGZ.jpg",
    },
    {
      "title": "What Makes You Beautiful",
      "artist": "One Direction",
      "album": "Up All Night",
      "cover": "https://pbs.twimg.com/media/EeB8o3NWkAUygGZ.jpg",
    },
    {
      "title": "What Makes You Beautiful",
      "artist": "One Direction",
      "album": "Up All Night",
      "cover": "https://pbs.twimg.com/media/EeB8o3NWkAUygGZ.jpg",
    },
  ];

  Widget slider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Slider.adaptive(
          activeColor: Colors.white,
          inactiveColor: Colors.grey[350],
          value: 1000,
          max: 1000,
          onChanged: (value) {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff000000),
              Color(0xffffffff),
              Color(0xff000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 22.0,
                  right: 22.0,
                  top: 15.0,
                  bottom: 15.0,
                ),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Music Player",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search Artist', border: InputBorder.none),
                      // onChanged: onSearchTextChanged,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: musicList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
                      child: Card(
                        color: const Color(0xff000000),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              musicList[index]["cover"],
                            ),
                          ),
                          title: Text(
                            musicList[index]["title"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                musicList[index]["artist"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                musicList[index]["album"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.all(17.0),
                            child: Icon(
                              Icons.music_note,
                              color: Colors.blueGrey.shade200,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  slider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 40.0,
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        iconSize: 40.0,
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
