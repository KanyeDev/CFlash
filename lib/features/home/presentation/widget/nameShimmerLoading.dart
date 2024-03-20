import '../../../../core/utility/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


Shimmer nameShimmerLoading(){
  return  Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child: const Skeleton(
    height: 54.95,
    width: 103.24,
    radius: 12.49,
  ));

}
