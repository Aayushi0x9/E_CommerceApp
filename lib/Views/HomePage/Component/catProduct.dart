import 'package:e_commerce_app/utils/app_routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget allProduct(
    {required BuildContext context,
    required index,
    required Size size,
    required mutable}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, AppRoutes.detailPage, arguments: index);
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                initialRating: mutable.allProducts[index].rating,
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
  );
}
