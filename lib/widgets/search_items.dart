// import 'package:flutter/material.dart';
// import 'package:foodboard_application/utils/colors.dart';
// import 'package:foodboard_application/widgets/app_icon.dart';
// import 'package:foodboard_application/widgets/big_text.dart';
// import 'package:foodboard_application/widgets/small_text.dart';



// class SearchItems extends StatelessWidget {
//   const SearchItems({Key? key, required this.model}) : super(key: key);

  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//       ),
//       height: 210,
//       width: 165,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               height: 120,
//               width: 165,
//               child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20.0),
//                       topRight: Radius.circular(20.0)),
//                   child: Image.network(model.imgUrl.toString(),
//                       fit: BoxFit.cover)),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0),
//                 ),
//               )),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 BigText(
//                   text: model.food.toString(),
//                   size: 18,
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Row(children: [
//                   // ignore: prefer_const_constructors
//                   Icon(
//                     Icons.account_circle,
//                     size: 18,
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   SmallText(
//                     text: model.restorant.toString(),
//                     size: 14,
//                     color: const Color(0xFF332d2b),
//                   )
//                 ]),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.access_time_filled_sharp,
//                             color: AppColors.navIconColor, size: 18),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         SmallText(
//                           text: model.note.toString(),
//                           color: const Color(0xFF332d2b),
//                           size: 14,
//                         )
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.star, color: Colors.yellow[600], size: 18),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         SmallText(
//                           text: model.time.toString(),
//                           color: const Color(0xFF332d2b),
//                           size: 14,
//                         )
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
