import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:e_commerce_app/Views/AccountPAge/accountpage.dart';
import 'package:e_commerce_app/Views/CartPage/cart_page.dart';
import 'package:e_commerce_app/Views/HomePage/Component/allproduct.dart';
import 'package:e_commerce_app/Views/HomePage/Component/catProduct.dart';
import 'package:e_commerce_app/Views/LikedPage/likedpage.dart';
import 'package:e_commerce_app/utils/app_routes_utils.dart';
import 'package:e_commerce_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Selected = 'All';
  RangeValues slidervalue = RangeValues(0, 5000);

  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(
    index,
  ) {
    selectedIndex = index;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LikedPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
        break;
    }
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ProductController mutable = Provider.of<ProductController>(context);

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
                    // onChanged: (val) => Globals.globals.SearchData = val,
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
                        Visibility(
                          visible: Selected != 'All',
                          child: ActionChip(
                            disabledColor: Colors.grey,
                            label: Text('Close'),
                            onPressed: () {
                              Selected = 'All';
                              slidervalue = RangeValues(0, 5000);
                              mutable.notify();
                            },
                            avatar: Icon(Icons.close),
                          ),
                        ),
                        DropdownButton(
                            value: Selected,
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
                              Selected = '$val';
                              mutable.notify();
                            })
                      ]),
                  Row(
                    children: [
                      Text(
                        'From\n${slidervalue.start.toInt()}',
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: RangeSlider(
                            min: 0,
                            max: 5000,
                            divisions: 5000,
                            values: slidervalue,
                            onChanged: (val) {
                              slidervalue = val;
                              mutable.notify();
                            }),
                      ),
                      Text(
                        'To\n${slidervalue.end.toInt()}',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  //Products
                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2 / 3),
                      itemBuilder: (context, index) =>
                          mutable.allProducts[index].category == Selected &&
                                  mutable.allProducts[index].price >=
                                      slidervalue.start &&
                                  mutable.allProducts[index].price <=
                                      slidervalue.end
                              ? allCategoryProduct(
                                  context: context,
                                  index: index,
                                  size: size,
                                  mutable: mutable,
                                  Selected: Selected)
                              : Selected == 'All' &&
                                      mutable.allProducts[index].price >=
                                          slidervalue.start &&
                                      mutable.allProducts[index].price <=
                                          slidervalue.end
                                  ? allProduct(
                                      context: context,
                                      index: index,
                                      size: size,
                                      mutable: mutable,
                                      slidervalue: slidervalue)
                                  : Container(),
                      itemCount: mutable.allProducts.length,
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _bottomNavIndex {}

// GestureDetector(
// onTap: () {
// Navigator.pushNamed(context, AppRoutes.detailPage,
// arguments: index);
// },
// child: Stack(
// children: [
// Container(
// padding: const EdgeInsets.all(10),
// height: size.height * 0.4,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: Colors.grey.shade400,
// offset: const Offset(3, 3),
// blurRadius: 4,
// ),
// ]),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Expanded(
// child: Image.network(
// mutable.allProducts[index].thumbnail,
// fit: BoxFit.cover,
// ),
// ),
// Text(
// mutable.allProducts[index].title,
// maxLines: 1,
// overflow: TextOverflow.ellipsis,
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// Text(
// mutable.allProducts[index].description,
// style:
// const TextStyle(color: Colors.grey),
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// ),
// Text(
// '${mutable.allProducts[index].price} \$',
// style: TextStyle(
// color: Colors.green.shade400,
// fontSize: 20,
// fontWeight: FontWeight.bold),
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// ),
// RatingBar.builder(
// initialRating:
// mutable.allProducts[index].rating,
// minRating: 1,
// direction: Axis.horizontal,
// allowHalfRating: true,
// itemCount: 5,
// itemBuilder: (context, _) => const Icon(
// Icons.star,
// color: Colors.amber,
// ),
// itemSize: size.height * 0.025,
// onRatingUpdate: (rating) {},
// ),
// ],
// ),
// ),
// Container(
// padding: const EdgeInsets.only(left: 2, top: 2),
// height: size.height * 0.03,
// width: size.width * 0.1,
// decoration: const BoxDecoration(
// color: Colors.red,
// borderRadius: BorderRadiusDirectional.only(
// topStart: Radius.circular(10),
// ),
// ),
// child: Text(
// textAlign: TextAlign.center,
// '${mutable.allProducts[index].discountPercentage}%',
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// color: Colors.yellow,
// fontSize: 12,
// ),
// ),
// ),
// ],
// ),
// ),
