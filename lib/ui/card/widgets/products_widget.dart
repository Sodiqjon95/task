import 'package:flutter/material.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';




class ProductButton extends StatelessWidget {
  const ProductButton({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.salary,
    required this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final double salary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0, // soften the shadow//extend the shadow
                offset: Offset(
                  5.0, // Move to right 10  horizontally
                  5.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.scaleDown,
                  width: 120,
                  height: 150,
                  placeholder: (context, url) {
                    return Shimmer.fromColors(
                      baseColor: Theme.of(context).splashColor,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(color: Colors.blueGrey),
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      name,
                      textAlign: TextAlign.justify,
                      style: MyTextStyle.sfBold800.copyWith(
                        color: MyColors.textColor,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "sotuvda: bor",
                    style: MyTextStyle.sfProSemibold.copyWith(color: MyColors.textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      "narxi: ${salary.toString()}",
                      style: MyTextStyle.sfProSemibold.copyWith(color: MyColors.textColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
