import 'dart:convert';
import 'package:apparel_360/core/services/signalR_service.dart';
import 'package:apparel_360/core/utils/show_custom_toast.dart';
import 'package:apparel_360/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/base_client.dart';
import '../../../../core/network/repository.dart';
import '../../../../data/prefernce/shared_preference.dart';
import '../chat-component/chat_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _userData = [];
  final repository = NetworkRepository(BaseClient());
  var senderId;
  late ChatBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ChatBloc>(context);
    getUserList();
  }

  void getUserList() async {
    senderId = await SharedPrefHelper.getUserId();
    bloc.add(LoadedUserList(senderId: senderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 16),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if(state is ChatLoadSuccessState){
                      _userData = state.userDetail;
                    }
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _userData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            highlightColor: Colors.transparent,
                            onTap: () {
                              _navigateToChatScreen(
                                  _userData[index].mappedUserId, senderId);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://randomuser.me/api/portraits/men/1.jpg" ??
                                              ""),
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
                                            _userData[index].mobileNo ?? "",
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    getStatusWidget(_userData[index].status),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToChatScreen(String receiverId, String senderId) async {
    SignalRService signalRService = SignalRService();
    bool isConnected = await signalRService.connect();
    if (mounted) {
      if (isConnected) {
        Navigator.pushNamed(context, Routes.chatScreen, arguments: {
          'receiverId': receiverId,
          'senderId': senderId,
        });
      } else {
        CustomToast.showToast(
            context, 'Something went wrong while making connecting to user!');
      }
    }
  }

  Widget getStatusWidget(String statue) {
    switch (statue.toLowerCase()) {
      case 'online':
        return const Icon(Icons.circle, color: Colors.green, size: 16);
      case 'offline':
        return const Icon(Icons.circle, color: Colors.grey, size: 16);
      default:
        return Icon(Icons.help, color: Colors.blue, size: 16);
    }
  }
}
