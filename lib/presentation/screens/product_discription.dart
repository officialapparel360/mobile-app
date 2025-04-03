import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int _currentIndex = 0;
  final List<String> imageUrls = [
    'https://media.istockphoto.com/id/2176015166/photo/jeans-pant-isolated-on-transparent-background-png-file.webp?s=1024x1024&w=is&k=20&c=rW0pknlTzis9f-aaG4WPkNnD1ZUJXHY8zwfZzP9aq9k=',
    'https://media.istockphoto.com/id/2176015166/photo/jeans-pant-isolated-on-transparent-background-png-file.webp?s=1024x1024&w=is&k=20&c=rW0pknlTzis9f-aaG4WPkNnD1ZUJXHY8zwfZzP9aq9k=',
    'https://media.istockphoto.com/id/2176015166/photo/jeans-pant-isolated-on-transparent-background-png-file.webp?s=1024x1024&w=is&k=20&c=rW0pknlTzis9f-aaG4WPkNnD1ZUJXHY8zwfZzP9aq9k=',
    'https://media.istockphoto.com/id/2176015166/photo/jeans-pant-isolated-on-transparent-background-png-file.webp?s=1024x1024&w=is&k=20&c=rW0pknlTzis9f-aaG4WPkNnD1ZUJXHY8zwfZzP9aq9k=',
    'https://media.istockphoto.com/id/2176015166/photo/jeans-pant-isolated-on-transparent-background-png-file.webp?s=1024x1024&w=is&k=20&c=rW0pknlTzis9f-aaG4WPkNnD1ZUJXHY8zwfZzP9aq9k=',
  ];

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
            items: imageUrls.map((url) {
              return Hero(
                tag: "category_image",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(url,
                      fit: BoxFit.cover, width: double.infinity),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageUrls.asMap().entries.map((entry) {
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
                  "Product Name",
                  style: TextStyle(
                      color: AppColor.black900,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12),
            child: Text(
              "Skinny-but-not-too-skinny, roomy-but-not-too-roomy, the slim fit sits at the sweet spot between skinny jeans and straight leg denim. From your hip to your ankle, it’s a closer, more tailored fit to your body but with enough room to move. It’s modern, it’s polished",
              style: TextStyle(
                  color: AppColor.black700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32),
            child: Text(
              "Size Available",
              style: TextStyle(
                  color: AppColor.black700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColor.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: const Center(
                        child: Text(
                          "S",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColor.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: const Center(
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColor.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: const Center(
                        child: Text(
                          "L",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Color",
                      style: TextStyle(
                          color: AppColor.black900,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 0.5),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColor.black900,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 0.5),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
