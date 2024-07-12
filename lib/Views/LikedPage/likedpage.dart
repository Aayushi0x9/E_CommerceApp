import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:e_commerce_app/utils/app_routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ProductController mutable = Provider.of<ProductController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Liked Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.Homepage, (route) => true);
            },
            icon: const Icon(Icons.home_filled),
          ),
          SizedBox(
            width: size.width * 0.025,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3),
          itemCount: mutable.likedProducts.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.detailPage,
                  arguments: index);
            },
            child: Slidable(
              endActionPane: ActionPane(
                motion: BehindMotion(),
                children: [
                  SlidableAction(
                      backgroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      icon: Icons.delete,
                      label: 'Delete',
                      foregroundColor: Colors.white,
                      onPressed: (context) {
                        mutable.likedProducts.remove(
                          mutable.likedProducts[index],
                        );
                        mutable.notify();
                      }),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
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
                            mutable.likedProducts[index].thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          mutable.likedProducts[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          mutable.likedProducts[index].description,
                          style: TextStyle(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${mutable.likedProducts[index].price} \$',
                          style: TextStyle(
                              color: Colors.green.shade400,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating:
                                  mutable.likedProducts[index].rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemSize: size.height * 0.025,
                              onRatingUpdate: (ra) {},
                            ),
                            IconButton(
                              onPressed: () {
                                mutable.likedProducts
                                        .contains(mutable.allProducts[index])
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text('Remove from Favourite!'),
                                        backgroundColor: Colors.red,
                                      ))
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        const SnackBar(
                                          content: Text('Added to Favourite!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                mutable.likedProducts
                                        .contains(mutable.allProducts[index])
                                    ? mutable.likedProducts
                                        .remove(mutable.allProducts[index])
                                    : mutable.likedProducts
                                        .add(mutable.allProducts[index]);
                                // mutable.notify();
                              },
                              icon: Icon(
                                Icons.favorite_rounded,
                              ),
                              color: mutable.likedProducts
                                      .contains(mutable.allProducts[index])
                                  ? Colors.red
                                  : Colors.black54,
                            ),
                          ],
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
                      '${mutable.likedProducts[index].discountPercentage}%',
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
      ),
    );
  }
}
// Container(
// margin: const EdgeInsets.only(bottom: 12),
// height: size.height * 0.2,
// width: size.width,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: Colors.grey.shade400,
// offset: const Offset(3, 3),
// blurRadius: 5,
//
// ),
// ]),
// padding: const EdgeInsets.all(10),
// child: Row(
// children: [
// Expanded(
// flex: 2,
// child: Image.network(
// mutable.likedProducts[index].thumbnail,
// ),
// ),
// Expanded(
// flex: 3,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// '${mutable.likedProducts[index].title}',
// maxLines: 1,
// overflow: TextOverflow.ellipsis,
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// Text(
// '${mutable.likedProducts[index].price} \$',
// style: TextStyle(
// color: Colors.green.shade400,
// fontSize: 20,
// fontWeight: FontWeight.bold),
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// ),
// Text(
// mutable.likedProducts[index].returnPolicy,
// style:
// const TextStyle(color: Colors.grey),
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// ),
// SizedBox(height: size.height * 0.01),
// ],
// ),
// )
// ],
// ),
// ),
