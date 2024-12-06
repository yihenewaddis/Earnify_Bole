import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:cached_network_image/cached_network_image.dart';
Widget imageEnhanced(url){
  return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child:CachedNetworkImage(
                  imageUrl:url ,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => shimmerEffect_1(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
            );
}