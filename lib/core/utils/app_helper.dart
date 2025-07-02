import 'package:apparel_360/data/prefernce/shared_preference.dart';
import 'package:apparel_360/routes.dart';
import 'package:flutter/material.dart';

class AppHelper {
  static List<dynamic> chatUserList = [];

  void showFullScreenLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
      barrierColor: Colors.black.withOpacity(0.5), // dim background
    );
  }

  void showUserListChatDialog(BuildContext context, List<dynamic> userList) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxHeight: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Start Chat With...",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      var user = userList[index];
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            user.name,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "${user.mobileNo ?? ''}",
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 18, color: Colors.grey),
                          onTap: () async {
                            Navigator.pop(context);
                            var senderId = await SharedPrefHelper.getUserId();
                            Navigator.pushNamed(context, Routes.chatScreen,
                                arguments: {
                                  'receiverId':
                                      userList[index].mappedUserId.toString(),
                                  'senderId': senderId.toString(),
                                  'mobileNumber':
                                      userList[index].mobileNo.toString(),
                                  'name': userList[index].name.toString()
                                });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
