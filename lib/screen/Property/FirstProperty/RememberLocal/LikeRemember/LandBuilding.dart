// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import '../../../../../Comparable/map/Comparable_search_map.dart';

// import '../../component/Model/FavoriteModel.dart';

// class Favorites extends StatefulWidget {
//   const Favorites({
//     super.key,
//     required this.listback,
//     required this.list,
//   });
//   final OnChangeCallback listback;
//   final List list;

//   @override
//   State<Favorites> createState() => _LandBuildingState();
// }

// class _LandBuildingState extends State<Favorites> {
//   List list = [];
//   String? userID;
//   int? idptys;
//   int? like;

//   List<FavoriteModel> lb = [FavoriteModel('', 0, 0)];
//   void addItemToList() {
//     setState(() {
//       if (widget.list == []) {
//         list.add({
//           "UserID": userID,
//           "id_ptys": idptys,
//           "like": like,
//         });
//         lb.add(
//           FavoriteModel(
//             userID,
//             idptys,
//             like,
//           ),
//         );
//       } else {
//         widget.list.add({
//           "UserID": userID,
//           "id_ptys": idptys,
//           "like": like,
//         });
//         lb.add(
//           FavoriteModel(
//             userID,
//             idptys,
//             like,
//           ),
//         );
//       }
//     });
//   }

//   @override
//   void initState() {
//     widget.list != list;
//     super.initState();
//   }

//   int i = 1;

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox();
//   }
// }
