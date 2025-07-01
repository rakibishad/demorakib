import 'package:flutter/material.dart';


import 'colors.dart';

TextStyle textStyleBold = const TextStyle(
    decoration: TextDecoration.none,
    color: MyColor.darkGrey,
    fontWeight: FontWeight.w700,
    fontFamily: 'Sans',
    overflow: TextOverflow.ellipsis,
    fontSize: 17);

TextStyle textStyleNormal = const TextStyle(
    decoration: TextDecoration.none,
    color: MyColor.darkGrey,
    fontWeight: FontWeight.w600,
    fontFamily: 'Medium',
    overflow: TextOverflow.ellipsis,
    fontSize: 17);

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  borderSide: BorderSide(color: Colors.grey, width: 1),
);

OutlineInputBorder outlineInputBorderRed = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  borderSide: BorderSide(color: Colors.red, width: 1),
);
