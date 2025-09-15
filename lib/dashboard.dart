import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bloc/auth_bloc.dart';
import 'utils/app_fonts.dart';
import 'utils/string_utils.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<String> _futureTask() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    return 'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvam9iNjg0LTI0NS12LmpwZw.jpg?w=500';
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Dashboard",
          style: retrieveRequiredFonts(
            AppFonts.title,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authBloc.localStorage.setBool(
                StringUtils.isUserLoggedInKey,
                false,
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                ModalRoute.withName('/'),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: CarouselSlider(
                    items: [Image.asset('assets/images/ic_icon.png')],
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 20, // dynamic user data
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      shadowColor: Colors.green,
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Card Title"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: StreamBuilder<String>(
                              stream: Stream.fromFuture(_futureTask()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Container(
                                    color: Colors.red,
                                  );
                                } else {
                                  return SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.network(
                                      '${snapshot.data}',
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
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
