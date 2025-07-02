import 'package:apparel_360/core/app_style/app_callback.dart';
import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:flutter/material.dart';

class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar(
      {super.key,
      required this.searchController,
      required this.showClear,
      required this.clearSearch,
      required this.onChange});

  final TextEditingController searchController;
  final bool showClear;
  final VoidCallback clearSearch;
  final StringToVoidCallBack onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: AppColor.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(30),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search user here...",
          prefixIcon: Icon(Icons.search, color: AppColor.primaryColor),
          suffixIcon: showClear
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[700]),
                  onPressed: clearSearch,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 14.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}
