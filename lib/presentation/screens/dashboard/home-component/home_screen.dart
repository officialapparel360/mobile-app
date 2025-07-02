import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/utils/app_helper.dart';
import 'package:apparel_360/data/model/user_model.dart';
import 'package:apparel_360/presentation/screens/dashboard/home-component/home_screen_search_bar.dart';
import 'package:apparel_360/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchUserData = [];
  List<dynamic> originalUserData = [];

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ChatBloc>(context);
    getUserList();
    getUserDetail();
  }

  void getUserList() async {
    senderId = await SharedPrefHelper.getUserId();
    bloc.add(LoadedUserList(senderId: senderId));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: HomeScreenSearchBar(
                  clearSearch: () {
                    searchController.text = '';
                  },
                  searchController: searchController,
                  showClear: searchController.text.isNotEmpty,
                  onChange: (value) {
                    if (searchController.text.isEmpty) {
                      bloc.add(
                          SearchUserListEvent(filteredData: originalUserData));
                    } else {
                      searchUserData = _userData
                          .where((item) =>
                              item.name
                                  .toLowerCase()
                                  .contains(value.toString().toLowerCase()) ||
                              item.mobileNo.contains(value.toString()))
                          .toList();
                      bloc.add(
                          SearchUserListEvent(filteredData: searchUserData));
                    }
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: BlocConsumer<ChatBloc, ChatState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is ChatLoadSuccessState) {
                        AppHelper.chatUserList = [];
                        AppHelper.chatUserList = state.userDetail;
                        _userData = state.userDetail;
                        originalUserData = state.userDetail;
                      }
                      if (state is SearchUserListState) {
                        _userData = state.filteredList;
                      }
                    },
                    builder: (context, state) {
                      if (state is UserListLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (_userData.isEmpty) {
                        return const Center(
                          child: Text(
                            "No dealer is assigned yet.",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        );
                      }
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _userData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () {
                                _navigateToChatScreen(
                                    _userData[index].mappedUserId,
                                    senderId,
                                    _userData[index].mobileNo,
                                    _userData[index].name);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 50.0,
                                        width: 50.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: CachedNetworkImage(
                                            imageUrl: getProfileImage(
                                                _userData[index]),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getChatName(_userData[index]),
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
                                      // getStatusWidget(_userData[index].status),
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
      ),
    );
  }

  String getChatName(UserDetail userDetail) {
    if (userDetail.name?.isNotEmpty ?? false) {
      return userDetail.name ?? '';
    } else if (userDetail.shopName?.isNotEmpty ?? false) {
      return userDetail.shopName ?? '';
    } else {
      return '';
    }
  }

  String getProfileImage(UserDetail userDetail) {
    String defaultImage =
        'https://www.bootdey.com/img/Content/avatar/avatar7.png';
    if (userDetail.profilePicPath?.isNotEmpty ?? false) {
      return userDetail.profilePicPath ?? defaultImage;
    } else {
      return defaultImage;
    }
  }

  Future<void> _navigateToChatScreen(String receiverId, String senderId,
      String mobileNumber, String name) async {
    if (mounted) {
      Navigator.pushNamed(context, Routes.chatScreen, arguments: {
        'receiverId': receiverId,
        'senderId': senderId,
        'mobileNumber': mobileNumber,
        'name': name
      });
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

  getUserDetail() async {
    var userId = await SharedPrefHelper.getUserId();
    print('this is your id: ${userId}');
  }
}
