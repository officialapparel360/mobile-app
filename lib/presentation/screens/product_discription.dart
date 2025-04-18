import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/data/model/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final Datum catelog;

  ProductDescription(this.catelog);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Description")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items:widget.catelog.pictures!.map((url) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/placeholder.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.catelog.pictures!.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Column(
              children: [
                Text(
                  widget.catelog.name??"",
                  style: TextStyle(
                      color: AppColor.black900,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              widget.catelog.description??"",
               style: TextStyle(
                  color: AppColor.black700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Size Available",
                  style: TextStyle(
                      color: AppColor.black700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Color",
                  style: TextStyle(
                      color: AppColor.black700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.catelog.size!.map<Widget>((size) {
                    return Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColor.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: Center(
                        child: Text(
                          size.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: widget.catelog.colors!.map((color){
                   return Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
