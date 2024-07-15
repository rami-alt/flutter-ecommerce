// featured_products_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../domain/entities/product.dart';
import 'full_screen.dart';

class FeaturedProductsGrid extends StatelessWidget {
  final List<Product> products;

  const FeaturedProductsGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: 142,
            child: Card(
              color: Color(0xFFFFFFFF),
              // shape: Border.all(style: BorderStyle.none),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => FullScreenImageScreen(
                              imageUrl: product.images![0],
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: FadeInImage(
                          image: NetworkImage(product.images![0]),
                          placeholder: const AssetImage("Images/default.png"),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'Images/default.png',
                              fit: BoxFit.cover,
                              width: 140,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(product.description ?? "No title",
                            maxLines: 3,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                        Text('\$${product.price?.toStringAsFixed(2)}',
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.black)),
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
  }
}
