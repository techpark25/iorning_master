// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class CategoryImage extends StatelessWidget {
//   const CategoryImage({
//     super.key,
//     this.imageUrl,
//   });

//   final String? imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     const double padding = 16;
//     final double width = MediaQuery.of(context).size.width;
//     final cardWidth = (width / 2) - padding - padding / 2;
//     final imageSize = cardWidth - 4;
//     return imageUrl != null
//         ? SizedBox(
//             width: imageSize,
//             height: imageSize,
//             child: CachedNetworkImage(
//               imageUrl: imageUrl!,
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           )
//         : Container(color: Colors.grey);
//   }
// }
