import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
    required this.bgColor,
    required this.iconPress,
  }) : super(key: key);
  final String? image, title;
  final VoidCallback? press;
  final double? price;
  final Color bgColor;
  final VoidCallback? iconPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(12.0)),
                        image: DecorationImage(
                          image: NetworkImage('$image'),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        "₺$price",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 1,
            child: IconButton(
              onPressed: iconPress,
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  "assets/icons/Heart.svg",
                  height: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}