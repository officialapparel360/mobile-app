import 'package:apparel_360/data/model/product_model.dart';
import 'package:apparel_360/presentation/screens/full_screen_image_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDescriptionTopBodyWidget extends StatefulWidget {
  const ProductDescriptionTopBodyWidget({super.key, required this.catelog});

  final ProductData catelog;

  @override
  State<ProductDescriptionTopBodyWidget> createState() =>
      _ProductDescriptionTopBodyWidgetState();
}

class _ProductDescriptionTopBodyWidgetState
    extends State<ProductDescriptionTopBodyWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 450.0,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.catelog.pictures!.map((url) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImageWidget(imageUrl: url),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                      'assets/images/placeholder.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover),
                ),
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
      ],
    );
  }
}
