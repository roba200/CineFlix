import 'package:cineflix/Model/Movie.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/screens/home_screen.dart';
import 'package:cineflix/screens/movie_screen.dart';
import 'package:cineflix/screens/search_screen.dart';
import 'package:cineflix/screens/start_screen.dart';
import 'package:cineflix/screens/tv_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late List<Movie> movieList;

  void fetchData() {}

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Widget> _tabs = [HomeScreen(), MovieScreen(), TVScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: SizedBox(
            width: 400,
            child: TabBar(
              controller: _tabController,
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              labelColor: white,
              padding: EdgeInsets.only(top: 10),
              indicatorPadding: EdgeInsets.only(bottom: -15),
              indicatorColor: red,
              unselectedLabelColor: white,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Movies'),
                Tab(text: 'TV shows'),
              ],
            ),
          ),
          // bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(1.0),
          //     child: Container(
          //       color: grey,
          //       height: 0.5,
          //     )),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: Icon(
                  Icons.search,
                  color: white,
                  size: 30,
                )),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              child: CircleAvatar(),
              onTap: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const StartScreen();
                }), (route) => false);
              },
            ),
            SizedBox(
              width: 120,
            )
          ],
          leadingWidth: 400,
          toolbarHeight: 90,
          elevation: 0,
          leading: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png"))),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color.fromARGB(255, 19, 19, 19)),
          child: TabBarView(
            controller: _tabController,
            children: _tabs,
          ),
        ));
  }
}
