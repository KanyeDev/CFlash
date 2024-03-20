
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utility/skeleton.dart';

Shimmer subjectShimmerLoading(double height, double width){
  return  Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child:  Skeleton(
    height: height,
    width: width,
    radius: 12.49,
  ));
}
