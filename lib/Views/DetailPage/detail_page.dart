import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    int index = ModalRoute.of(context)!.settings.arguments as int;
    ProductController mutable = Provider.of<ProductController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${mutable.allProducts[index].title}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: size.height * 0.4,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: List.generate(
                mutable.allProducts[index].images.length,
                (index) => Container(
                      child: Center(
                        child: Image.network(
                            mutable.allProducts[index].images[index],
                            fit: BoxFit.cover,
                            width: 1000),
                      ),
                    )).toList(),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(46),
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0, -3),
                      blurRadius: 5,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${mutable.allProducts[index].title}',
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$ ${mutable.allProducts[index].price}',
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    '${mutable.allProducts[index].description}',
                    // maxLines: 4,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${mutable.allProducts[index].category} Product',
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${mutable.allProducts[index].brand} Brand',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${mutable.allProducts[index].returnPolicy}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: mutable.allProducts[index].rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemSize: size.height * 0.035,
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ),
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     // add to cart logic here
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text('Added to cart!')),
          //     );
          //   },
          //   child: Text('Add to Cart'),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Add To Cart'),
        icon: Icon(Icons.add_shopping_cart_rounded),
      ),
    );
  }
}
