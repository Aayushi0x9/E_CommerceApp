import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:e_commerce_app/utils/app_routes_utils.dart';
import 'package:e_commerce_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ProductController mutable = Provider.of<ProductController>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Ecommerce App'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cartPage);
                },
                icon: Icon(Icons.shopping_cart_checkout_rounded)),
          ],
        ),
        body: mutable.allProducts.isNotEmpty
            ? Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                              Duration(milliseconds: 800),
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
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    // ...List.generate(
                    //     mutable.allCategory.length,
                    //     (index) => Column(
                    //           children: [
                    //             CircleAvatar(
                    //               maxRadius: 50,
                    //               // child: Image.network(
                    //               //     mutable.allCategory[index].thumbnail),
                    //             ),
                    //             Text(mutable.allCategory[index].title),
                    //           ],
                    //         )),
                    TextFormField(
                      initialValue: Globals.globals.SearchData,
                      onChanged: (val) =>
                          Globals.globals.SearchData = val ?? 'All',
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {
                                mutable.loadAllProductData();
                              },
                              icon: Icon(Icons.search)),
                          label: Text('Search Product'),
                          hintText: 'Search Product',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ))),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      'Most Featured',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Expanded(
                      flex: 4,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2 / 3),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.detailPage,
                                arguments: index);
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height: size.height * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade400,
                                        offset: const Offset(3, 3),
                                        blurRadius: 4,
                                      ),
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        mutable.allProducts[index].thumbnail,
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
                                      mutable.allProducts[index].description,
                                      style: TextStyle(color: Colors.grey),
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
                                      initialRating:
                                          mutable.allProducts[index].rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => const Icon(
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
                                padding: EdgeInsets.only(left: 2, top: 2),
                                height: size.height * 0.03,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${mutable.allProducts[index].discountPercentage}%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
