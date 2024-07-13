import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:e_commerce_app/exe.dart';
import 'package:e_commerce_app/utils/app_routes_utils.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '${mutable.allProducts[index].title}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cartPage);
              },
              icon: const Icon(Icons.shopping_cart_checkout_rounded)),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: size.height * 0.3,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: List.generate(
                mutable.allProducts[index].images.length,
                (i) => Container(
                      child: Center(
                        child: Image.network(
                            mutable.allProducts[index].images[i],
                            fit: BoxFit.cover,
                            width: 1000),
                      ),
                    )).toList(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(46),
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(45)),
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
                      Expanded(
                        child: Text(
                          '${mutable.allProducts[index].title}',
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
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
                  Row(
                    children: [
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
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        '(${mutable.allProducts[index].rating})',
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 0.6,
                  ),
                  10.ofHeight,
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.ofWidth,
                          Text(
                            '${mutable.allProducts[index].description}',
                            // maxLines: 4,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.ofHeight,
                          const Text(
                            'About Product',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${mutable.allProducts[index].category.toString().replaceFirst(mutable.allProducts[index].category[0], mutable.allProducts[index].category[0].toString().toUpperCase())} Product',
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
                                fontSize: 14, color: Colors.blueAccent),
                          ),
                          5.ofHeight,
                          const Text(
                            'Dimention',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Width\t\t',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                TextSpan(
                                  text:
                                      '\t\t${mutable.allProducts[index].dimensions.width}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                const TextSpan(
                                  text: '\nHeight\t\t',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '\t\t${mutable.allProducts[index].dimensions.height}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                const TextSpan(
                                  text: '\nDepth\t\t',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '\t\t${mutable.allProducts[index].dimensions.depth}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                const TextSpan(
                                  text: '\n\nReview ⭐',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ...List.generate(
                            mutable.allProducts[index].reviews.length,
                            (i) => ListTile(
                              leading: const CircleAvatar(
                                maxRadius: 50,
                                child: Icon(Icons.person),
                              ),
                              title: Text(
                                  '${mutable.allProducts[index].reviews[i].reviewerName}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: double.parse(mutable
                                            .allProducts[index]
                                            .reviews[i]
                                            .rating
                                            .toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemSize: size.height * 0.02,
                                        onRatingUpdate: (rating) {},
                                      ),
                                      4.ofWidth,
                                      Text(
                                        '(${mutable.allProducts[index].rating})',
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '${mutable.allProducts[index].reviews[i].comment}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          mutable.cartProducts.contains(mutable.allProducts[index])
              ? mutable.cartProducts.remove(mutable.allProducts[index])
              : mutable.cartProducts.add(mutable.allProducts[index]);

          mutable.cartProducts.contains(mutable.allProducts[index])
              ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Remove from Cart!'),
                  backgroundColor: Colors.red,
                ))
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to Cart!'),
                    backgroundColor: Colors.green,
                  ),
                );
          mutable.notify();
        },
        label: Text(
            '${mutable.cartProducts.contains(mutable.allProducts[index]) ? 'Remove From Cart' : 'Add to Cart'}'),
        icon: Icon(
          mutable.cartProducts.contains(mutable.allProducts[index])
              ? Icons.remove_shopping_cart_rounded
              : Icons.add_shopping_cart_rounded,
        ),
      ),
    );
  }
}
