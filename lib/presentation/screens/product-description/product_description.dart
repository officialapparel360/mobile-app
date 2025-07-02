import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/app_style/app_text_style.dart';
import 'package:apparel_360/core/utils/app_helper.dart';
import 'package:apparel_360/data/model/product_model.dart';
import 'package:apparel_360/presentation/screens/product-description/product_description_top_body_widget.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final ProductData catelog;

  const ProductDescription(this.catelog, {super.key});

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Product Description")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductDescriptionTopBodyWidget(catelog: widget.catelog),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.catelog.name ?? "",
                    style: AppTextStyle.getFont20Style(),
                  ),
                  Text(
                    '₹${widget.catelog.price.toString()}',
                    style: AppTextStyle.getFont16Style(),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  "Minimum Order Quantity: ${widget.catelog.stock.toString()}",
                  style: const TextStyle(color: Colors.red, fontSize: 10.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: RichText(
                text: TextSpan(
                  text: 'Highlights: ',
                  style: AppTextStyle.getFont16Style(),
                  children: [
                    TextSpan(
                      text: widget.catelog.shortDetails ?? "",
                      style: AppTextStyle.getFont15Style(
                          fontColor: AppColor.black700),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: RichText(
                text: TextSpan(
                  text: 'About: ',
                  style: AppTextStyle.getFont16Style(),
                  children: [
                    TextSpan(
                      text: widget.catelog.description ?? "",
                      style: AppTextStyle.getFont15Style(
                          fontColor: AppColor.black700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 65.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MaterialButton(
                  color: AppColor.primaryColor,
                  height: 45.0,
                  minWidth: screenSize.width - 52,
                  onPressed: () {
                    AppHelper().showUserListChatDialog(
                        context, AppHelper.chatUserList);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Text(
                    'Chat for this Product',
                    style: AppTextStyle.getFont16Style(
                        fontWeight: FontWeight.w400, fontColor: AppColor.white),
                  )),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
