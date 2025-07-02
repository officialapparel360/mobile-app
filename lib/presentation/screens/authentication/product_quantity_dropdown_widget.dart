import 'package:apparel_360/core/app_style/app_callback.dart';
import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:flutter/material.dart';

class ProductQuantityDropdownWidget extends StatelessWidget {
  const ProductQuantityDropdownWidget(
      {super.key,
      required this.onChange,
      required this.qtyOptions,
      required this.selectedQty});

  final StringToVoidCallBack onChange;
  final List<String> qtyOptions;
  final String selectedQty;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      child: DropdownButtonFormField<String>(
        value: selectedQty,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(
              color: AppColor.black400,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.black400,
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(
              color: AppColor.black400,
            ),
          ),
        ),
        items: qtyOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text('$value PCS'),
          );
        }).toList(),
        onChanged: (newValue) {
          onChange(newValue!);
        },
      ),
    );
  }
}
