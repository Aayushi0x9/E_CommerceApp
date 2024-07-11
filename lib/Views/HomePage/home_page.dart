import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:e_commerce_app/utils/app_routes_utils.dart';
import 'package:e_commerce_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CategoryProduct {
  String category;

  CategoryProduct({required this.category});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ProductController mutable = Provider.of<ProductController>(context);

    List catallproduct = mutable.allProducts.map((e) => e).toList();
    List allCategory = [];

    mutable.allProducts.forEach((product) {
      allCategory.add(product.category);
    });
    List allcate = allCategory.toSet().toList();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ecommerce App'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cartPage);
                },
                icon: const Icon(Icons.shopping_cart_checkout_rounded)),
          ],
        ),
        body: mutable.allProducts.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: Globals.globals.SearchData,
                      onChanged: (val) =>
                          Globals.globals.SearchData = val ?? 'All',
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {
                                mutable.loadAllProductData();
                              },
                              icon: const Icon(Icons.search)),
                          label: const Text('Search Product'),
                          hintText: 'Search Product',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ))),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Expanded(
                      flex: 2,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: size.height * 0.4,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        items: List.generate(
                          mutable.images.length,
                          (index) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(mutable.images[index]),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Most Featured',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                              value: Globals.globals.Selected,
                              items: [
                                const DropdownMenuItem(
                                  child: Text('All'),
                                  value: 'All',
                                ),
                                ...allcate.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.toString().replaceFirst(
                                          e[0], e[0].toString().toUpperCase()),
                                    ),
                                  );
                                }).toList(),
                              ],
                              onChanged: (val) {
                                Globals.globals.Selected = val as String;
                                mutable.notify();
                              })
                        ]),
                    SizedBox(height: size.height * 0.02),
                    //Products
                    Expanded(
                      flex: 4,
                      child: GridView.builder(
                          itemCount: mutable.allProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2 / 3),
                          itemBuilder: (context, index) => Globals().Selected ==
                                  mutable.allProducts[index].category
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.detailPage,
                                        arguments: index);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: size.height * 0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade400,
                                                offset: const Offset(3, 3),
                                                blurRadius: 4,
                                              ),
                                            ]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Image.network(
                                                mutable.allProducts[index]
                                                    .thumbnail,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              mutable.allProducts[index].title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              mutable.allProducts[index]
                                                  .description,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${mutable.allProducts[index].price} \$',
                                              style: TextStyle(
                                                  color: Colors.green.shade400,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            RatingBar.builder(
                                              initialRating: mutable
                                                  .allProducts[index].rating,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemSize: size.height * 0.025,
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 2, top: 2),
                                        height: size.height * 0.03,
                                        width: size.width * 0.1,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                            topStart: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          '${mutable.allProducts[index].discountPercentage}%',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Globals().Selected == 'All'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.detailPage,
                                            arguments: index);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: size.height * 0.4,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade400,
                                                    offset: const Offset(3, 3),
                                                    blurRadius: 4,
                                                  ),
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Image.network(
                                                    mutable.allProducts[index]
                                                        .thumbnail,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Text(
                                                  mutable
                                                      .allProducts[index].title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  mutable.allProducts[index]
                                                      .description,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '${mutable.allProducts[index].price} \$',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.green.shade400,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: mutable
                                                      .allProducts[index]
                                                      .rating,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemSize: size.height * 0.025,
                                                  onRatingUpdate: (rating) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 2, top: 2),
                                            height: size.height * 0.03,
                                            width: size.width * 0.1,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                topStart: Radius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              '${mutable.allProducts[index].discountPercentage}%',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellow,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container()),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
