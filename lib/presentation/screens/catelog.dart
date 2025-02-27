import 'dart:convert';
import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/presentation/screens/product_discription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Catelog extends StatefulWidget {
  const Catelog({super.key});

  @override
  State<Catelog> createState() => _CatelogState();
}

class _CatelogState extends State<Catelog> {
  List<dynamic> catelog = [];

  @override
  void initState() {
    super.initState();
    _loadCatelogData();
  }

  void _loadCatelogData() async {
    String jsonData = await rootBundle.loadString('assets/raw/catelog.json');
    final catelogJson = json.decode(jsonData);
    catelog = catelogJson['mens_clothes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Catelog",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: catelog.length,
          itemBuilder: (context, index) {
            final product = catelog[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDescription(),
                  )),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.network(
                          product["image_url"],
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/images/placeholder.jpg',
                                  width: double.infinity, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["product_name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "\$${product["discount_price"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "\$${product["price"]}",
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: product["colors"].map<Widget>((color) {
                              return Container(
                                margin: const EdgeInsets.only(right: 4),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: getColorFromName(color),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black, width: 0.5),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case "black":
        return Colors.black;
      case "blue":
        return Colors.blue;
      case "grey":
        return Colors.grey;
      case "white":
        return Colors.white;
      case "brown":
        return Colors.brown;
      case "red":
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
