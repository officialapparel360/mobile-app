import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/presentation/screens/catelog/bloc/catelog_bloc.dart';
import 'package:apparel_360/presentation/screens/product-description/product_description.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Catelog extends StatefulWidget {
  const Catelog({super.key});

  @override
  State<Catelog> createState() => _CatelogState();
}

class _CatelogState extends State<Catelog> {
  List<dynamic> catelog = [];
  late CatelogBloc bloc;

  @override
  void initState() {
    super.initState();
    initialiseEvents();
  }

  void initialiseEvents() {
    bloc = CatelogBloc(CatelogInitial());
    bloc.add(LoadedCatelogData());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<CatelogBloc, CatelogState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CatelogLoadedState) {
            for (var item in state.data) {
              if (item.isNew == 0) {
                catelog.add(item);
              }
            }
          }
        },
        builder: (context, state) {
          if (state is CatelogInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.5,
              ),
              itemCount: catelog.length,
              itemBuilder: (context, index) {
                final product = catelog[index];
                double productPrice = product.price;
                double productDiscountedPrice = product.salePrice;
                String productPriceString = productPrice.toStringAsFixed(0);
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDescription(catelog[index]),
                      )),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenSize.width * 0.7,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: product.pictures[0],
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                    'assets/images/placeholder.jpg',
                                    width: double.infinity,
                                    fit: BoxFit.cover);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product.shortDetails,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black38),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Flexible(
                                    child: Text(
                                      'Price:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "₹$productPriceString ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "MOQ: ${product.stock.toString()}",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 10.5),
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
          );
        },
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
