import 'dart:math';

import 'package:boroadwy_2025_session1/bloc/dashboard_bloc.dart';
import 'package:boroadwy_2025_session1/bloc/dashboard_event.dart';
import 'package:boroadwy_2025_session1/bloc/dashboard_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'utils/app_fonts.dart';
import 'utils/string_utils.dart';

class Dashboard extends StatelessWidget {
  Future<String> _futureTask() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    return 'https://via.placeholder.com/600/92c952';
  }

  List<String> categories = [
    'Rice',
    'Dal',
    'Snacks',
    'Others',
    'Momos',
    'Junkes'
  ];

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(FetchPostEvents());
    final authBloc = context.read<AuthBloc>();
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
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              context.read<AuthBloc>().localStorage.setBool(
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
          IconButton(
              onPressed: () async {
                final db = FirebaseFirestore.instance;
                // int i = 0;
                // for (Map<String, dynamic> datas
                //     in authBloc.database.getProducts()) {
                //   i++;
                //   db.collection("products").doc("$i").set(datas);
                // }

                db.collection('products').doc('1').get().then((value) {
                  print(value.data());
                });
              },
              icon: Icon(Icons.storage))
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
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (_, index) {
                      return TextButton(
                        onPressed: () {
                          context
                              .read<DashboardBloc>()
                              .add(CategoryItemClickEvent(categories[index]));
                          debugPrint("${categories[index]} clicked!!");
                        },
                        child: Text(categories[index]),
                      );
                    }),
              ),
              BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                if (state is ProductFetchedState) {
                  var products = state.productLists;
                  return Expanded(
                    child: GridView.builder(
                      itemCount: products.length, // dynamic user data
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
                              Text(products[index].name ?? ''),
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
                  );
                } else if (state is ErrorState) {
                  return AlertDialog(
                    title: Text("Error showing data"),
                    content:
                        Text("There are no products added for given category"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"))
                    ],
                  );
                } else if (state is DasboardInitial) {
                  return CircularProgressIndicator();
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
