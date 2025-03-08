import 'dart:convert';
import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/presentation/screens/catelog/catelog.dart';
import 'package:apparel_360/presentation/screens/dashboard/bloc/chat_bloc.dart';
import 'package:apparel_360/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> _userData = [];

  @override
  void initState() {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(LoadUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is LoadedUserChat) {
            _userData = state.userDetail;
          }
          return Padding(
            padding: const EdgeInsets.only(top: 64, bottom: 16),
            child: Column(
              children: [
                Container(
                  color: AppColor.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Appreal360",
                          style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Catelog()));
                              },
                              child: Icon(
                                Icons.card_travel,
                                color: AppColor.primaryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.more_vert,
                              color: AppColor.primaryColor,
                              size: 24,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: SearchBar(
                    hintText: "Search",
                    leading: Icon(Icons.search),
                    elevation: null,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _userData.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        _userData[index].profileImage ?? ""),
                                    radius: 30,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _userData[index].name,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _userData[index].lastMessage,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   _userData[index]["timestamp"] ?? "",
                                  //   style: const TextStyle(
                                  //     fontSize: 12,
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
