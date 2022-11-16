library app_constants;
import 'package:flutter/material.dart';



const kEmailDomain = "@simpleInvoice.com";
const kBorderRadius = 16.0;
const kTimeBorderRadius = 4.0;
const kSpacing = 16.0;
const kBoxCornerRadius = 18.0;
const kTextFieldWidth = 100.0;
const double kDefaultPadding = 20.0;
const double kMainButtonWidth = 100;
const double kMainButtonHeight = 120;
const double kMinCardHeight = 120;
const double kMainFontSize = 50;
const double kFontSize = 22;
const double kMainButtonFontSize = 32;
const double kAppbarHeight = 80;
const double kProfileAppbarHeight = 150;


const kFontColorPallets = [
  Color.fromRGBO(84, 82, 91, 1),
  Color.fromRGBO(108, 107, 112, 1),
  Color.fromRGBO(173, 178, 188, 1),
];
const kNavBarHeight = 56.0;
const kSlideWidgetHeight = 110.0;
const kBlackColor = Color(0xFF101010);
const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFF5A5A5A);
const kItemBackgroundColor = Color(0XFFF4F4F4);

const kPrimaryColor = Color(0xFF16677a);
const kPrimaryColorBrighter = Color(0xFFE3F6FA);

const kPrimarySwatch = MaterialColor(0xFFF04E23, {
  50:Color(0xFF16677a),
  100:Color(0xFF16677a),
  200:Color(0xFF16677a),
  300:Color(0xFF16677a),
  400:Color(0xFF16677a),
  500:Color(0xFF16677a),
  600:Color(0xFF16677a),
  700:Color(0xFF16677a),
  800:Color(0xFF16677a),
  900:Color(0xFF16677a),
});
const kCanvasColor = Colors.white;
const kAppBarTheme = AppBarTheme(backgroundColor: Color(0xFF16677a), titleTextStyle: TextStyle(color: kCanvasColor, fontSize: kFontSize), elevation: 0, iconTheme:  IconThemeData(
  color: kPrimaryColor, //change your color here
),),
    kInputDecorationTheme = InputDecorationTheme(
      fillColor: Colors.transparent,
      // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
      // fillColor: Color.fromRGBO(246, 246, 246, 1),
      labelStyle: TextStyle(color: kBlackColor)
    );
const kIconTheme = IconThemeData(
  color: kPrimaryColor,
);

const kContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
  color: Colors.white,

);

const kMainTextFieldDecoration =   InputDecoration(
    fillColor: Color(0xbbffffff),
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 18.0),
    border:OutlineInputBorder(
      borderSide: BorderSide(color:  Color(0x5516677a)),
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0x5516677a)),
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0x5516677a)),
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    hintStyle: TextStyle()
);

const kTimeTextFieldDecoration =   InputDecoration(
    fillColor: Color(0xbbffffff),
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
    border:OutlineInputBorder(
      borderSide: BorderSide(color:  Color(0x5516677a)),
      borderRadius: BorderRadius.all(Radius.circular(kTimeBorderRadius)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0x5516677a)),
      borderRadius: BorderRadius.all(Radius.circular(kTimeBorderRadius)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0x5516677a)),
      borderRadius: BorderRadius.all(Radius.circular(kTimeBorderRadius)),
    ),
    hintStyle: TextStyle()
);

const kTextFieldDecoration = InputDecoration(
  fillColor: Color(0xffffffff),
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
  border:OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffffffff)),
    borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffffffff)),
    borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
  ),

  hintStyle: TextStyle()
);

const kCardTopCornerDecoration = BoxDecoration(
borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
),
);
