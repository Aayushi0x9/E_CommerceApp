import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:e_commerce_app/utils/app_routes_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ProductController mutable = Provider.of<ProductController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Cart Products'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...List.generate(
                  mutable.cartProducts.length,
                  (index) => Slidable(
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
                                  mutable.cartProducts.remove(
                                    mutable.cartProducts[index],
                                  );
                                  mutable.notify();
                                }),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          height: size.height * 0.2,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: const Offset(3, 3),
                                  blurRadius: 5,
                                ),
                              ]),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Image.network(
                                  mutable.cartProducts[index].thumbnail,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${mutable.cartProducts[index].title}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
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
                                    Text(
                                      mutable.allProducts[index].returnPolicy,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      height: size.height * 0.05,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                mutable.cartProducts[index].id =
                                                    0;
                                                if (mutable.cartProducts[index]
                                                        .id <
                                                    mutable.cartProducts[index]
                                                        .stock) {
                                                  mutable
                                                      .cartProducts[index].id++;
                                                }
                                              },
                                              icon: const Icon(
                                                  CupertinoIcons.plus_circle)),
                                          Text(
                                            '${mutable.cartProducts[index].id}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                int n = mutable
                                                    .cartProducts[index].id = 0;
                                                if (n > 1) {
                                                  n--;
                                                }
                                              },
                                              icon: const Icon(
                                                  CupertinoIcons.minus_circle)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
