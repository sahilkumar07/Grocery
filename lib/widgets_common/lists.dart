import 'package:grocery/images.dart';


const socialIconList = [icFacebookLogo, icGoogleLogo, icTwitterLogo];
class Item {
  final String image;
  final String originalPrice;
  final String discountedPrice;
  final String discount;

  Item({
    required this.image,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discount,
  });
}