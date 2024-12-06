import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
Widget shimmerEffect_1(){
  return Shimmer.fromColors( 
    period: Duration(milliseconds: 1000),
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade200,
    enabled: true,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
    ),
  );
}

Widget shimmerEffect_2(context){
  return Shimmer.fromColors(
    period: Duration(milliseconds: 1000),
    baseColor: const Color.fromARGB(255, 228, 227, 227),
    highlightColor:  Colors.white,
    enabled: true,
    child: Container(
      width:MediaQuery.of(context).size.width,
  height:190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
    ),
  );
}